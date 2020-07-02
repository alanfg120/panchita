import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:panchita/src/componentes/clientes/models/cliente_model.dart';

import 'package:panchita/src/componentes/pedidos/data/pedidos_repocitorio.dart';
import 'package:panchita/src/componentes/pedidos/models/pedido_model.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';

part 'pedidos_event.dart';
part 'pedidos_state.dart';

class PedidosBloc extends Bloc<PedidosEvent, PedidosState> {
  final PedidoRepositorio repocitorio;

  PedidosBloc({this.repocitorio});

  @override
  PedidosState get initialState => PedidosState.initial();

  @override
  Stream<PedidosState> mapEventToState(
    PedidosEvent event,
  ) async* {
    if (event is AddProductoEvent)    yield* _addProducto(event, state);
    if (event is DeleteProductoEvent) yield* _deleteProducto(event, state);
    if (event is GetPedidosEvent)     yield* _getPedidos(event, state);
    if (event is SendPedidoEvent)     yield* _addPedido(event, state);
    if (event is FinishPedidoEvent)   yield* _finishPedido(event, state);
    if (event is ConfirmPedidoEvent)  yield* _confirmPedido(event, state);
    if (event is SelectClienteEvent)  yield* _selectCliente(event, state);
  }

  Stream<PedidosState> _addProducto(
      AddProductoEvent event, PedidosState state) async* {
    if (!state.isExist(event.producto)) state.productos.add(event.producto);
    int total = state.calcularTotal(state.productos, event.ruta);
    yield state.copyWith(productos: state.productos, total: total);
  }

  Stream<PedidosState> _deleteProducto(
      DeleteProductoEvent event, PedidosState state) async* {
    state.productos.removeAt(event.index);
    int total = state.calcularTotal(state.productos, event.ruta);
    yield state.copyWith(productos: state.productos, total: total);
  }

  Stream<PedidosState> _getPedidos(
      GetPedidosEvent event, PedidosState state) async* {
    List<Pedido> pedidos;
    if (event.vendedor)
      pedidos =
          await repocitorio.getPedidos(event.cedula, query: 'cedula_vendedor');
    else
      pedidos =
          await repocitorio.getPedidos(event.cedula, query: 'cliente.cedula');
    yield state.copyWith(pedidos: pedidos);
  }

  Stream<PedidosState> _addPedido(
      SendPedidoEvent event, PedidosState state) async* {
    repocitorio.setPedido(event.pedido).listen((data) {
      event.pedido.id = data.documentID;
      add(FinishPedidoEvent(pedido: event.pedido));
    });
    yield state.copyWith(sendPedido: true);
  }

  Stream<PedidosState> _finishPedido(
      FinishPedidoEvent event, PedidosState state) async* {
    state.pedidos.add(event.pedido);
    yield state.copyWith(
        pedidos: state.pedidos, productos: [], total: 0, sendPedido: false);
  }

  Stream<PedidosState> _confirmPedido(
      ConfirmPedidoEvent event, PedidosState state) async* {
    List<Pedido> pedidos = state.pedidos.map((p) {
      if (p.id == event.id) {
        p.confirmado = true;
        p.mensaje = event.mensaje;
      }
      return p;
    }).toList();
    state.pedidos.add(Pedido());
    repocitorio.updatePedido(event.id, event.mensaje);
    yield state.copyWith(pedidos: pedidos);
  }

  Stream<PedidosState> _selectCliente(
      SelectClienteEvent event, PedidosState state) async* {
    yield state.copyWith(cliente: event.cliente);
  }
}
