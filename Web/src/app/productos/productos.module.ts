import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ProductosRoutingModule } from './productos-routing.module';
import { ProductosComponent } from './vistas/productos/productos.component';
import { MaterialModule } from 'src/material/material.module';
import { AddproducComponent } from './vistas/addproduc/addproduc.component';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [ProductosComponent, AddproducComponent],
  entryComponents:[AddproducComponent],
  imports: [
    CommonModule,
    ProductosRoutingModule,
    MaterialModule,
    FormsModule
  ]
})
export class ProductosModule { }
