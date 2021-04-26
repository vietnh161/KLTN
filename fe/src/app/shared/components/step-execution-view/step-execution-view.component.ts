import { ChangeDetectionStrategy, Component, EventEmitter, Input, OnInit, Output, TemplateRef } from '@angular/core';
import { NbDialogService } from '@nebular/theme';
import { ProcessExecution } from '../../../models/process-exe';
import { ProcessExecutionService } from '../../../services/process-exe.service';
import { ProcessService } from '../../../services/process.service';

@Component({
  selector: 'ngx-step-execution-view',
  templateUrl: './step-execution-view.component.html',
  styleUrls: ['./step-execution-view.component.scss'],
})
export class StepExecutionViewComponent implements OnInit {

  @Input() processId;

  @Input() fistStep = false;

  @Output() onBack = new EventEmitter();

  listPrevStep;

  isLoading = false;
  isLoadingAssignee = false;
  step;

  listAssignee;

  assingeeID;
  errAssignee = false;

  loadingDetailStep = false;
  currentDetailStep;

  newProcessExe = new ProcessExecution();

  stepExeData = {

  };

  constructor(
    private processSV: ProcessService,
    private processExeSV: ProcessExecutionService,
    private dialogService: NbDialogService,
  ) { }

  ngOnInit(): void {
    if (this.fistStep) {

      this.getFirstStep();
    } else {
      this.getStepExecution();
    }
  }


  getFirstStep() {
    this.isLoading = true;

    this.processSV.getFirstStep(this.processId).subscribe(data => {
      if (data && data.Data) {
        this.step = data.Data;
        if (this.step.StepFields) {
          this.step.StepFields.forEach(x => {
            x.DataSettingObj = JSON.parse(x.DataSetting);
          })
        }
      }
      this.isLoading = false;
    });
  }

  getStepExecution() {
    this.isLoading = true;

    this.processExeSV.getStepExecution(this.processId).subscribe(data => {
      if (data && data.Data) {
        this.step = data.Data.CurrentStep;
        this.listPrevStep = data.Data.ListStep;
        if (this.step && this.step.StepFields) {
          this.step.StepFields.forEach(x => {
            x.DataSettingObj = JSON.parse(x.DataSetting);
          })
        }
      }
      this.isLoading = false;
    });
  }

  backToProcess() {
    this.onBack.emit();
  }


  resetError() {
    this.errAssignee = false;
  }
  openSelectAssignee(dialog: TemplateRef<any>) {
    this.dialogService.open(dialog);
    this.getAssigne();

  }

  nextStep(ref) {
    if (!this.assingeeID) {
      this.errAssignee = true;
      return;
    }
    let data = [];

    this.step.StepFields?.forEach(field => {
      data.push(field.FieldValue)
    });

    const dataReq = {
      ProcessSettingId: this.step.ProcessId,
      ProcessStepId: this.step.ProcessStepId,
      AssigneeId: this.assingeeID,
      StepExecutionData: JSON.stringify(data)
    }

    this.processExeSV.initProcessExe(dataReq).subscribe(data => {
      if (data && data.Data) {
        ref.close();
      }
    });

  }

  refuseStep() {

  }


  doneProcess(ref){
    let data = [];

    this.step.StepFields?.forEach(field => {
      data.push(field.FieldValue)
    });

    const dataReq = {
      ProcessSettingId: this.step.ProcessId,
      ProcessStepId: this.step.ProcessStepId,
      AssigneeId: this.assingeeID,
      StepExecutionData: JSON.stringify(data),
      ProcessExeId: this.listPrevStep[0].ProcessExecutionId,
    }

    this.processExeSV.nextStep(dataReq).subscribe(data => {
      if (data && data.Data) {
        ref.close();
      }
    });
  }

  getAssigne() {
    this.isLoadingAssignee = true;
    this.processSV.getListAssignee(this.step).subscribe(data => {
      if (data && data.Data) {
        this.listAssignee = data.Data;
      }
      this.isLoadingAssignee = false;
    });



  }


  showDetailStepPrev(dialog, item){
    this.dialogService.open(dialog);
    this.loadingDetailStep = true;
    this.processSV.getStepById(item.ProcessStepId).subscribe(data => {
      if (data && data.Data) {
        this.currentDetailStep = data.Data;
        if (this.currentDetailStep.StepFields) {
          const fieldVal = JSON.parse(item.StepExecutionData);
          this.currentDetailStep.StepFields.forEach(x => {
            x.DataSettingObj = JSON.parse(x.DataSetting);
            x.FieldValue = fieldVal?.find(val => val.StepFieldId == x.StepFieldId);
          })
        }
      }

    this.loadingDetailStep = false;

    });
  }
}