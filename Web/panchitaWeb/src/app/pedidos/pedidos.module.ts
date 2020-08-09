import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PedidosRoutingModule } from './pedidos-routing.module';
import { PedidosComponent } from './vistas/pedidos/pedidos.component';
import { MaterialModule } from 'src/material/material.module';
import { DetallepedidoComponent } from './vistas/detallepedido/detallepedido.component';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule } from '@angular/forms';



@NgModule({
  declarations: [PedidosComponent, DetallepedidoComponent],
  entryComponents:[DetallepedidoComponent],
  imports: [
    CommonModule,
    PedidosRoutingModule,
    MaterialModule,
    HttpClientModule,
    FormsModule
  ]
  
})
export class PedidosModule { }
