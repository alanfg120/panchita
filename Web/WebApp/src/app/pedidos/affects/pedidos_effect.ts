import { Injectable } from "@angular/core";
import { Actions, createEffect, ofType } from "@ngrx/effects";
import { EMPTY, of, pipe } from "rxjs";
import { Store, select } from '@ngrx/store';

import {
  //map,
  catchError,
  tap,
  exhaustMap,
  map,
  concatMapTo,
  concatMap,
  withLatestFrom,
} from "rxjs/operators";


import { MatSnackBar } from "@angular/material";


import { async } from '@angular/core/testing';
import { loadPedidos, loadedPedidos } from '../actions/pedidos_actions';
import { PedidosService } from '../services/pedidos.service';


@Injectable()
export class PedidosEffects {

 loadPedidos$ = createEffect(() =>
    this.actions$.pipe(
      ofType(loadPedidos),
      concatMap(() => {
        return this._pedidos.getPedidos().pipe(
          map((pedidos) => loadedPedidos({ pedidos })),
          catchError((err) => EMPTY)
        );
      })
    )
  );

  constructor(
    private actions$: Actions,
    private _pedidos: PedidosService,
    private snacbar: MatSnackBar,
  ) {}
}
