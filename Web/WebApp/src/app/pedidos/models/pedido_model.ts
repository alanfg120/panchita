import { Producto } from 'src/app/productos/models/producto_model';
import { Cliente } from 'src/app/clientes/models/cliente_models';

interface Timestamp {
  seconds: number;
  nanoseconds: number;
}


export class Pedido {
  public id: string;
  public cliente: Cliente;
  public observacion: string;
  public productos: Producto[];
  public total: number;
  public confirmado: boolean;
  public telefono: string;
  public token: string;
  public fecha: Timestamp;
}
