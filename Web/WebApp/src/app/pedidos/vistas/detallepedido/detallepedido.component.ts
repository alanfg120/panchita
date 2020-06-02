import { Component, OnInit, Inject } from "@angular/core";
import { MatDialogRef, MAT_DIALOG_DATA } from "@angular/material";
import { Pedido } from "../../models/pedido_model";
import { PedidosService } from "../../services/pedidos.service";
import { Store } from "@ngrx/store";
import { PedidosState } from "../../reducers/pedido_reducer";
import { sendPushNotification } from "../../actions/pedidos_actions";

@Component({
  selector: "app-detallepedido",
  templateUrl: "./detallepedido.component.html",
  styleUrls: ["./detallepedido.component.css"],
})
export class DetallepedidoComponent implements OnInit {
  mensaje: string;
  constructor(
    public dialogref: MatDialogRef<DetallepedidoComponent>,
    @Inject(MAT_DIALOG_DATA) public data: Pedido,
    private push: PedidosService,
    private store: Store<{ pedidos: PedidosState }>
  ) {}

  ngOnInit() {}

  sendPush() {
    this.store.dispatch(
      sendPushNotification({
        mensaje : this.mensaje,
        token   : this.data.token,
        id      : this.data.id,
      })
    );
  }
}
