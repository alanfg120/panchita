import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { EMPTY, of, pipe, from } from 'rxjs';
import { catchError, tap, exhaustMap, map } from 'rxjs/operators';
import {
  authAction,
  errorAction,
  successAction,
} from '../actions/login_action';
import { LoginService } from '../services/login.service';
import { Usuario } from '../models/usuario_model';
import { Router } from '@angular/router';
import { logout } from '../actions/login_action';
import { ErrorStatus } from '../models/error_model';

@Injectable()
export class LoginEffects {
  auth$ = createEffect(() =>
    this.actions$.pipe(
      ofType(authAction),
      exhaustMap((action) => {
        return from(this.loginService.auth(action.usuario)).pipe(
          map((data) => {
           const usuario = new Usuario();
           usuario.email = data.user.email;
           usuario.token = data.user.uid;
           if (usuario.email === 'administrador@panchita.com') {
            return successAction({ usuario });
           }
           return errorAction({error : {
             code : 'auth/no-admin',
             messaje : 'no es administrador'
           }});
          }),
          catchError((error: ErrorStatus) => of(errorAction({ error })))
        );
      })
    )
  );
  success$ = createEffect(
    () =>
      this.actions$.pipe(
        ofType(successAction),
        tap((action) => {
          sessionStorage.setItem('id_session', action.usuario.token);
          this.router.navigate(['Home']);
        })
      ),
    { dispatch: false }
  );
  logout$ = createEffect(
    () =>
      this.actions$.pipe(
        ofType(logout),
        tap(async () => {
          await this.loginService.logout();
          sessionStorage.clear();
          this.router.navigate(['login']);
        })
      ),
    { dispatch: false }
  );

  constructor(
    private actions$: Actions,
    private loginService: LoginService,
    private router: Router
  ) {}
}
