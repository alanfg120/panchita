import 'package:panchita/src/componentes/pedidos/models/pedido_model.dart';
import 'package:panchita/src/plugins/firebase_service.dart';

class PedidoRepositorio {
final String colletion = '/pedidos';

Stream setPedido(Pedido pedido){
    return addDocument(colletion,id: pedido.id,data:{
      "telefono"       : pedido.telefono,
      "nombre_cliente" : pedido.nombreCliente,
      "token"          : pedido.token,
      "ciudad"         : pedido.ciudad.ciudad,
      "direccion"      : pedido.direccion,
      "cedula_cliente" : pedido.cedula,
      "productos"      : pedido.productos.map((p)=>p.toMap(pedido.ciudad)).toList(),
      "total"          : pedido.total,
      "observacion"    : pedido.observacion,
      "confirmado"     : pedido.confirmado,
      "fecha"          : pedido.fecha
    });
}

Future<List<Pedido>> getPedidos(String valor) async {
  final pedidos = await queryGetDocumento(colletion,'cedula_cliente',valor);
  return pedidos.documents.map((p)=>Pedido.map(p)).toList();
}

}