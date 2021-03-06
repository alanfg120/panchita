import { Injectable } from '@angular/core';
import { AngularFirestore } from '@angular/fire/firestore';
import { Pedido } from '../models/pedido_model';
import { map } from 'rxjs/operators';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { MensajePush } from '../models/mensajePush_model';
import { Observable } from 'rxjs';



@Injectable({
  providedIn: 'root',
})
export class PedidosService {
  constructor(public firebase: AngularFirestore, public http: HttpClient) {}

  getPedidos(): Observable<Pedido[]> {
    return this.firebase
      .collection<Pedido>('pedidos', (ref) => ref.orderBy('fecha'))
      .valueChanges({ idField: 'id' })
      .pipe(map((pedido: any) => pedido.reverse()));
  }

  updatePedidos(mensaje: string, confirmado: boolean, id: string): Promise<void>{
    return this.firebase.collection('pedidos').doc(id).update({
      confirmado,
      mensaje,
    });
  }

  sendPushNotications(mensaje: string, token: string, id: string): Observable<object> {
    const pushNotification: MensajePush = {
      notification: {
        body: 'Su pedido sera enviado en breve',
        title: 'Su pedido esta listo para el envio',
      },
      data: {
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
        event: 'send_pedido',
        mensaje,
        id,
      },
      to: token,
      priority: 'high',
      android: {
        notification: {
          sound: 'default',
        },
      },
    };
    return this.http.post(`${environment.urlPush}`, pushNotification);
  }
}
