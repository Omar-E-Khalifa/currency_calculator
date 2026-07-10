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

      case '%' || '÷' || '×' || '-' || '+':
        isCalculated
            ? emit(
                DisplayAreaState(result: '', typedValue: state.result + button))
            : emit(DisplayAreaState(typedValue: state.typedValue + button));
        isCalculated = false;
        break;

      case '.':
        int lastOpIndex = state.typedValue.lastIndexOf(RegExp(r'[+\-×÷]'));
        String currentSegment = state.typedValue.substring(lastOpIndex + 1);
        bool hasDecimal = currentSegment.contains('.');

        if (isCalculated) {
          emit(DisplayAreaState(result: '', typedValue: button));
        } else if (hasDecimal) {
          emit(DisplayAreaState(typedValue: state.typedValue));
        } else {
          emit(DisplayAreaState(typedValue: state.typedValue + button));
        }

        isCalculated = false;
        break;

      default:
        isCalculated
            ? emit(DisplayAreaState(result: '', typedValue: button))
            : emit(DisplayAreaState(typedValue: state.typedValue + button));
        isCalculated = false;
        break;
    }
  }

  num? calculate(String expression) {
    try {
      String updatedValue = expression.replaceAllMapped(
          RegExp(r'(^|[+\-×÷])\.'), (match) => '${match.group(1)}0.');
      updatedValue = updatedValue.replaceAll('×', '*').replaceAll('÷', '/');
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
