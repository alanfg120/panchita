import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchita/src/componentes/pedidos/models/pedido_model.dart';
import 'package:panchita/src/plugins/firebase_service.dart';

class PedidoRepositorio {
final String colletion = '/pedidos';

Stream<DocumentReference> setPedido(Pedido pedido){

    Map<String,dynamic> data;

    if(pedido.cedulaVendedor == '')
      data = {
     "cliente"         : pedido.cliente.toMap(),
     "token"           : pedido.token,
     "productos"       : pedido.productos.map((p)=>p.toMap(pedido.cliente.ciudad)).toList(),
     "total"           : pedido.total,
     "observacion"     : pedido.observacion,
     "confirmado"      : pedido.confirmado,
     "fecha"           : pedido.fecha,
     "enviado"         : pedido.enviado
    };
    else  data = {
     "cliente"         : pedido.cliente.toMap(),
     "token"           : pedido.token,
     "productos"       : pedido.productos.map((p)=>p.toMap(pedido.cliente.ciudad)).toList(),
     "total"           : pedido.total,
     "observacion"     : pedido.observacion,
     "confirmado"      : pedido.confirmado,
     "fecha"           : pedido.fecha,
     "cedula_vendedor" : pedido.cedulaVendedor,
     "vendedor"        : pedido.nombreVendedor,
     "enviado"         : pedido.enviado
    };
    return addDocument(colletion,data:data);
}

Stream updatePedido(String id,String mensaje){
    return updateDocument(colletion, id, {
           "confirmado": true,
           "mensaje"   : mensaje,
    });
}
Stream updatePedidoOnline(String id){
    return updateDocument(colletion, id, {
           "enviado": true
    });
}

Future<List<Pedido>> getPedidos(String valor,{String query}) async {
  final pedidos = await queryGetDocumento(colletion,query,valor);
  return pedidos.documents.map((p)=>Pedido.map(p)).toList();
}

}