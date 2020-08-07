import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:panchita/src/componentes/clientes/data/clientes_repositorio.dart';
import 'package:panchita/src/componentes/clientes/models/cliente_model.dart';
part 'clientes_event.dart';
part 'clientes_state.dart';

class ClientesBloc extends Bloc<ClientesEvent, ClientesState> {
  List<Cliente> clientes;
 
  final ClientesRepositorio repositorio;
  ClientesBloc({this.repositorio}) : super(ClientesState.initial());



  @override
  Stream<ClientesState> mapEventToState(
    ClientesEvent event,
  ) async* {
    if (event is GetClientesEvent) yield* _getClientes(event, state);
    if (event is CreateClienteEvent) yield* _createCliente(event, state);
    if (event is DeleteClienteEvent) yield* _deleteCliente(event, state);
    if (event is UpdateClienteEvent) yield* _updateCliente(event, state);
    if (event is SearchClienteEvent) yield* _buscarCliente(event, state);
  }

  Stream<ClientesState> _getClientes(
      GetClientesEvent event, ClientesState state) async* {
    clientes = await repositorio.getClientes();
    yield state.copyWith(clientes: clientes, loading: false);
  }

  Stream<ClientesState> _createCliente(
      CreateClienteEvent event, ClientesState state) async* {
    if (state.isExits(event.cliente.cedula)) {
      yield state.copyWith(duplicado: true);
      yield state.copyWith(duplicado: false);
    } else {
      state.clientes.add(event.cliente);
      repositorio.setCliente(event.cliente);
      yield state.copyWith(clientes: state.clientes, agregado: true);
      yield state.copyWith(agregado: false);
    }
  }

  Stream<ClientesState> _deleteCliente(
      DeleteClienteEvent event, ClientesState state) async* {
    state.clientes.removeAt(event.index);
    repositorio.borrarCliente(event.id);
    yield state.copyWith(clientes: state.clientes, eliminado: true);
    yield state.copyWith(eliminado: false);
  }

  Stream<ClientesState> _updateCliente(
      UpdateClienteEvent event, ClientesState state) async* {
    final index = state.clientes.indexWhere((c) => c.id == event.cliente.id);
    state.clientes[index] = event.cliente;
    repositorio.actualizarCliente(event.cliente);
    yield state.copyWith(clientes: state.clientes, actulizado: true);
    yield state.copyWith(actulizado: false);
  }

  Stream<ClientesState> _buscarCliente(
      SearchClienteEvent event, ClientesState state) async* {
    final result = clientes
        .where(
            (c) => c.nombre.toLowerCase().startsWith(event.query.toLowerCase()))
        .toList();
   if(event.query == '')
      yield state.copyWith(searchclientes: []);
   else yield state.copyWith(searchclientes: result);
  }
}
