import 'package:panchita/src/componentes/login/models/ciudad_model.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';

class Pedido {
  
  String nombreCliente;
  String direccion;
  String cedula;
  List<Producto> productos;
  int total;
  bool confirmado;
  String observacion;
  DateTime fecha;
  Ciudad   ciudad;
 
  Pedido(
      {
      this.productos,
      this.total,
      this.confirmado,
      this.observacion,
      this.fecha,
      this.cedula,
      this.direccion,
      this.nombreCliente,
      this.ciudad
      });

   
    

}


