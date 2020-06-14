import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:panchita/src/componentes/clientes/data/clientes_repositorio.dart';

part 'clientes_event.dart';
part 'clientes_state.dart';

class ClientesBloc extends Bloc<ClientesEvent, ClientesState> {

  final ClientesRepositorio repositorio;
  ClientesBloc({this.repositorio});

  @override
  ClientesState get initialState => ClientesInitial();

  @override
  Stream<ClientesState> mapEventToState(
    ClientesEvent event,
  ) async* {
    
  }
}
