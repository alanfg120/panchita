import { createAction, props } from "@ngrx/store";
import { Pedido } from '../models/pedido_model';


//  Action Obtener Productos

export const loadPedidos = createAction("[Productos Componet] LoadPedidos");

export const loadedPedidos = createAction(
  "[Pedidos Componet] LoadedPedidos",
  props<{pedidos:Pedido[]}>()
);


