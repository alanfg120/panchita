import { Injectable } from "@angular/core";
import { AngularFirestore } from "@angular/fire/firestore";
import { Pedido } from "../models/pedido_model";
import { map } from "rxjs/operators";
import { HttpClient } from "@angular/common/http";
import { environment } from "src/environments/environment";
import { MensajePush } from "../models/mensajePush_model";
import { AngularFireMessaging } from '@angular/fire/messaging';
import { FirebaseMessaging } from '@angular/fire';

@Injectable({
  providedIn: "root",
})
export class PedidosService {
  constructor(public firebase: AngularFirestore, public http: HttpClient) {}

  getPedidos() {
    return this.firebase
      .collection<Pedido>("pedidos", (ref) => ref.orderBy("fecha"))
      .valueChanges({ idField: "id" })
      .pipe(map((pedido: any) => pedido.reverse()));
  }

  sendPushNotications(mensaje: string,token) {


   let pushNotification: MensajePush = {
      notification: {
        body: "Su pedido sera enviado en breve",
        title: "Su pedido esta listo para el envio",
      },
      data: {
        click_action: "FLUTTER_NOTIFICATION_CLICK",
        event: "send_pedido",
        mensaje: mensaje,
      },
      to: token,
      priority: "high",
      android:{
        notification:{
          sound:'default'
        }
      }
    };
    return this.http.post(`${environment.urlPush}`, pushNotification);
  }
}
