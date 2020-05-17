import { createFeatureSelector, createSelector, props } from '@ngrx/store';
import { ProductosState } from '../reducer/productos_reducer';


export const getProductosSelector = createFeatureSelector<ProductosState>('productos');

export const getCategorias = createSelector(
  getProductosSelector,
  (state: ProductosState) => state.categorias
);
export const getProductos = createSelector(
  getProductosSelector,
  (state: ProductosState) => state.productos
);
export const getMarcas = createSelector(
  getProductosSelector,
  (state: ProductosState) => state.marcas
);

export const existSelect = createSelector(
  getProductosSelector,
  (state: ProductosState) => state.existProducto
);


