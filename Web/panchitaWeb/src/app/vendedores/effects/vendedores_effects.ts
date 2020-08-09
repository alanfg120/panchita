import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { EMPTY, of, from } from 'rxjs';
import {
  catchError,
  map,
  concatMap,
  withLatestFrom,
  tap,
} from 'rxjs/operators';
import { MatSnackBar } from '@angular/material/snack-bar';
import { async } from '@angular/core/testing';
import { VendedorService } from '../services/vendedor.service';
import {
  loadVendedores,
  loadedVendedores,
  addVendedor,
  deleteVendedor,
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
        return this.vendedoresService.getVendedores().pipe(
          map((vendedores) => loadedVendedores({ vendedores })),
          catchError((err) => EMPTY)
        );
      })
    )
  );
  deleteVendedor$ = createEffect(
    () =>
      this.actions$.pipe(
        ofType(deleteVendedor),
        tap(async (action) => {
          try {
            await this.vendedoresService.deleteVendedorDb(action.id);
            this.snacbar.open('Vendedor Eliminado', 'Aceptar');
          } catch (error) {
            this.snacbar.open('Ocurrio un error', 'Aceptar');
          }
        })
      ),
    { dispatch: false }
  );
  addVendedor$ = createEffect(
    () =>
      this.actions$.pipe(
        ofType(addVendedor),
        concatMap((action) =>
          of(action).pipe(withLatestFrom(this.store.select(getExistVendedor)))
        ),
        tap(async ([action, existVendedor]) => {
          if (!existVendedor) {
            try {
              const user = await this.vendedoresService.createVendedor(
                action.vendedor.email,
                action.password
              );
              await this.vendedoresService.addVendedor(
                user.user.uid,
                action.vendedor
              );
              this.snacbar.open('Vendedor Agregado', 'Aceptar');
            } catch (error) {
              console.log(error);
            }
          } else {
            this.snacbar.open('Vendedor Ya existe', 'Aceptar');
          }
        })
      ),
    { dispatch: false }
  );
  constructor(
    private actions$: Actions,
    private vendedoresService: VendedorService,
    private store: Store<VendedoresState>,
    private snacbar: MatSnackBar
  ) {}
}
