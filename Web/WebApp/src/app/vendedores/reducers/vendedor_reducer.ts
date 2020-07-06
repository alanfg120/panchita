import { createReducer, on } from '@ngrx/store';
import { Vendedor } from '../models/vendedor_model';
import { loadedVendedores, addVendedor } from '../actions/vendedor_actions';



export interface VendedoresState {
  vendedores: Vendedor[];
  existVendedor?: boolean;
}

export const initialState: VendedoresState = {
    vendedores: []
};

// tslint:disable-next-line: variable-name
const _VendedoresReducer = createReducer(
  initialState,
  on(loadedVendedores, (state, {vendedores}) => {
    return { ...state, vendedores};
  }),
  on(addVendedor, (state, { vendedor }) => {
    if (existeVendedor(state.vendedores, vendedor.cedula,vendedor.email)) {
      return { ...state, existVendedor: true };
    } else {
      state.vendedores.push(vendedor);
      return { ...state, existVendedor: false };
    }
  })
);


function existeVendedor(vendedores: Vendedor[], cedula: string, email: string): boolean {
  let exist = false;
  vendedores.forEach((p) => {
    if (p.cedula === cedula || p.email === email) {
      exist = true;
    }
  });
  return exist;
}


export function VendedoresReducer(state, action) {
  return _VendedoresReducer(state, action);
}
