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
  final String id;
  SendPedidoEvent({this.id, this.pedido});
  @override
  List<Object> get props => [id, pedido];
}

class GetPedidosEvent extends PedidosEvent {
  final String cedula;
  GetPedidosEvent({this.cedula});
  @override
  List<Object> get props => [cedula];
}

class FinishPedidoEvent extends PedidosEvent {
  @override
  List<Object> get props => [];
}
