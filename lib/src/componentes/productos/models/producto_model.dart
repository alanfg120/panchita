import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchita/src/componentes/login/models/ciudad_model.dart';

class Producto {

  int cantidad;
  int cantidadCompra = 1;
  String categoria;
  String codigo;
  String descripcion;
  String marca;
  String nombre;
  String foto;
  int precioUno;
  int precioDos;
  int precioTres;
  int precioFinal;

  Producto(
      {this.cantidad,
      this.cantidadCompra,
      this.categoria,
      this.codigo,
      this.descripcion,
      this.marca,
      this.nombre,
      this.foto,
      this.precioDos,
      this.precioTres,
      this.precioUno,
      this.precioFinal});

  Producto.map(DocumentSnapshot producto) {
    categoria   = producto['categoria'];
    codigo      = producto['codigo'];
    descripcion = producto['descripcion'];
    cantidad    = producto['cantidad'];
    marca       = producto['marca'];
    nombre      = producto['nombre'];
    foto        = producto['url_foto'];
    precioUno   = producto['ruta1'];
    precioDos   = producto['ruta2'];
    precioTres  = producto['ruta3'];
  }
  Map toMap(Ciudad ciudad)=>{
    "codigo"   : codigo,
    "nombre"   : nombre,
    "cantidad" : cantidadCompra,
    "precio"   : getPrecio(ciudad.ruta)

  };
  int getPrecio(String ruta){
      switch (ruta) {
              case '1': precioFinal = precioUno;
                        break;
              case '2': precioFinal = precioDos;
                        break;
              case '3': precioFinal =  precioTres;
                        break;
              default:  precioFinal =  precioUno;
                        break;
      }
     return precioFinal;
  }
  int getSubtotal([String ruta]){
     if(ruta!= null)
      return cantidadCompra * this.getPrecio(ruta);
     else  return cantidadCompra * precioFinal;
  }
}
