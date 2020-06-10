import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchita/src/componentes/login/models/ciudad_model.dart';
import 'package:panchita/src/componentes/pedidos/models/pedido_model.dart';

class Usuario {

  String token;
  String email;
  String password;
  String nombre;
  String idGoogle;
  String cedula;
  String direccion;
  String telefono;
  Ciudad ciudad;
  List<Pedido> pedidos;
  bool vendedor;

  Usuario({
    this.token,
    this.password,
    this.email,
    this.nombre,
    this.idGoogle,
    this.cedula,
    this.direccion,
    this.telefono,
    this.ciudad,
    this.pedidos,
    this.vendedor
  });

  Usuario.map(DocumentSnapshot usuario) {
    idGoogle   = usuario.documentID;
    token      = usuario['token'];
    nombre     = usuario['nombre'];
    email      = usuario['email'];
    cedula     = usuario['cedula'];
    direccion  = usuario['direccion'];
    telefono   = usuario['telefono'];
    ciudad     = Ciudad.map(usuario['ciudad']);
    vendedor   = usuario['vendedor'];
  }
}
