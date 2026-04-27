import 'package:bloc/bloc.dart';

part 'display_area_state.dart';

class DisplayAreaCubit extends Cubit<DisplayAreaState> {
  DisplayAreaCubit() : super(DisplayAreaState());

  void buttonPressed(String button) {
    switch (button) {
      case '=':
        emit(DisplayAreaState(
            result: state.result, typedValue: state.typedValue));
        break;
      case 'c':
        emit(DisplayAreaState(typedValue: ''));
        break;
      case 'back':
        emit(DisplayAreaState(
          result: state.result,
          typedValue: state.typedValue.isNotEmpty
              ? state.typedValue.substring(0, state.typedValue.length - 1)
              : '',
        ));
        break;

      default:
        emit(DisplayAreaState(typedValue: state.typedValue + button));
        break;
    }
  }
}
