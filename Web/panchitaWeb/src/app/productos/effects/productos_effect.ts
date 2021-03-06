import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { EMPTY, of, pipe } from 'rxjs';
import { Store, select } from '@ngrx/store';

import {
  // map,
  catchError,
  tap,
  exhaustMap,
  map,
  concatMapTo,
  concatMap,
  withLatestFrom,
} from 'rxjs/operators';
import {
  addProducto,
  loadCategoriasyMarcas,
  loadedCategorias,
  loadedMarcas,
  loadedProductos,
  loadProductos,
  deleteProducto,
  updateProducto,
} from '../actions/productos_actions';
import { ProductosService } from '../services/productos.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import { ProductosState } from '../reducer/productos_reducer';
import { existSelect } from '../selectors/productos_select';
import { async } from '@angular/core/testing';


@Injectable()
export class ProductosEffects {
  addProducto$ = createEffect(
    () =>
      this.actions$.pipe(
        ofType(addProducto),
        concatMap((action) => of(action).pipe(
          withLatestFrom(this.store.select(existSelect))
        )),
       tap(async ([action, existProducto]) => {
         if (!existProducto) {
          await this.productosService.addproductos(action.producto);
          this.snacbar.open('Producto Agregado', 'Aceptar');
         }
        })
      ),
    { dispatch: false }
  );
  updateProducto$ = createEffect(
    () =>
      this.actions$.pipe(
        ofType(updateProducto),
       tap(async (action) => {
          await this.productosService.updateProducto(action.producto);
          this.snacbar.open('Producto Actulizado', 'Aceptar');

        })
      ),
    { dispatch: false }
  );
  getCategorias$ = createEffect(() =>
    this.actions$.pipe(
      ofType(loadCategoriasyMarcas),
      concatMap(() => {
        return this.productosService.getCatagorias().pipe(
          map((categorias: any) => loadedCategorias({ categorias: categorias[0].categorias })),
          catchError((err) => EMPTY)
        );
      })
    )
  );
  deleteProducto$ = createEffect(() =>
    this.actions$.pipe(
      ofType(deleteProducto),
      tap(async (action) => {
        await this.productosService.deleteProducto(action.id);
        await this.productosService.deleteImage(action.url);
        this.snacbar.open('Producto eliminado', 'Aceptar');
      })
    ),
    {dispatch: false}
  );
  getMarcas$ = createEffect(() =>
    this.actions$.pipe(
      ofType(loadCategoriasyMarcas),
      concatMap(() => {
        return this.productosService.getMarcas().pipe(
          map((marcas: any) => loadedMarcas({ marcas: marcas[0].marcas })),
          catchError((err) => EMPTY)
        );
      })
    )
  );
  geProductos$ = createEffect(() =>
    this.actions$.pipe(
      ofType(loadProductos),
      concatMap(() => {
        return this.productosService.getproductos().pipe(
          map((productos) => loadedProductos({ productos })),
          catchError((err) => EMPTY)
        );
      })
    )
  );

  constructor(
    private actions$: Actions,
    private productosService: ProductosService,
    private snacbar: MatSnackBar,
    private store: Store<ProductosState>

  ) {}
}
