import { createAction, props } from '@ngrx/store';
import { Producto } from '../models/producto_model';

//  Action Obtener Productos

export const loadProductos = createAction('[Productos Componet] LoadProductos');

export const loadedProductos = createAction(
  '[Productos Componet] LoadedProductos',
  props<{ productos: Producto[] }>()
);

//  Action Obtener Categorias y Marcas

export const loadCategoriasyMarcas = createAction(
  '[Productos Componet] LoadCategoriasyMarcas'
);

export const loadedCategorias = createAction(
  '[Productos Componet] LoadedCategorias',
  props<{ categorias: string[] }>()
);

export const loadedMarcas = createAction(
  '[Productos Componet] LoadedMarcas',
  props<{ marcas: string[] }>()
);



export const addProducto = createAction(
  '[Productos Componet] AddProducto',
  props<{ producto: Producto }>()
);

export const updateProducto = createAction(
  '[Productos Componet] UpdateProducto',
  props<{ producto: Producto }>()
);

export const deleteProducto = createAction(
  '[Productos Componet] DeleteProducto',
  props<{ id: string, url: string}>()
);
