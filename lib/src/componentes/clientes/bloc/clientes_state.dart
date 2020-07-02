part of 'clientes_bloc.dart';

class ClientesState extends Equatable {
  final List<Cliente> clientes;
  final  List<Cliente> searchclientes;
  final bool duplicado;
  final bool agregado;
  final bool eliminado;
  final bool actulizado;
  final bool loading;

  ClientesState(
      {this.clientes,
      this.duplicado,
      this.agregado,
      this.eliminado,
      this.actulizado,
      this.loading,
      this.searchclientes});

  factory ClientesState.initial() {
    return ClientesState(
        clientes       : [],
        searchclientes : [],
        duplicado      : false,
        agregado       : false,
        eliminado      : false,
        actulizado     : false,
        loading        : true);
  }

  ClientesState copyWith(
      {
      List<Cliente> clientes,
      List<Cliente> searchclientes,
      bool duplicado,
      bool agregado,
      bool eliminado,
      bool actulizado,
      bool loading
      }) {
    return ClientesState(
        clientes       : clientes       ?? this.clientes,
        searchclientes : searchclientes ?? this.searchclientes,
        duplicado      : duplicado      ?? this.duplicado,
        agregado       : agregado       ?? this.agregado,
        eliminado      : eliminado      ?? this.eliminado,
        actulizado     : actulizado     ?? this.actulizado,
        loading        : loading        ?? this.loading);
  }

  bool isExits(String celuda) {
    bool existe = false;
    if (clientes.length == 0) return false;
    this.clientes.forEach((c) {
      if (c.cedula == celuda) existe = true;
    });
    return existe;
  }

  @override
  List<Object> get props =>
      [
       clientes,
       searchclientes,
       duplicado,
       agregado,
       eliminado,
       actulizado,
       loading
      ];
}
