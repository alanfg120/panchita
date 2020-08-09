import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType, act } from '@ngrx/effects';
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

import { MatSnackBar } from '@angular/material/snack-bar';


import {
  loadPedidos,
  loadedPedidos,
  sendPushNotification,
} from '../actions/pedidos_actions';
import { PedidosService } from '../services/pedidos.service';
import { Pedido } from '../models/pedido_model';

@Injectable()
export class PedidosEffects {
  loadPedidos$ = createEffect(() =>
    this.actions$.pipe(
      ofType(loadPedidos),
      concatMap(() => {
        return this.pedidosService.getPedidos().pipe(
          map((pedidos) => loadedPedidos({ pedidos })),
          catchError((err) => EMPTY)
        );
      })
    )
  );
  sendPushNotification$ = createEffect(
    () =>
      this.actions$.pipe(
        ofType(sendPushNotification),
        concatMap((action) => {

          return this.pedidosService
            .sendPushNotications(action.mensaje, action.token, action.id)
            .pipe(map( async () => {
              await this.pedidosService.updatePedidos(action.mensaje, true, action.id);
              return this.snacbar.open('Pedido Confirmado', 'Aceptar');
            }));
        })
      ),
    { dispatch: false }
  );

  constructor(
    private actions$: Actions,
    private pedidosService: PedidosService,
    private snacbar: MatSnackBar
  ) {}
}
