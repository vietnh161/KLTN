import { Component, ElementRef, EventEmitter, Input, OnInit, Output, ViewChild } from '@angular/core';
import { FormMode } from '../../../../../enums/form-mode.enum';
import { StepField } from '../../../../../models/step-field';
import * as _ from "lodash";
import { FieldType } from '../../../../../enums/field-type.enum';

@Component({
  selector: 'ngx-field-setting',
  templateUrl: './field-setting.component.html',
  styleUrls: ['./field-setting.component.scss']
})
export class FieldSettingComponent implements OnInit {


  _fieldData
  @Input()
  get fieldData() {
    return this._fieldData;
  }
  set fieldData(value) {
    if(value){
      this._fieldData = _.cloneDeep(value);
      this.prepareData();
    }
  }

  @Input() readonly = true;


  listNewField = [];

  newField = new StepField();

  @Output() onSave: EventEmitter<any> = new EventEmitter<any>();
  @Output() onCancel: EventEmitter<any> = new EventEmitter<any>();

  formModeEnum = FormMode;

  isShowInputStepField = false;

  isShowFormAddField = false;

  @ViewChild('inputFieldName') inputFieldName: ElementRef;


  constructor() { }

  ngOnInit(): void {
    this.prepareData();
  }

  prepareData() {
    if (this.fieldData) {
      this.fieldData.forEach(x => {
        x.DataSettingObj = JSON.parse(x.DataSetting);
      })

      this.listNewField = _.cloneDeep(this.fieldData);

    }

    this.isShowInputStepField = false;

    this.isShowFormAddField = false;
  
  }

  showFormAddField() {
    this.isShowFormAddField = true;
  }

  addNewField(e) {
    if(this.readonly){
      return;
    }
    this.newField = e;
    this.newField.DataSetting = JSON.stringify(e.DataSettingObj);
    this.listNewField.push(e);
    this.newField = new StepField();
  }

  cancelAddField() {
    this.isShowFormAddField = false;
    this.newField = new StepField();
  }

  save() {
    this.onSave.emit(this.listNewField);
    this.isShowFormAddField = false;
  }
  cancel() {
    this.onCancel.emit();
    this.isShowFormAddField = false;
    this.listNewField = _.cloneDeep(this.fieldData);
  }

  delField(field){
    if(this.readonly){
      return;
    }
    field.State = 3;

  }

  editField(field) {
    if(this.readonly){
      return;
    }
    field.IsInEdit = true;
  }

  cancelEditField(field) {
    field.IsInEdit = false;

  }

  updateField(field, event) {
    field.FieldName = event.FieldName;
    field.Description = event.Description;
    field.IsRequired = event.IsRequired;
    field.Type = event.Type;
    field.DataSetting = JSON.stringify(event.DataSettingObj);
    field.DataSettingObj = event.DataSettingObj;

    field.IsInEdit = false;
  }
}
