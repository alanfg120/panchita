import { createFeatureSelector, createSelector, props } from '@ngrx/store';
import { VendedoresState } from '../reducers/vendedor_reducer';



export const getVendedoresSelector = createFeatureSelector<VendedoresState>('vendedores');

export const getVendedores = createSelector(
    getVendedoresSelector,
  (state: VendedoresState) => state.vendedores
);
export const getExistVendedor = createSelector(
    getVendedoresSelector,
  (state: VendedoresState) => state.existVendedor
);
export const loading = createSelector(
    getVendedoresSelector,
  (state: VendedoresState) => state.loading
);

