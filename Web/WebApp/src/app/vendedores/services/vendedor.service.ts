import { Injectable } from '@angular/core';
import { AngularFirestore } from '@angular/fire/firestore';
import { AngularFireAuth } from '@angular/fire/auth';
import { Vendedor } from '../models/vendedor_model';

@Injectable({
  providedIn: 'root',
})
export class VendedorService {
  constructor(public firebase: AngularFirestore, public fireauth: AngularFireAuth) {}

  getVendedores() {
    return this.firebase
      .collection<Vendedor>('usuarios', (ref) => ref.where('vendedor', '==', true))
      .valueChanges({ idField: 'id' });
  }

  async createVendedor(email: string, password: string) {
    return  await this.fireauth.auth.createUserWithEmailAndPassword(email, password);
  }
  async addVendedor(id: string, vendedor: Vendedor) {
    return  await this.firebase.collection('usuarios').doc(id).set({...vendedor});
  }
}
