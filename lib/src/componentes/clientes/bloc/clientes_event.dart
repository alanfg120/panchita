part of 'clientes_bloc.dart';

@immutable
abstract class ClientesEvent extends Equatable {}

class GetClientesEvent extends ClientesEvent {
  @override
  List<Object> get props => [];
}

class CreateClienteEvent extends ClientesEvent {
  final Cliente cliente;
  CreateClienteEvent({this.cliente});
  @override
  List<Object> get props => [cliente];
}
class UpdateClienteEvent extends ClientesEvent {
  final Cliente cliente;
  UpdateClienteEvent({this.cliente});
  @override
  List<Object> get props => [cliente];
}
class DeleteClienteEvent extends ClientesEvent {
  final int index;
  final String id;
  DeleteClienteEvent({this.index,this.id});
  @override
  List<Object> get props => [index,id];
}
class SearchClienteEvent extends ClientesEvent {
  final String query;
  SearchClienteEvent({this.query});
  @override
  List<Object> get props => [query];
}

