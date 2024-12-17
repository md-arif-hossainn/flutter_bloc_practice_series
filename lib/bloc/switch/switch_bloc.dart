import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_count/bloc/switch/switch_event.dart';
import 'package:flutter_bloc_count/bloc/switch/switch_state.dart';


class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchState()) {
    on<EnableOrDisableNotification>(_enableOrDisableNotification);
    on<SliderEvent>(_slider);

  }

  void _enableOrDisableNotification(EnableOrDisableNotification event, Emitter<SwitchState> emit){
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }

  void _slider(SliderEvent event, Emitter<SwitchState> emit){
    emit(state.copyWith(slider: event.slider.toDouble()));
  }

}
