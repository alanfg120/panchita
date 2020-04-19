import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PedidosRoutingModule } from './pedidos-routing.module';
import { PedidosComponent } from './vistas/pedidos/pedidos.component';
import { MaterialModule } from 'src/material/material.module';



@NgModule({
  declarations: [PedidosComponent],
  imports: [
    CommonModule,
    PedidosRoutingModule,
    MaterialModule
  ]
})
export class PedidosModule { }
