part of 'productos_bloc.dart';

@immutable
abstract class ProductosEvent extends Equatable {}

class GetProductosEvent extends ProductosEvent {
  @override
  List<Object> get props => [];
}

class GetMarcasEvent extends ProductosEvent {
  @override
  List<Object> get props => [];
}

class GetCategoriasEvent extends ProductosEvent {
  @override
  List<Object> get props => [];
}

class SearchProductoEvent extends ProductosEvent {
  final String query;
  SearchProductoEvent({this.query});
  @override
  List<Object> get props => [query];
}

class ResetCantidadEvent extends ProductosEvent {
  final String codigo;
  ResetCantidadEvent({this.codigo});
  @override
  List<Object> get props => [codigo];
}

