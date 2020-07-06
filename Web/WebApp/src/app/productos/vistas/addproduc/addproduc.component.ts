import { Component, OnInit, Inject } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { Producto } from '../../models/producto_model';
import { finalize } from 'rxjs/operators';
import { ProductosService } from '../../services/productos.service';
import { ProductosState } from '../../reducer/productos_reducer';
import { Store } from '@ngrx/store';
import { addProducto, updateProducto } from '../../actions/productos_actions';
import { MatSnackBar, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';
import { Observable } from 'rxjs';
import { getCategorias, getMarcas } from '../../selectors/productos_select';

@Component({
  selector: 'app-addproduc',
  templateUrl: './addproduc.component.html',
  styleUrls: ['./addproduc.component.css'],
})
export class AddproducComponent implements OnInit {
  datosFormulario = new FormData();
  producto: Producto = new Producto();
  ext: string;
  categorias$: Observable<string[]> = this.store.select(getCategorias);
  marcas$: Observable<string[]> = this.store.select(getMarcas);

  constructor(
    private storage: ProductosService,
    private store: Store<{ productos: ProductosState }>,
    public snack: MatSnackBar,
    public dialogref: MatDialogRef<AddproducComponent>,
    @Inject(MAT_DIALOG_DATA) public data: Producto
  ) {}

  ngOnInit() {
    console.log(this.data);

    if (this.data) { this.producto = this.data; }
  }
  addProducto(form: any) {
    if (form.valid) {
      if (this.datosFormulario.has('files')) {
        this.storage
          .uploadImage(
            `fotos/${this.producto.codigo}.${this.ext}`,
            this.datosFormulario.get('files')
          )
          .pipe(
            finalize(async () => {
              this.producto.url_foto = await this.storage.geturl(
                `fotos/${this.producto.codigo}.${this.ext}`
              );
              if (!this.data) {
                this.store.dispatch(addProducto({ producto: this.producto }));
              } else {
                this.store.dispatch(
                  updateProducto({ producto: this.producto })
                );
              }
              this.dialogref.close();
            })
          )
          .subscribe();
      } else {
        this.producto.url_foto = '';
        if (!this.data) {
          this.store.dispatch(addProducto({ producto: this.producto }));
        } else { this.store.dispatch(updateProducto({ producto: this.producto })); }
        this.dialogref.close();
      }
    } else { this.snackbar('Faltan datos'); }
  }

  fileUpload(event) {
    this.datosFormulario.delete('files');
    this.getExt(event.target.files[0].name);
    this.datosFormulario.append('files', event.target.files[0], `.jpg`);
  }

  snackbar(mensaje: string) {
    this.snack.open(mensaje, 'Aceptar', {
      duration: 2000,
      horizontalPosition: 'left',
    });
  }

  getExt(filename: string) {
    this.ext = filename.substring(filename.lastIndexOf('.')).toLowerCase();
  }
}
