import { createAction, props } from '@ngrx/store';
import { Vendedor } from '../models/vendedor_model';

export const loadVendedores = createAction(
  '[Vendedores Componet] loadVendedores'
);
export const loadedVendedores = createAction(
  '[Vendedores Componet] loadedVendedores',
   props<{vendedores: Vendedor[]}>()
);
export const addVendedor = createAction(
  '[AddVendedor Componet] addVendedor',
   props<{vendedor: Vendedor, password: string}>()
);

export const deleteVendedor = createAction(
  '[Vendedores Componet] DeleteVendedor',
  props<{ id: string }>()
);
