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
        loadChildren: () => import('./../productos/productos.module').then(m => m.ProductosModule)
      },
      {
        path: 'pedidos',
        loadChildren: () => import('./../pedidos/pedidos.module').then(m => m.PedidosModule)
      },
      {
        path: 'vendedores',
        loadChildren: () => import('./../vendedores/vendedores.module').then(m => m.VendedoresModule)
      },

    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class HomeRoutingModule { }
