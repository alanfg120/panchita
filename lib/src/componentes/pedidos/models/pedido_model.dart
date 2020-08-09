import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:panchita/src/componentes/clientes/models/cliente_model.dart';
import 'package:panchita/src/componentes/login/models/ciudad_model.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';

class Pedido {

  String id;
  Cliente cliente;
  String token;
  List<Producto> productos;
  int total;
  bool confirmado;
  String observacion;
  String mensaje;
  DateTime fecha;
  String cedulaVendedor;
  String nombreVendedor;
  bool enviado;


  Pedido(
      {this.productos,
      this.total,
      this.confirmado,
      this.observacion,
      this.mensaje,
      this.fecha,
      this.cliente,
      this.token,
      this.cedulaVendedor,
      this.nombreVendedor,
      this.enviado});

  String formatFecha() {
    return DateFormat("dd/MM/yyyy hh:mm aaa")
        .format(DateTime.parse(fecha.toString()));
  }

  List<Producto> productoMap(List data) {
    List<Producto> productos;
    productos = data
        .map((p) => Producto(
            precioFinal    : p['precio'],
            cantidadCompra : p['cantidad'],
            codigo         : p['codigo'],
            nombre         : p['nombre']))
        .toList();
    return productos;
  }
  Cliente clienteMap(Map cliente){
    return Cliente(
           nombre   : cliente['nombre'],
           cedula   : cliente['cedula'],
           telefono : cliente['telefono'],
           ciudad   : Ciudad.map(cliente['ciudad']),
           direccion: cliente['direccion']
    );

  }
  Pedido.map(DocumentSnapshot data) {
    id = data.documentID;
    cliente       = clienteMap(data['cliente']);
    fecha         = (data['fecha'] as Timestamp).toDate();
    total         = data['total'];
    productos     = productoMap(data['productos']);
    confirmado    = data['confirmado'];
    mensaje       = data['mensaje'];
    enviado       = data['enviado'];
  }
  @override
  String toString() => '$confirmado';
}
