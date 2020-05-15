import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:panchita/src/componentes/productos/data/productos_repocitori.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';

part 'productos_event.dart';
part 'productos_state.dart';

class ProductosBloc extends Bloc<ProductosEvent, ProductosState> {
  final ProductoRepocitorio repo;
  ProductosBloc({this.repo});
  @override
  ProductosState get initialState => ProductosState.initial();

  @override
  Stream<ProductosState> mapEventToState(
    ProductosEvent event,
  ) async* {
    if (event is GetCategoriasEvent) yield* _getCategorias(state);
    if (event is GetMarcasEvent) yield* _getMarcas(state);
    if (event is GetProductosEvent) yield* _getProductos(state);
    if (event is ResetCantidadEvent) yield* _resetCantidad(event, state);
    if (event is SearchProductoEvent) yield* _searchProducto(event, state);
  }

  Stream<ProductosState> _getCategorias(ProductosState state) async* {
    final categorias = await repo.getCategorias();
    yield state.copyWith(preferencias: categorias,preferencia:'Categorias');
  }

  Stream<ProductosState> _getMarcas(ProductosState state) async* {
    final marcas = await repo.getMarcas();
    yield state.copyWith(preferencias: marcas,preferencia:'Marcas');
  }

  Stream<ProductosState> _getProductos(ProductosState state) async* {
    final productos = await repo.getProductos();
    yield state.copyWith(productos: productos);
  }

  Stream<ProductosState> _resetCantidad(
      ResetCantidadEvent event, ProductosState state) async* {
    state.productos.forEach((p) {
      if (p.codigo == event.codigo) p.cantidadCompra = 1;
    });
    yield state.copyWith(productos: state.productos);
  }

  Stream<ProductosState> _searchProducto(
      SearchProductoEvent event, ProductosState state) async* {
    final result = state.productos
        .where(
            (p) => p.nombre.toLowerCase().startsWith(event.query.toLowerCase()))
        .toList();
    if (event.query == '')
      yield state.copyWith(resultSearch: []);
    else
      yield state.copyWith(resultSearch: result);
  }
}
