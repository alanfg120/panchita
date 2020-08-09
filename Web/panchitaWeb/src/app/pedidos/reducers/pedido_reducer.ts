import { createReducer, on } from '@ngrx/store';
import { Pedido } from '../models/pedido_model';
import { loadedPedidos, loadPedidos } from '../actions/pedidos_actions';


export interface PedidosState {
  pedidos: Pedido[];
  loading?: boolean;
}

export const initialState: PedidosState = {
  pedidos: [],
  loading: true
};

// tslint:disable-next-line: variable-name
const _PedidosReducer = createReducer(
  initialState,
  on(loadedPedidos, (state, {pedidos}) => {
    return { ...state, pedidos , loading : false};
  }),
);



export function PedidosReducer(state, action) {
  return _PedidosReducer(state, action);
}
