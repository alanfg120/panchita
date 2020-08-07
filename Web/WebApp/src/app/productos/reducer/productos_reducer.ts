import { createReducer, on } from '@ngrx/store';
import { Producto } from '../models/producto_model';
import {
  addProducto,
  loadedCategorias,
  loadedMarcas,
  loadedProductos,
  deleteProducto,
  updateProducto,
} from '../actions/productos_actions';

export interface ProductosState {
  productos: Producto[];
  categorias: string[];
  marcas: string[];
  isloading?: boolean;
  existProducto?: boolean;
}

export const initialState: ProductosState = {
  productos: [],
  categorias: [],
  marcas: [],
  existProducto: false,
  isloading : true
};

// tslint:disable-next-line: variable-name
const _ProductosReducer = createReducer(
  initialState,
  on(loadedProductos, (state, { productos }) => {
    return { ...state, productos,isloading : false};
  }),
  on(loadedCategorias, (state, { categorias }) => {
    return { ...state, categorias };
  }),
  on(loadedMarcas, (state, { marcas }) => {
    return { ...state, marcas };
  }),
  on(deleteProducto, (state, { id }) => {
    state.productos.splice(
      state.productos.findIndex((d) => d.id === id),
      1
    );
    return { ...state };
  }),
  on(updateProducto, (state, { producto }) => {
    state.productos.splice(
      state.productos.findIndex((d) => d.id === producto.id),
      1,
      producto
    );
    return { ...state };
  }),
  on(addProducto, (state, { producto }) => {
    if (existeProducto(state.productos, producto.codigo)) {
      return { ...state, existProducto: true };
    } else {
      state.productos.push(producto);
      return { ...state, existProducto: false };
    }
  })
);

function existeProducto(productos: Producto[], codigo: string): boolean {
  let exist = false;
  productos.forEach((p) => {
    if (p.codigo === codigo) {
      exist = true;
    }
  });
  return exist;
}

export function ProductoReducer(state, action) {
  return _ProductosReducer(state, action);
}
