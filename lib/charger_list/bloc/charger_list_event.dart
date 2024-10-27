part of 'charger_list_bloc.dart';

sealed class ChargerListEvent extends Equatable {
  const ChargerListEvent();
}

final class LoadListEvent extends ChargerListEvent{
  @override
  List<Object?> get props => [];
}
