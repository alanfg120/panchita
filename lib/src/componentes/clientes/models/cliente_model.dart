import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchita/src/componentes/login/models/ciudad_model.dart';

class Cliente {
  String nombre;
  String cedula;
  String telefono;
  String direccion;
  Ciudad ciudad;

  Cliente(
      {this.nombre, this.cedula, this.telefono, this.direccion, this.ciudad});

  Cliente.map(DocumentSnapshot data) {
    nombre    = data['nombre'];
    cedula    = data['nombre'];
    telefono  = data['nombre'];
    direccion = data['nombre'];
    ciudad    = Ciudad.map(data['ciudad']);
  }
}
