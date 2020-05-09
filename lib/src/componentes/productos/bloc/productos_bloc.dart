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
    if (event is GetMarcasEvent)     yield* _getMarcas(state);
    if (event is GetProductosEvent)  yield* _getProductos(state);
    if (event is ResetCantidadEvent) yield* _resetCantidad(event,state);
  }

  Stream<ProductosState> _getCategorias(ProductosState state) async* {
    final categorias = await repo.getCategorias();
    yield state.copyWith(categorias: categorias);
  }

  Stream<ProductosState> _getMarcas(ProductosState state) async* {
    final marcas = await repo.getMarcas();
    yield state.copyWith(marcas: marcas);
  }

  Stream<ProductosState> _getProductos(ProductosState state) async* {
    final productos = await repo.getProductos();
    yield state.copyWith(productos: productos);
  }

  Stream<ProductosState> _resetCantidad(ResetCantidadEvent event, ProductosState state) async* {
   state.productos.forEach((p){
       if(p.codigo==event.codigo)
          p.cantidadCompra = 1;
   });
     yield state.copyWith(productos: state.productos);
  }
}
