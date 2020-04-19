import { createAction, props } from "@ngrx/store";
import { Producto } from "../models/producto_model";

export const loadProductos = createAction("[Productos Componet] LoadProductos");

export const loadedProductos = createAction(
  "[Productos Componet] LoadedProductos",
  props<{ productos: Producto[] }>()
);

export const addProducto = createAction(
  "[Productos Componet] AddProducto",
  props<{ producto: Producto }>()
);

export const updateProducto = createAction(
  "[Productos Componet] UpdateProducto",
   props<{ producto: Producto }>()
);

export const deleteProducto = createAction(
  "[Productos Componet] UpdateProducto",
   props<{ producto: Producto }>()
);
