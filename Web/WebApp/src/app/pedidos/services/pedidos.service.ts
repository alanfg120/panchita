import { Injectable } from "@angular/core";
import { AngularFirestore } from "@angular/fire/firestore";
import { Pedido } from "../models/pedido_model";
import { map } from "rxjs/operators";

@Injectable({
  providedIn: "root",
})
export class PedidosService {
  constructor(public firebase: AngularFirestore) {}

  getPedidos() {
    return this.firebase
      .collection<Pedido>("pedidos", (ref) => ref.orderBy("fecha"))
      .valueChanges()
      .pipe(map((pedido: any) => pedido.reverse()));
  }
}
