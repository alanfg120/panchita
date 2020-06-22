part of 'productos_bloc.dart';

class ProductosState extends Equatable {
  final bool productoAdd;
  final bool existProducto;
  final List preferencias;
  final List<Producto> productos;
  final List<Producto> resultSearch;
  final String preferencia;
  final int selectPreferencia;

  ProductosState(
      {this.preferencias,
      this.productos,
      this.resultSearch,
      this.preferencia,
      this.selectPreferencia,
      this.existProducto,
      this.productoAdd});

  factory ProductosState.initial() => ProductosState(
      preferencias      : [],
      productos         : [],
      resultSearch      : [],
      preferencia       : '',
      selectPreferencia : 0,
      existProducto     : false,
      productoAdd       : false);

  ProductosState copyWith(
          {List preferencias,
          List<Producto> productos,
          bool sendPedido,
          List<Producto> resultSearch,
          String preferencia,
          int selectPreferencia,
          bool existProducto,
          bool productoAdd}) =>
      ProductosState(
          preferencias: preferencias           ?? this.preferencias,
          productos: productos                 ?? this.productos,
          resultSearch: resultSearch           ?? this.resultSearch,
          preferencia: preferencia             ?? this.preferencia,
          selectPreferencia: selectPreferencia ?? this.selectPreferencia,
          existProducto: existProducto         ?? this.existProducto,
          productoAdd: productoAdd             ?? this.productoAdd);

  bool isExist(String codigo) {
    bool existe = false;
    if (productos.length == 0) return false;
    this.productos.forEach((p) {
      print(p.codigo);
      if (p.codigo == codigo) existe = true;
    });
    return existe;
  }

  @override
  List<Object> get props => [
        preferencias,
        productos,
        resultSearch,
        preferencia,
        selectPreferencia,
        existProducto,
        productoAdd
      ];
}
