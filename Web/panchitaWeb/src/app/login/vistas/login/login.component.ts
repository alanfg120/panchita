import { Component, OnInit } from '@angular/core';
import { Usuario } from '../../models/usuario_model';
import { Store } from '@ngrx/store';
import { LoginState } from '../../reducers/login_reducer';
import { authAction, logout } from '../../actions/login_action';
import { MatSnackBar } from '@angular/material/snack-bar';


import { ErrorStatus } from '../../models/error_model';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent implements OnInit {
  usuario = new Usuario();
  errorStatus$ = this.store.select((state) => state.login.errorStatus);
  constructor(
    private store: Store<{ login: LoginState }>,
    private snack: MatSnackBar
  ) {}
  ngOnInit(): void {
    this.errorStatus$.subscribe((error: ErrorStatus) => {
      console.log(error);
      if (error) {
        if (error.code === 'auth/user-not-found') {
          this.snackBar('No existe el usuario');
        }

        if (error.code === 'auth/no-admin') {
          this.snackBar('No eres administrador');
        }

        if (error.code === 'auth/invalid-email') {
          this.snackBar('No es Email valido');
        }
        if (error.code === 'auth/wrong-password') {
          this.snackBar('Contraseña Invalida');
        }

      }

    });
  }
  login(form): void {
    if (form.valid) {
      this.store.dispatch(authAction({ usuario: this.usuario }));
    }
  }

  snackBar(mensaje: string): void{
    this.snack.open(mensaje, 'Aceptar', {
      duration: 2000,
      horizontalPosition: 'left',
    });
  }
}
