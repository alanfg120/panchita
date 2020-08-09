 export interface  Ciudad {
    ciudad: string ;
    ruta: string;
 }


 export class Cliente {
  public nombre: string;
  public cedula: string;
  public telefono: string;
  public ciudad: Ciudad;
  public direccion: string;
}
