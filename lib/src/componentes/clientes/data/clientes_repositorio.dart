import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchita/src/componentes/clientes/models/cliente_model.dart';
import 'package:panchita/src/plugins/firebase_service.dart';

class ClientesRepositorio {

 final String colletion = 'clientes';

Future<List<Cliente>> getClientes() async {
  final clientes = await getDocuments(colletion);
  return clientes.documents.map((c)=>Cliente.map(c)).toList();
}

 Stream<DocumentReference> setCliente(Cliente cliente){
    return addDocument(colletion,data:cliente.toMap());
 }
 Stream borrarCliente(String id){
    return deleteDocument(colletion, id);
 }
  
Stream actualizarCliente(Cliente cliente){
    return updateDocument(colletion, cliente.id,{
           'nombre'   : cliente.nombre,
           'cedula'   : cliente.cedula,
           'telefono' : cliente.telefono,
           'direccion': cliente.direccion,
           'ciudad'   : cliente.ciudad.toMap()
    });
 }
}