import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchita/src/componentes/login/models/ciudad_model.dart';

class Usuario {
  String email;
  String password;
  String nombre;
  String idGoogle;
  String cedula;
  String dirrecion;
  String telefono;
  Ciudad ciudad;

  Usuario(
      {this.password,
      this.email,
      this.nombre,
      this.idGoogle,
      this.cedula,
      this.dirrecion,
      this.telefono,
      this.ciudad});

   Usuario.map(DocumentSnapshot usuario){
     idGoogle  = usuario.documentID;
     nombre    = usuario['nombre'];
     email     = usuario['email'];
     cedula    = usuario['cedula'];
     dirrecion = usuario['direccion'];
     telefono  = usuario['telefono'];
     ciudad    = Ciudad.map(usuario['ciudad']);
   }
 
}
