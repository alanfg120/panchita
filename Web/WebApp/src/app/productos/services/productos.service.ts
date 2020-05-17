import { Injectable } from "@angular/core";
import { AngularFirestore } from "@angular/fire/firestore";
import { Producto } from "../models/producto_model";
import { AngularFireStorage } from "@angular/fire/storage";
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: "root",
})
export class ProductosService {
  constructor(
    public firebase: AngularFirestore,
    private storage: AngularFireStorage
  ) {}

  getproductos(){
    return this.firebase.collection<Producto>("productos").valueChanges({idField:"id"})
  }
  addproductos(producto:Producto) {
   return this.firebase.collection("productos").add({...producto})
  }
  updateProducto(producto:Producto){
    return this.firebase.collection("productos").doc(producto.id).update({...producto})
  }
  deleteProducto(id:string){
    return this.firebase.collection("productos").doc(id).delete()
  }
  deleteImage(url:string){
    let ref = this.storage.storage.refFromURL(url);
    return ref.delete()
  }
  uploadImage(ruta: string, file: any) {
    return this.storage.upload(ruta, file).snapshotChanges();
  }
  geturl(ruta: string) {
    return this.storage.ref(ruta).getDownloadURL().toPromise();
  }
  getCatagorias() {
   return this.firebase.collection("categorias").valueChanges()
  }
  getMarcas(){
    return this.firebase.collection("marcas").valueChanges()
  }
}
