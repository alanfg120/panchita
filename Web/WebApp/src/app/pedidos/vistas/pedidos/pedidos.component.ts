import { Component, OnInit } from "@angular/core";
import { PedidosState } from "../../reducers/pedido_reducer";
import { Store } from "@ngrx/store";
import { Observable } from "rxjs";
import { getPedidos } from "../../selectors/pedido_selects";
import { Pedido } from "../../models/pedido_model";
import { loadPedidos } from "../../actions/pedidos_actions";
import { MatDialog } from "@angular/material";
import { DetallepedidoComponent } from "../detallepedido/detallepedido.component";

@Component({
  selector: "app-pedidos",
  templateUrl: "./pedidos.component.html",
  styleUrls: ["./pedidos.component.css"],
})
export class PedidosComponent implements OnInit {
  pedidos$: Observable<Pedido[]> = this.store.select(getPedidos);
  constructor(
    private store: Store<{ productos: PedidosState }>,
    public dialog: MatDialog
  ) {}

  ngOnInit() {
    this.store.dispatch(loadPedidos());
  }
  verDetallePedido(pedido: Pedido) {
    this.dialog.open(DetallepedidoComponent, {

      data   : pedido
    });
  }
}
