import { Component, OnInit, Inject } from '@angular/core';
import { Vendedor } from '../../models/vendedor_model';
import { AddproducComponent } from 'src/app/productos/vistas/addproduc/addproduc.component';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Store } from '@ngrx/store';
import { VendedoresState } from '../../reducers/vendedor_reducer';
import { addVendedor } from '../../actions/vendedor_actions';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-addvendedor',
  templateUrl: './addvendedor.component.html',
  styleUrls: ['./addvendedor.component.css'],
})
export class AddvendedorComponent implements OnInit {
  vendedor: Vendedor = new Vendedor();
  password: string;
  constructor(
    public dialogref: MatDialogRef<AddproducComponent>,
    @Inject(MAT_DIALOG_DATA) public data: Vendedor,
    private store: Store<{ vendedores: VendedoresState }>
  ) {}

  ngOnInit() {}

  addVendedor(form: NgForm) {
    if (form.valid) {
      this.vendedor.vendedor = true;
      this.vendedor.ciudad = {
        ciudad: 'Acacias',
        ruta: '1',
      };
      this.vendedor.token = '';
      this.store.dispatch(
        addVendedor({ vendedor: this.vendedor, password: this.password })
      );
      this.dialogref.close();
    }
  }
}
