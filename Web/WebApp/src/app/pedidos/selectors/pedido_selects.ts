import { createFeatureSelector, createSelector, props } from '@ngrx/store';
import { PedidosState } from '../reducers/pedido_reducer';



export const PedidosSelector = createFeatureSelector<PedidosState>('pedidos');

export const getPedidos = createSelector(
  PedidosSelector,
  (state: PedidosState) => state.pedidos
);



