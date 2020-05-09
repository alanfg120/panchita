import 'package:panchita/src/componentes/pedidos/models/pedido_model.dart';
import 'package:panchita/src/plugins/firebase_service.dart';

class PedidoRepositorio {
final String colletion = '/pedidos';

Stream setPedido(Pedido pedido,String id){
    return addDocument(colletion,data:{
      "nombre_cliente" : pedido.nombreCliente,
      "ciudad"         : pedido.ciudad.ciudad,
      "direccion"      : pedido.direccion,
      "cedula_cliente" : pedido.cedula,
      "productos"      : pedido.productos.map((p)=>p.toMap(pedido.ciudad)).toList(),
      "total"          : pedido.total,
      "observacion"    : pedido.observacion,
      "confirmado"     : pedido.confirmado
    });
}


}