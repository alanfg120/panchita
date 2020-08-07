import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { AddproducComponent } from '../addproduc/addproduc.component';
import { ProductosService } from '../../services/productos.service';
import { Observable } from 'rxjs';
import { Producto } from '../../models/producto_model';
import { Store } from '@ngrx/store';
import { ProductosState } from '../../reducer/productos_reducer';
import {
  loadCategoriasyMarcas,
  loadProductos,
  deleteProducto,
} from '../../actions/productos_actions';
import { MatSnackBar } from '@angular/material';
import { existSelect, getProductos, loading } from '../../selectors/productos_select';
@Component({
  selector: 'app-productos',
  templateUrl: './productos.component.html',
  styleUrls: ['./productos.component.css'],
})
export class ProductosComponent implements OnInit {
  productos$: Observable<Producto[]> = this.store.select(getProductos);
  exist$: Observable<boolean> = this.store.select(existSelect);
  loading$: Observable<boolean> = this.store.select(loading);
  update: boolean;
  selected: Producto;

  constructor(
    public dialog: MatDialog,
    public firebase: ProductosService,
    public snack: MatSnackBar,
    private store: Store<{ productos: ProductosState }>
  ) {}

  ngOnInit() {
    this.store.dispatch(loadCategoriasyMarcas());
    this.store.dispatch(loadProductos());
    this.exist$.subscribe((exist) => {
      if (exist) {
        this.snack.open('Ya existe este Producto', 'Aceptar', {
          duration: 2000,
        });
      }
    });
  }

  AddProductodialog() {
    this.dialog.open(AddproducComponent, {
      width: '600px',
      disableClose: true,
    });
  }
  updateProductodialog(producto: Producto) {
    this.dialog.open(AddproducComponent, {
      width: '600px',
      disableClose: true,
      data: producto
    });
  }

  deleteProducto(id: string, url: string) {
    const confirmdelete = confirm('Desea eliminar el producto');
    if (confirmdelete) { this.store.dispatch(deleteProducto({ id, url})); }
  }
  actionProducto(producto: Producto) {
    this.update = true;
    this.selected = producto;
  }
}
