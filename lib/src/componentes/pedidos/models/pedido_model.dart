import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:panchita/src/componentes/login/models/ciudad_model.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';

class Pedido {
  
  String nombreCliente;
  String direccion;
  String cedula;
  String telefono;
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
      this.ciudad,
      this.telefono
      });

  String formatFecha(){
    return DateFormat("dd/MM/yyyy hh:mm aaa").format(DateTime.parse(fecha.toString()));
  }
  
  List<Producto> productoMap(List data){
   List<Producto> productos;
    productos = data.map((p)=>Producto(
      precioFinal    : p['precio'],
      cantidadCompra : p['cantidad'],
      codigo         : p['codigo'],
      nombre         : p['nombre']
    )).toList();
    return productos;
  }

  Pedido.map(DocumentSnapshot data){
    telefono      =  data['telefono'];
    nombreCliente =  data['nombre_cliente'];
    direccion     =  data['direccion'];
    cedula        =  data['cedula_cliente'];
    ciudad        =  Ciudad(ciudad: data['ciudad']);
    fecha         =  (data['fecha'] as Timestamp).toDate();
    total         =  data['total'];
    productos     =  productoMap(data['productos']);
    confirmado    =  data['confirmado'];
  }
     

}


