import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:panchita/src/componentes/login/models/ciudad_model.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';

class Pedido {
  
  String id;
  String nombreCliente;
  String direccion;
  String cedula;
  String telefono;
  String token;
  List<Producto> productos;
  int total;
  bool confirmado;
  String observacion;
  String mensaje;
  DateTime fecha;
  Ciudad   ciudad;
 
  Pedido(
      {
      this.productos,
      this.total,
      this.confirmado,
      this.observacion,
      this.mensaje,
      this.fecha,
      this.cedula,
      this.direccion,
      this.nombreCliente,
      this.ciudad,
      this.telefono,
      this.token
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
    id            =  data.documentID;
    telefono      =  data['telefono'];
    nombreCliente =  data['nombre_cliente'];
    direccion     =  data['direccion'];
    cedula        =  data['cedula_cliente'];
    ciudad        =  Ciudad(ciudad: data['ciudad']);
    fecha         =  (data['fecha'] as Timestamp).toDate();
    total         =  data['total'];
    productos     =  productoMap(data['productos']);
    confirmado    =  data['confirmado'];
    mensaje       =  data['mensaje'];
  }
  @override
  String toString()=>'$confirmado';

}


