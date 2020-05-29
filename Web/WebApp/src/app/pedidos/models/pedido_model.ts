import { Producto } from 'src/app/productos/models/producto_model';

interface Timestamp {
    seconds: number,
    nanoseconds: number,
}
export class Pedido {

public id:string;
public nombre_cliente:string;
public cedula_cliente:string;
public direccion:string;
public fecha:Timestamp;
public ciudad:string;
public observacion:string;
public productos:Producto[];
public total:number;
public confirmado:boolean;
public telefono:string;
public token:string;

}