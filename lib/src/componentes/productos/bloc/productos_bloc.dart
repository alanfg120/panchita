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
  List<Producto> allproductos;
  List categorias;
  List marcas;
  ProductosBloc({this.repo});
  @override
  ProductosState get initialState => ProductosState.initial();

  @override
  Stream<ProductosState> mapEventToState(
    ProductosEvent event,
  ) async* {
    if (event is GetCategoriasEvent)  yield* _getCategorias(state);
    if (event is GetMarcasEvent)      yield* _getMarcas(state);
    if (event is GetProductosEvent)   yield* _getProductos(state);
    if (event is ResetCantidadEvent)  yield* _resetCantidad(event, state);
    if (event is SearchProductoEvent) yield* _searchProducto(event, state);
    if (event is FilterProductoEvent) yield* _filterProducto(event, state);
    if (event is CreateProductoEvent) yield* _createProducto(event, state);
  }

  Stream<ProductosState> _getCategorias(ProductosState state) async* {
    yield state.copyWith(
        productos: allproductos,
        preferencias: categorias,
        preferencia: 'Categorias',
        selectPreferencia: 0);
  }

  Stream<ProductosState> _getMarcas(ProductosState state) async* {
    yield state.copyWith(
        productos: allproductos,
        preferencias: marcas,
        preferencia: 'Marcas',
        selectPreferencia: 0);
  }

  Stream<ProductosState> _getProductos(ProductosState state) async* {
    categorias   = await repo.getCategorias();
    marcas       = await repo.getMarcas();
    allproductos = await repo.getProductos();
    yield state.copyWith(productos: allproductos);
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
    final result = allproductos
        .where(
            (p) => p.nombre.toLowerCase().startsWith(event.query.toLowerCase()))
        .toList();
    if (event.query == '')
      yield state.copyWith(resultSearch: []);
    else
      yield state.copyWith(resultSearch: result);
  }

  Stream<ProductosState> _filterProducto(
      FilterProductoEvent event, ProductosState state) async* {
    if (state.preferencia == 'Categorias') {
      if (event.query == "Todos")
        yield state.copyWith(
            productos: allproductos, selectPreferencia: event.select);
      else {
        final resultado =
            allproductos.where((p) => p.categoria == event.query).toList();
        yield state.copyWith(
            productos: resultado, selectPreferencia: event.select);
      }
    }
    if (state.preferencia == 'Marcas') {
      if (event.query == "Todos")
        yield state.copyWith(
            productos: allproductos, selectPreferencia: event.select);
      else {
        final resultado =
            allproductos.where((p) => p.marca == event.query).toList();
        yield state.copyWith(
            productos: resultado, selectPreferencia: event.select);
      }
    }
  }

  Stream<ProductosState> _createProducto(
      CreateProductoEvent event, ProductosState state) async* {
     print(state.isExist(event.producto.codigo));
    if(!state.isExist(event.producto.codigo)){

       state.productos.insert(0, event.producto);
       //repo.setProducto(event.producto);
       yield state.copyWith(productos: state.productos,productoAdd: true);
       yield state.copyWith(productoAdd: false);
    }
    else {
       print(event.producto.nombre);
     yield state.copyWith(existProducto: true);
     yield state.copyWith(existProducto: false,productoAdd: false);
    } 
  
  }
}
 