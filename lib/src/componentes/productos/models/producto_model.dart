import 'package:cloud_firestore/cloud_firestore.dart';

class Producto {
  int cantidad;
  int cantidadCompra;
  String categoria;
  String codigo;
  String descripcion;
  String marca;
  String nombre;
  String foto;
  int precioUno;
  int precioDos;
  int precioTres;

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
      this.precioUno});

  Producto.map(DocumentSnapshot producto) {
   print(producto);

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

  int getPrecio(String ruta){
      switch (ruta) {
              case '1': return precioUno;
                        break;
              case '2': return precioDos;
                        break;
              case '3': return precioTres;
                        break;
              default:  return precioUno;
                        break;
      }

  }
}
