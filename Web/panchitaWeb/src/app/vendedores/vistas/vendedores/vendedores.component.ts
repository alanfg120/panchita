import { Component, OnInit } from '@angular/core';

import { VendedoresState } from '../../reducers/vendedor_reducer';
import { Store } from '@ngrx/store';
import { Observable } from 'rxjs';
import { getVendedores, loading } from '../../selectors/vendedores_select';
import { Vendedor } from '../../models/vendedor_model';
import { loadVendedores, deleteVendedor } from '../../actions/vendedor_actions';
import { MatDialog } from '@angular/material/dialog';
import { AddvendedorComponent } from '../addvendedor/addvendedor.component';

@Component({
  selector: 'app-vendedores',
  templateUrl: './vendedores.component.html',
  styleUrls: ['./vendedores.component.css'],
})
export class VendedoresComponent implements OnInit {
  constructor(
    private store: Store<{ vendedores: VendedoresState }>,
    public dialog: MatDialog
  ) {}
  venedores$: Observable<Vendedor[]> = this.store.select(getVendedores);
  loading$: Observable<boolean> = this.store.select(loading);
  update: boolean;
  selected: Vendedor;
  ngOnInit() {
    this.store.dispatch(loadVendedores());
  }
  addVendedor() {
    this.dialog.open(AddvendedorComponent, {
      width: '600px',
      disableClose: true,
    });
  }
  actionProducto(producto: Vendedor) {
    this.update = true;
    this.selected = producto;
  }

  eraceVendedor() {
   const confirmar = confirm('Desea Eliminar el Vendedor');
   if (confirmar) {
   this.store.dispatch(deleteVendedor({id: this.selected.id}));
   }
  }
}
