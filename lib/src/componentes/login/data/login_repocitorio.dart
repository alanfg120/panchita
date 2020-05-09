import 'package:panchita/src/componentes/login/models/ciudad_model.dart';
import 'package:panchita/src/componentes/login/models/usuario_model.dart';
import 'package:panchita/src/plugins/firebase_service.dart';

class LoginRepocitorio {
  final String colletion = '/usuarios';
  final String ciudadesColletion = '/ciudades';

  Stream setUsuario(Usuario usuario) {
    return addDocument(colletion,id:usuario.idGoogle,data:{
      "email"     : usuario.email,
      "cedula"    : usuario.cedula,
      "nombre"    : usuario.nombre,
      "direccion" : usuario.direccion,
      "telefono"  : usuario.telefono,
      "ciudad"    : usuario.ciudad.toMap()
    });
  }

  Stream updateUsuario(Usuario usuario) {
    return updateDocument(colletion, usuario.idGoogle, {
      "email"     : usuario.email,
      "cedula"    : usuario.cedula,
      "nombre"    : usuario.nombre,
      "direccion" : usuario.direccion,
      "telefono"  : usuario.telefono,
      "ciudad"    : usuario.ciudad.toMap()
    });
  }

  Future<List<Ciudad>> getCiudades() async {
    final ciudades = await getDocument(ciudadesColletion, "AJf0lHfLMQavu0cxnhvm");
    return ciudades.data['ciudades'].map<Ciudad>((d) => Ciudad.map(d)).toList();
  }
  Future<Usuario> getUsuario(String uid) async {
      final usuario = await getDocument(colletion, uid);
      return Usuario.map(usuario);
  }
}
