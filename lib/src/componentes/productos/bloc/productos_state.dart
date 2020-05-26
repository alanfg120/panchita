part of 'productos_bloc.dart';

class ProductosState extends Equatable {
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
      this.selectPreferencia});

  factory ProductosState.initial() => ProductosState(
      preferencias: [],
      productos: [],
      resultSearch: [],
      preferencia: '',
      selectPreferencia: 0);

  ProductosState copyWith(
          {List preferencias,
          List<Producto> productos,
          bool sendPedido,
          List<Producto> resultSearch,
          String preferencia,
          int selectPreferencia}) =>
      ProductosState(
          preferencias: preferencias           ?? this.preferencias,
          productos: productos                 ?? this.productos,
          resultSearch: resultSearch           ?? this.resultSearch,
          preferencia: preferencia             ?? this.preferencia,
          selectPreferencia: selectPreferencia ?? this.selectPreferencia);

  @override
  List<Object> get props =>
      [preferencias, productos, resultSearch, preferencia, selectPreferencia];
}
