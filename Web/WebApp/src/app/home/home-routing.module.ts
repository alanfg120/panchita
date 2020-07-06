import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from './vistas/home/home.component';


const routes: Routes = [
  {
    path: '',
    component: HomeComponent,
    children: [
      {
        path: 'productos',
        loadChildren: './../productos/productos.module#ProductosModule',
      },
      {
        path: 'pedidos',
        loadChildren: './../pedidos/pedidos.module#PedidosModule',
      },
      {
        path: 'vendedores',
        loadChildren: './../vendedores/vendedores.module#VendedoresModule',
      },

    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class HomeRoutingModule { }
