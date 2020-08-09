import { Injectable } from '@angular/core';
import { AngularFirestore } from '@angular/fire/firestore';
import { AngularFireAuth } from '@angular/fire/auth';
import { Vendedor } from '../models/vendedor_model';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class VendedorService {
  constructor(
    public firebase: AngularFirestore,
    public fireauth: AngularFireAuth
  ) {}

  getVendedores(): Observable<Vendedor[]>{
    return this.firebase
      .collection<Vendedor>('usuarios', (ref) =>
        ref.where('vendedor', '==', true)
      )
      .valueChanges({ idField: 'id' });
  }


  async createVendedor(email: string, password: string): Promise<firebase.auth.UserCredential> {
    return await this.fireauth.createUserWithEmailAndPassword(
      email,
      password
    );
  }
  addVendedor(id: string, vendedor: Vendedor): Promise<void>{
    return this.firebase
      .collection('usuarios')
      .doc(id)
      .set({ ...vendedor });
  }

  deleteVendedorDb(id: string): Promise<void>{
    return this.firebase.collection('usuarios').doc(id).delete();
  }
}
