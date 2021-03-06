import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NbButtonGroupModule, NbButtonModule, NbButtonToggleDirective, NbCardModule, NbFormFieldModule, NbIconModule, NbInputModule } from '@nebular/theme';
import { NgxDatatableModule } from '@swimlane/ngx-datatable';
import { ThemeModule } from '../../../@theme/theme.module';
import { ListProcessDoneComponent } from './list-process-done.component';



@NgModule({
  declarations: [ListProcessDoneComponent],
  imports: [
    CommonModule,
    NbCardModule,
    NbIconModule,
    NbInputModule,
    ThemeModule,
    NbButtonModule,
    NgxDatatableModule,
    NbFormFieldModule,
    NbButtonGroupModule
  ]
})
export class ListProcessDoneModule { }
