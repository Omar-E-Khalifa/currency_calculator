import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:math_expressions/math_expressions.dart';

part 'display_area_state.dart';

class DisplayAreaCubit extends Cubit<DisplayAreaState> {
  DisplayAreaCubit() : super(DisplayAreaState());

  bool isCalculated = false;

  void buttonPressed(String button) {
    switch (button) {
      case '=':
        num? calcResult = calculate(state.typedValue);
        emit(DisplayAreaState(
            result: calcResult == null ? '' : calcResult.toString(),
            typedValue: state.typedValue));
        state.result != '' ? isCalculated = true : isCalculated = false;

        break;

      case 'c':
        emit(DisplayAreaState(typedValue: ''));
        isCalculated = false;
        break;

      case 'back':
        isCalculated
            ? emit(DisplayAreaState(result: '', typedValue: state.typedValue))
            : emit(DisplayAreaState(
                result: '',
                typedValue: state.typedValue.isNotEmpty
                    ? state.typedValue.substring(0, state.typedValue.length - 1)
                    : '',
              ));
        isCalculated = false;
        break;

      default:
        isCalculated = false;
        emit(DisplayAreaState(typedValue: state.typedValue + button));
        break;
    }
  }

  num? calculate(String expression) {
    try {
      String updatedValue =
          expression.replaceAll('×', '*').replaceAll('÷', '/');
      ExpressionParser p = GrammarParser();
      Expression exp = p.parse(updatedValue);

      var context = ContextModel();

      // Evaluate expression:
      var evaluator = RealEvaluator(context);
      num eval = evaluator.evaluate(exp);

      if (eval.isInfinite || eval.isNaN) {
        return null;
      }
      num formatted =
          eval % 1 == 0 ? eval.toInt() : eval; //return int or double
      return formatted;
    } on FormatException {
      return null;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
