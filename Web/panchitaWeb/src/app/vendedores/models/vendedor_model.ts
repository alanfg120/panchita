import { Ciudad } from 'src/app/clientes/models/cliente_models';

export class Vendedor {
 public id: string;
 public nombre: string;
 public cedula: string;
 public email: string;
 public telefono: string;
 public direccion: string;
 public token: string;
 public ciudad: Ciudad;
 public vendedor: boolean;
 
}