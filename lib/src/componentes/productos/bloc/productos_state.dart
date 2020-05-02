part of 'productos_bloc.dart';

class ProductosState extends Equatable {
  final List marcas;
  final List categorias;
  final List<Producto> productos;

  ProductosState({this.marcas, this.categorias, this.productos});

  factory ProductosState.initial() =>
      ProductosState(categorias: [], marcas: [], productos: []);

  ProductosState copyWith(
          {List marcas, List categorias, List<Producto> productos}) =>
      ProductosState(
          marcas     : marcas     ?? this.marcas,
          categorias : categorias ?? this.categorias,
          productos  : productos  ?? this.productos);

  @override
  List<Object> get props => [marcas, categorias,productos];
}
