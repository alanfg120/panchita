import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchita/src/componentes/login/models/ciudad_model.dart';

class Cliente {
  String id;
  String nombre;
  String cedula;
  String telefono;
  String direccion;
  Ciudad ciudad;

  Cliente(
      {this.id,this.nombre, this.cedula, this.telefono, this.direccion, this.ciudad});

  Cliente.map(DocumentSnapshot data) {
    id        = data.documentID;
    nombre    = data['nombre'];
    cedula    = data['cedula'];
    telefono  = data['telefono'];
    direccion = data['direccion'];
    ciudad    = Ciudad.map(data['ciudad']);
  }
 
  Map<String,dynamic> toMap()=>{
    'nombre'    : nombre,
    'cedula'    : cedula,
    'telefono'  : telefono,
    'direccion' : direccion,
    'ciudad'    : ciudad.toMap()
  };
}
