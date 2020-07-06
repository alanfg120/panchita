import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { EMPTY, of } from 'rxjs';
import {
  catchError,
  map,
  concatMap,
  withLatestFrom,
  tap,
} from 'rxjs/operators';
import { MatSnackBar } from '@angular/material';
import { async } from '@angular/core/testing';
import { VendedorService } from '../services/vendedor.service';
import {
  loadVendedores,
  loadedVendedores,
  addVendedor,
} from '../actions/vendedor_actions';
import { Vendedor } from '../models/vendedor_model';
import { VendedoresState } from '../reducers/vendedor_reducer';
import { Store } from '@ngrx/store';
import { getExistVendedor } from '../selectors/vendedores_select';

@Injectable()
export class VendedoresEffect {
  loadVendedores$ = createEffect(() =>
    this.actions$.pipe(
      ofType(loadVendedores),
      concatMap(() => {
        return this._vendedores.getVendedores().pipe(
          map((vendedores) => loadedVendedores({ vendedores })),
          catchError((err) => EMPTY)
        );
      })
    )
  );
  addProducto$ = createEffect(
    () =>
      this.actions$.pipe(
        ofType(addVendedor),
        concatMap((action) =>
          of(action).pipe(withLatestFrom(this.store.select(getExistVendedor)))
        ),
        tap(async ([action, existVendedor]) => {
          if (!existVendedor) {
            try {
              const user = await this._vendedores.createVendedor(
                action.vendedor.email,
                action.password
              );
              await this._vendedores.addVendedor(user.user.uid, action.vendedor);
              this.snacbar.open('Vendedor Agregado', 'Aceptar');
            } catch (error) {
              console.log(error);
            }
          } else { this.snacbar.open('Vendedor Ya existe', 'Aceptar'); }
        })
      ),
    { dispatch: false }
  );
  constructor(
    private actions$: Actions,
    private _vendedores: VendedorService,
    private store: Store<VendedoresState>,
    private snacbar: MatSnackBar
  ) {}
}
