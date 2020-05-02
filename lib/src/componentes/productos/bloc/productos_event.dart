part of 'productos_bloc.dart';

@immutable
abstract class ProductosEvent extends Equatable {}

class GetProductosEvent extends ProductosEvent {
  @override
  List<Object> get props => [];
}

class GetMarcasEvent extends ProductosEvent{
  @override
  List<Object> get props => [];
}

class GetCategoriasEvent extends ProductosEvent{
  @override
  List<Object> get props => [];
}