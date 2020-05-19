import { Component, OnInit, Inject } from "@angular/core";
import { MatDialogRef, MAT_DIALOG_DATA } from "@angular/material";
import { Pedido } from "../../models/pedido_model";

@Component({
  selector: "app-detallepedido",
  templateUrl: "./detallepedido.component.html",
  styleUrls: ["./detallepedido.component.css"],
})
export class DetallepedidoComponent implements OnInit {
  constructor(
    public dialogref: MatDialogRef<DetallepedidoComponent>,
    @Inject(MAT_DIALOG_DATA) public data: Pedido
  ) {}

  ngOnInit() {
    console.log(this.data);
    
  }
}
