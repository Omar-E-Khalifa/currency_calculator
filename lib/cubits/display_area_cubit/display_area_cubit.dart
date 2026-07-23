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
        calcResult != null ? isCalculated = true : isCalculated = false;

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

      case '%' || '÷' || '×' || '+':
        if (isCalculated) {
          emit(DisplayAreaState(result: '', typedValue: state.result + button));
        } else {
          int lastOpIndex = state.typedValue.lastIndexOf(RegExp(r'[+×÷]'));
          int lastNegIndex = state.typedValue.lastIndexOf(RegExp(r'\-'));
          if (state.typedValue.isNotEmpty &&
              lastOpIndex == state.typedValue.length - 1) {
            emit(
              DisplayAreaState(
                  typedValue: state.typedValue
                          .substring(0, state.typedValue.length - 1) +
                      button),
            );
          } else if (state.typedValue.isNotEmpty &&
              lastNegIndex == state.typedValue.length - 1) {
            if (state.typedValue.length == 1) {
              emit(DisplayAreaState(typedValue: ""));
            } else if (lastOpIndex == state.typedValue.length - 2) {
              emit(
                DisplayAreaState(
                    typedValue: state.typedValue
                            .substring(0, state.typedValue.length - 2) +
                        button),
              );
            } else {
              emit(DisplayAreaState(
                  typedValue: state.typedValue
                          .substring(0, state.typedValue.length - 1) +
                      button));
            }
          } else if (state.typedValue.isEmpty) {
            emit(DisplayAreaState(typedValue: ''));
          } else {
            emit(DisplayAreaState(typedValue: state.typedValue + button));
          }
        }

        isCalculated = false;
        break;

      case '-':
        if (isCalculated) {
          emit(DisplayAreaState(result: '', typedValue: state.result + button));
        } else {
          int lastNegIndex = state.typedValue.lastIndexOf(RegExp(r'\-'));
          if (state.typedValue.isNotEmpty &&
              lastNegIndex == state.typedValue.length - 1) {
            emit(
              DisplayAreaState(
                  typedValue: state.typedValue
                          .substring(0, state.typedValue.length - 1) +
                      button),
            );
          } else if (state.typedValue.isEmpty) {
            emit(DisplayAreaState(typedValue: button));
          } else {
            emit(
              DisplayAreaState(typedValue: state.typedValue + button),
            );
          }
        }
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
      updatedValue = updatedValue.replaceAllMapped(
          RegExp(r'\.($|[+\-×÷])'), (match) => '.0${match.group(1)}');
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
