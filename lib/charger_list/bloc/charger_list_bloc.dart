import 'package:equatable/equatable.dart';
import 'package:eve_demo/network/api/api_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/charger_model.dart';

part 'charger_list_event.dart';
part 'charger_list_state.dart';

class ChargerListBloc extends Bloc<ChargerListEvent, ChargerListState> {

  final ApiHelper apiHelper = ApiHelper();

  ChargerListBloc() : super(ChargerListInitialState()) {
    on<LoadListEvent>((event, emit) async {
      emit(ChargerListLoadingState());
      List<ChargerModel> list = await apiHelper.fetchChargeStations();
      if(list.isEmpty){
        emit(const ChargerListLoadingFailedState(error: "Could not fetch chargers"));
      }else{
        emit(ChargerListLoadingSuccessState(list: list));
      }
    });
  }
}
