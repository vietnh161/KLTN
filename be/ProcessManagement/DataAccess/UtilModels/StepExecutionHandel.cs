﻿using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace DataAccess.UtilModels
{
    public class StepExecutionHandel
    {
        public ProcessStep CurrentStep { get; set; }
        public List<StepExecution> ListStep { get; set; }


    }
}