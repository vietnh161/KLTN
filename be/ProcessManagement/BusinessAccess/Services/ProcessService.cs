﻿using DataAccess.Enums;
using DataAccess.Infrastructure;
using DataAccess.Models;
using DataAccess.UtilModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Newtonsoft.Json;
using MoreLinq;

namespace BusinessAccess.Services
{
    public interface IProcessService
    {

        ServiceResponse GetStepByID(int? processID, int processStepID);
        ServiceResponse Add(Process process, int currentUserID, string currentUsername);
        ServiceResponse Update(Process process, int currentUserID, string currentUsername);
        ServiceResponse Delete(int id);
        ServiceResponse GetAll();
        ServiceResponse GetMulti(Expression<Func<Process, bool>> predicate);

        ServiceResponse GetAllStepByProcessID(int processID);
        ServiceResponse GetFirstStep(int processID);

        ServiceResponse GetAllProcessGroup();


        ServiceResponse AddStep(ProcessStep processStep, int currentUserID, string currentUsername);
        ServiceResponse GetStepById(int processStepId);

        ServiceResponse UpdateStep(ProcessStep processStep, int currentUserID, string currentUsername);

        ServiceResponse GetListAssignee(ProcessStep processStep);
        ServiceResponse DeleteStep(int stepId);

        ServiceResponse GetMultiPaging(Paging paging, string[] includes = null);


        void Save();

    }


    public class ProcessService : IProcessService
    {
        IRepository<Process> _processRepository;
        IRepository<ProcessGroup> _processGroupRepository;
        IRepository<ProcessStep> _stepRepository;
        IRepository<StepTask> _taskRepository;
        IRepository<StepField> _fieldRepository;
        IRepository<UserInfor> _userInforRepository;
        IRepository<StepAssignee> _assigneeRepository;
        IUnitOfWork unitOfWork;


        public ProcessService(IRepository<Process> processRepository, IRepository<ProcessGroup> processGroupRepository,
            IRepository<ProcessStep> stepRepository, IRepository<StepTask> taskRepository,
        IRepository<StepField> fieldRepository, IRepository<StepAssignee> assigneeRepository, IRepository<UserInfor> userInforRepository, IUnitOfWork unitOfWork)
        {
            this._processRepository = processRepository;
            this._processGroupRepository = processGroupRepository;
            this._stepRepository = stepRepository;
            this._userInforRepository = userInforRepository;
            this._taskRepository = taskRepository;
            this._fieldRepository = fieldRepository;
            this._assigneeRepository = assigneeRepository;
            this.unitOfWork = unitOfWork;
        }

        public ServiceResponse Add(Process process, int currentUserID, string currentUsername)
        {
            ServiceResponse res = new ServiceResponse();
            if (process == null || (process != null && process.ProcessName == null) || (process != null && process.ProcessGroupId == null))
            {
                res.OnError("Data empty");
                return res;
            }

            TimeZone localZone = TimeZone.CurrentTimeZone;
            DateTime now = DateTime.Now;

            process.ProcessStatus = (int)ProcessStatus.Draf;
            process.CreatedBy = currentUsername;
            process.CreatedDate = localZone.ToUniversalTime(now);
            process.ModifiedBy = currentUsername;
            process.ModifiedDate = localZone.ToUniversalTime(now);

            var processRes = _processRepository.Add(process);
            this.Save();
            res.OnSuccess(processRes);

            return res;
        }

        public ServiceResponse Delete(int id)
        {
            throw new NotImplementedException();
        }

        public ServiceResponse GetAll()
        {
            ServiceResponse res = new ServiceResponse();
            var listProcess = _processRepository.GetAll();
            res.OnSuccess(listProcess);
            return res;
        }

        public ServiceResponse GetAllProcessGroup()
        {

            ServiceResponse res = new ServiceResponse();
            var listProcessGroup = _processGroupRepository.GetAll();
            res.OnSuccess(listProcessGroup);
            return res;
        }



        public ServiceResponse GetMulti(Expression<Func<Process, bool>> predicate)
        {
            ServiceResponse res = new ServiceResponse();
            string[] includes = new string[1] { "ProcessGroup" };
            var listProcess = _processRepository.GetMulti(predicate, includes);
            res.OnSuccess(listProcess);
            return res;
        }

        public ServiceResponse GetMultiPaging(Paging paging, string[] includes = null)
        {

            ServiceResponse res = new ServiceResponse();
            IEnumerable<Process> query = null;
            PagingResult data = new PagingResult();

            if (paging == null)
            {
                res.OnError("Data truyền lên rỗng");
                return res;
            }


            var status = paging.ExtraCondition.Status;


            if (!String.IsNullOrEmpty(paging.FilterString))
            {
                if (status == null ||  status == 0)
                {
                    query = _processRepository.GetMulti(x => x.ProcessName.ToUpper().Contains(paging.FilterString.ToUpper()) ||
                    x.Description.ToUpper().Contains(paging.FilterString.ToUpper()) || x.CreatedBy.ToUpper().Contains(paging.FilterString.ToUpper()), includes);
                }
                else
                {
                    query = _processRepository.GetMulti(x => x.ProcessStatus == status && (x.ProcessName.ToUpper().Contains(paging.FilterString.ToUpper()) ||
                   x.Description.ToUpper().Contains(paging.FilterString.ToUpper()) || x.CreatedBy.ToUpper().Contains(paging.FilterString.ToUpper())), includes);
                }



                if (query == null)
                {
                    res.OnSuccess(data);
                    return res;
                }
            }
            else
            {
                if (status == null ||status == 0)
                {
                    query = _processRepository.GetAll(includes);
                }
                else
                {
                    query = _processRepository.GetMulti(x => x.ProcessStatus == status, includes);
                }

            }

            if (!String.IsNullOrEmpty(paging.SortBy))
            {
                var propertyInfo = typeof(Process).GetProperty(paging.SortBy);
                if (paging.Sort != null && (paging.Sort.ToUpper().Equals("DESC") || paging.Sort.Equals(null)))
                {
                    query = query.OrderByDescending(x => propertyInfo.GetValue(x, null));
                }
                else
                {

                    query = query.OrderBy(x => propertyInfo.GetValue(x, null));
                }
            }
            data.TotalRecord = query.Count();
            data.PageData = query.Skip((paging.CurrentPage - 1) * paging.PageSize).Take(paging.PageSize);
            res.OnSuccess(data);
            return res;

        }

        public void Save()
        {
            unitOfWork.Commit();
        }

        public ServiceResponse Update(Process process, int currentUserID, string currentUsername)
        {
            ServiceResponse res = new ServiceResponse();
            if (process == null || (process != null && process.ProcessName == null) || (process != null && process.ProcessGroupId == null))
            {
                res.OnError("Data empty");
                return res;
            }

            TimeZone localZone = TimeZone.CurrentTimeZone;
            DateTime now = DateTime.Now;
            process.CreatedBy = currentUsername;
            process.CreatedDate = localZone.ToUniversalTime(now);
            process.ModifiedBy = currentUsername;
            process.ModifiedDate = localZone.ToUniversalTime(now);

            process.ProcessGroup = null;
            process.ProcessExecutions = null;
            process.ProcessSteps = null;

            _processRepository.Update(process);
            this.Save();
            res.OnSuccess(process);

            return res;
        }


        #region step
        public ServiceResponse GetAllStepByProcessID(int processID)
        {
            ServiceResponse res = new ServiceResponse();
            string[] includes = new string[1] { "ProcessSteps" };
            var data = _processRepository.GetSingleByCondition(x => x.ProcessId == processID, includes);
            if (data != null && data.ProcessSteps != null && data.ProcessSteps.Count > 0)
            {
                var firstStep = data.ProcessSteps.First();
                var firstStepDetail = GetProcessStepByID(firstStep.ProcessStepId);
                firstStep = firstStepDetail;
            }
            res.OnSuccess(data);
            return res;
        }





        public ServiceResponse GetStepByID(int? processID, int processStepID)
        {
            ServiceResponse res = new ServiceResponse();
            string[] includes = new string[5] { "StepAssignees", "StepFields", "StepTasks", "StepAssignees.User", "StepAssignees.UserGroup" };
            var data = _stepRepository.GetSingleByCondition(x => x.ProcessStepId == processStepID, includes);
            // var data = _stepRepository.GetDetailSingle(x => x.ProcessStepId == processStepID);

            if (data != null && data.ProcessId == processID)
            {
                res.OnSuccess(data);
            }
            else
            {
                res.OnError("Không có dữ liệu");
            }
            return res;
        }

        protected ProcessStep GetProcessStepByID(int processStepID)
        {

            string[] includes = new string[3] { "StepAssignees", "StepFields", "StepTasks" };
            var data = _stepRepository.GetSingleByCondition(x => x.ProcessStepId == processStepID, includes);


            return data;
        }

        public ServiceResponse AddStep(ProcessStep processStep, int currentUserID, string currentUsername)
        {
            ServiceResponse res = new ServiceResponse();
            if (processStep == null || (processStep != null && processStep.ProcessStepName == null))
            {
                res.OnError("Data empty");
                return res;
            }

            TimeZone localZone = TimeZone.CurrentTimeZone;
            DateTime now = DateTime.Now;

            processStep.CreatedBy = currentUsername;
            processStep.CreatedDate = localZone.ToUniversalTime(now);
            processStep.ModifiedBy = currentUsername;
            processStep.ModifiedDate = localZone.ToUniversalTime(now);

            var processRes = _stepRepository.Add(processStep);
            this.Save();
            res.OnSuccess(processRes);

            return res;
        }

        public ServiceResponse UpdateStep(ProcessStep processStep, int currentUserID, string currentUsername)
        {
            ServiceResponse res = new ServiceResponse();
            if (processStep == null || (processStep != null && processStep.ProcessStepName == null))
            {
                res.OnError("Data empty");
                return res;
            }

            TimeZone localZone = TimeZone.CurrentTimeZone;
            DateTime now = DateTime.Now;
            processStep.CreatedBy = currentUsername;
            processStep.CreatedDate = localZone.ToUniversalTime(now);
            processStep.ModifiedBy = currentUsername;
            processStep.ModifiedDate = localZone.ToUniversalTime(now);



            // xóa task có state = 3
            _taskRepository.DeleteRange(processStep.StepTasks.Where(x => x.State == 3 && x.TaskId != null && x.TaskId != 0).ToList());

            if (processStep.StepTasks != null && processStep.StepTasks.Count > 0)
            {
                var listDel = processStep.StepTasks.Where(x => x.State == 3).ToList();
                if (listDel != null && listDel.Count > 0)
                    foreach (var item in listDel)
                    {
                        processStep.StepTasks.Remove(item);
                    }
            }

            // xóa field có state = 3
            _fieldRepository.DeleteRange(processStep.StepFields.Where(x => x.State == 3 && x.StepFieldId != null && x.StepFieldId != 0).ToList());

            if (processStep.StepFields != null && processStep.StepFields.Count > 0)
            {
                var listDel = processStep.StepFields.Where(x => x.State == 3).ToList();
                if (listDel != null && listDel.Count > 0)
                    foreach (var item in listDel)
                    {
                        processStep.StepFields.Remove(item);
                    }
            }

            // xóa step assignee có state = 3
            _assigneeRepository.DeleteRange(processStep.StepAssignees.Where(x => x.State == 3 && x.StepAssingeeId != null && x.StepAssingeeId != 0).ToList());

            if (processStep.StepAssignees != null && processStep.StepAssignees.Count > 0)
            {
                var listDel = processStep.StepAssignees.Where(x => x.State == 3).ToList();
                if (listDel != null && listDel.Count > 0)
                    foreach (var item in listDel)
                    {
                        processStep.StepAssignees.Remove(item);
                    }
            }


            _stepRepository.AddOrUpdate(processStep);


            this.Save();

            res = GetStepByID(processStep.ProcessId, processStep.ProcessStepId);

            return res;
        }

        public ServiceResponse DeleteStep(int stepId)
        {
            ServiceResponse res = new ServiceResponse();
            if (stepId == null || stepId == 0)
            {
                res.OnError("Data empty");
                return res;
            }


            var data = _stepRepository.Delete(stepId);
            this.Save();
            res.OnSuccess(data);

            return res;
        }

        public ServiceResponse GetFirstStep(int processID)
        {
            ServiceResponse res = new ServiceResponse();

            string[] includes = new string[5] { "StepAssignees", "StepFields", "StepTasks", "StepAssignees.User", "StepAssignees.UserGroup" };
            var data = _stepRepository.GetSingleByCondition(x => x.ProcessId == processID && x.SortOrder == 1, includes);

            if (data != null && data.ProcessId == processID)
            {
                res.OnSuccess(data);
            }
            else
            {
                res.OnError("Không có dữ liệu");
            }
            return res;
        }

        public ServiceResponse GetListAssignee(ProcessStep processStep)
        {
            ServiceResponse res = new ServiceResponse();


            var nextStep = _stepRepository.GetMulti(x => x.ProcessId == processStep.ProcessId && x.SortOrder > processStep.SortOrder)
                .OrderBy(x => x.SortOrder).First();

            string[] includes = new string[3] { "User", "UserGroup", "UserGroup.UserGroupDetails.User" };
            var data = _assigneeRepository.GetMulti(x => x.ProcessStepId == nextStep.ProcessStepId, includes);

            if (data != null)
            {
                var listUserRes = new List<UserInfor>();
                foreach (var item in data)
                {
                    if (item.User != null)
                    {
                        item.User.UserGroupDetails = null;
                        item.User.StepAssignees = null;
                        listUserRes.Add(item.User);
                    }
                    else if (item.UserGroup != null && item.UserGroup.UserGroupDetails != null && item.UserGroup.UserGroupDetails != null)
                    {
                        foreach (var userInGroup in item.UserGroup.UserGroupDetails)
                        {
                            if (userInGroup.User != null)
                            {
                                userInGroup.User.UserGroupDetails = null;
                                userInGroup.User.StepAssignees = null;
                                listUserRes.Add(userInGroup.User);
                            }
                        }
                    }
                }

                if (listUserRes != null)
                {
                    listUserRes = listUserRes.DistinctBy(x => x.UserId).ToList();
                }

                res.OnSuccess(listUserRes);
            }
            else
            {
                res.OnError("Không có dữ liệu");
            }
            return res;
        }

        public ServiceResponse GetStepById(int processStepId)
        {
            ServiceResponse res = new ServiceResponse();

            string[] includes = new string[5] { "StepAssignees", "StepFields", "StepTasks", "StepAssignees.User", "StepAssignees.UserGroup" };
            var data = _stepRepository.GetSingleByCondition(x => x.ProcessStepId == processStepId, includes);

            if (data != null)
            {
                res.OnSuccess(data);
            }
            else
            {
                res.OnError("Không có dữ liệu");
            }
            return res;
        }



        #endregion

    }

}