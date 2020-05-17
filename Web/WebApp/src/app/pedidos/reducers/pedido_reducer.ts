import { createReducer, on } from "@ngrx/store";
import { Pedido } from '../models/pedido_model';
import { loadedPedidos } from '../actions/pedidos_actions';


export interface PedidosState {
  pedidos:Pedido[]
}

export const initialState: PedidosState = {
  pedidos:[]
};

const _PedidosReducer = createReducer(
  initialState,
  on(loadedPedidos, (state,{pedidos}) => {
    return { ...state,pedidos};
  }),
);



export function PedidosReducer(state, action) {
  return _PedidosReducer(state, action);
}
