import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Usuario } from '../models/usuario_model';
import { AngularFireAuth } from '@angular/fire/auth';

@Injectable({
  providedIn: 'root',
})
export class LoginService {
  constructor(private firebaseAuth: AngularFireAuth) {}

 async  auth(usuario: Usuario): Promise<firebase.auth.UserCredential> {
    return await this.firebaseAuth.signInWithEmailAndPassword(
      usuario.email,
      usuario.password
    );
  }

  logout(): Promise<void>{
    return this.firebaseAuth.signOut();
  }
}
