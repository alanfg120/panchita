part of 'pedidos_bloc.dart';

@immutable
abstract class PedidosEvent extends Equatable {}

class AddProductoEvent extends PedidosEvent {
  final Producto producto;
  final String ruta;
  AddProductoEvent({this.producto, this.ruta});
  @override
  List<Object> get props => [producto, ruta];
}

class DeleteProductoEvent extends PedidosEvent {
  final int index;
  final String ruta;
  DeleteProductoEvent({this.index, this.ruta});
  @override
  List<Object> get props => [index, ruta];
}

class SendPedidoEvent extends PedidosEvent {
  final Pedido pedido;
  SendPedidoEvent({this.pedido});
  @override
  List<Object> get props => [pedido];
}

class GetPedidosEvent extends PedidosEvent {
  final bool vendedor;
  final String cedula;
  GetPedidosEvent({this.cedula,this.vendedor});
  @override
  List<Object> get props => [cedula,vendedor];
}

class FinishPedidoEvent extends PedidosEvent {
  final Pedido pedido;
  FinishPedidoEvent({this.pedido});
  @override
  List<Object> get props => [pedido];
}

class ConfirmPedidoEvent extends PedidosEvent {
  final String mensaje;
  final String id;
  ConfirmPedidoEvent({this.id,this.mensaje});
  @override
  List<Object> get props => [id,mensaje];
}
class SelectClienteEvent extends PedidosEvent {
  final Cliente cliente;
   SelectClienteEvent({this.cliente});
  @override
  List<Object> get props => [cliente];
}
