part of 'pedidos_bloc.dart';

class PedidosState extends Equatable {

  final List<Pedido> pedidos;
  final List<Producto> productos;
  final int total;
  final bool sendPedido;

  PedidosState({this.productos, this.total, this.pedidos,this.sendPedido});

  factory PedidosState.initial() {
    return PedidosState(productos: [], total: 0, pedidos: [],sendPedido: false);
  }

  PedidosState copyWith(
      {List<Producto> productos, int total, List<Pedido> pedidos,bool sendPedido}) {
    return PedidosState(
        productos : productos  ?? this.productos,
        total     : total      ?? this.total,
        pedidos   : pedidos    ?? this.pedidos,
        sendPedido: sendPedido ?? this.sendPedido 
        );
  }

  int calcularTotal(List<Producto> productos, String ruta) {
    int total = 0;
    productos.forEach((p) {
      total = total + (p.cantidadCompra * p.getPrecio(ruta));
    });
    return total;
  }

  bool isExist(Producto producto) {
    bool existe = false;
    if (productos.length == 0) return false;
    productos.forEach((p) {
      if (p.codigo == producto.codigo) existe = true;
    });
    return existe;
  }

  @override
  List<Object> get props => [productos,total,pedidos,sendPedido];

 @override
  String toString()=>'$pedidos';

}
