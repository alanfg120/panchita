import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'compras_event.dart';
part 'compras_state.dart';

class ComprasBloc extends Bloc<ComprasEvent, ComprasState> {
  @override
  ComprasState get initialState => ComprasInitial();

  @override
  Stream<ComprasState> mapEventToState(
    ComprasEvent event,
  ) async* {

  }
}
