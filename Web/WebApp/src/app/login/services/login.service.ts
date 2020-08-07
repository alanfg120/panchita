import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Usuario } from '../models/usuario_model';
import { AngularFireAuth } from '@angular/fire/auth';

@Injectable({
  providedIn: 'root',
})
export class LoginService {
  constructor(private firebaseAuth: AngularFireAuth) {}

  auth(usuario: Usuario) {
    return this.firebaseAuth.auth.signInWithEmailAndPassword(
      usuario.email,
      usuario.password
    );
  }

  logout() {
    return this.firebaseAuth.auth.signOut();
  }
}
