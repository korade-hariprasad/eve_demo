part of 'charger_list_bloc.dart';

sealed class ChargerListState extends Equatable {
  const ChargerListState();
}

final class ChargerListInitialState extends ChargerListState {
  @override
  List<Object> get props => [];
}

final class ChargerListLoadingState extends ChargerListState{
  @override
  List<Object?> get props => [];
}

final class ChargerListLoadingFailedState extends ChargerListState{
  final String error;
  const ChargerListLoadingFailedState({required this.error});
  @override
  List<Object?> get props => [error];
}

final class ChargerListLoadingSuccessState extends ChargerListState{
  final List<ChargerModel> list;
  const ChargerListLoadingSuccessState({required this.list});
  @override
  List<Object?> get props => [list];
}