import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { VendedoresRoutingModule } from './vendedores-routing.module';
import { VendedoresComponent } from './vistas/vendedores/vendedores.component';
import { MaterialModule } from 'src/material/material.module';
import { AddvendedorComponent } from './vistas/addvendedor/addvendedor.component';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [VendedoresComponent, AddvendedorComponent],
  entryComponents:[AddvendedorComponent],
  imports: [
    CommonModule,
    VendedoresRoutingModule,
    MaterialModule,
    FormsModule
  ]
})
export class VendedoresModule { }
