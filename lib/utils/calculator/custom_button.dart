import 'package:flutter/material.dart';
import 'notifiers.dart';
import 'constants.dart';
import 'operations_logic.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.shadowOffset,
    this.borderWidth,
    this.child,
    this.buttonType,
    this.buttonValue,
    this.color,
  });

  final double? height;
  final double? width;
  final double? borderRadius;
  final double? borderWidth;
  final Offset? shadowOffset;
  final Widget? child;
  final KeyTypes? buttonType;
  final String? buttonValue;
  final Color? color;

  final List operators = ['+', '-', 'x', '/'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String screenValue = Notifiers.screenDisplayNotifier.value;

        switch (buttonType) {
          case KeyTypes.action:
            if (Notifiers.screenDisplayNotifier.value == '') {
              break;
            }
            if (buttonValue == 'AC') {
              Notifiers.screenDisplayNotifier.value = '';
              Notifiers.historyDisplayNotifier.value = [];
              Notifiers.isEquationCompleteNotifier.value = false;
            }
            if (buttonValue == '+/-') {
              if (screenValue.contains('-')) {
                Notifiers.screenDisplayNotifier.value =
                    screenValue.replaceAll('-', '');
              } else {
                Notifiers.screenDisplayNotifier.value = '-' + screenValue;
              }
            }
            if (buttonValue == '%') {
              Notifiers.screenDisplayNotifier.value =
                  (int.parse(screenValue) / 100).toString();
            }
            break;
          case KeyTypes.operator:
            if (Notifiers.screenDisplayNotifier.value == '') {
              break;
            }
            String displayValue = Notifiers.screenDisplayNotifier.value;
            Notifiers.screenDisplayNotifier.value =
                buttonValue == '=' ? '' : buttonValue;

            List<String> result = Notifiers.historyDisplayNotifier.value;
            result.add(displayValue);
            Notifiers.historyDisplayNotifier.value = result;

            if (buttonValue == '=') {
              Notifiers.screenDisplayNotifier.value = OperationUtil.total(
                Notifiers.historyDisplayNotifier.value,
              );
              Notifiers.historyDisplayNotifier.value = [];
              Notifiers.isEquationCompleteNotifier.value = true;
            } else {
              List<String> result = [];
              for (var element in Notifiers.historyDisplayNotifier.value) {
                result.add(element);
              }
              result.add(buttonValue!);
              Notifiers.historyDisplayNotifier.value = result;
              Notifiers.isEquationCompleteNotifier.value = false;
            }
            break;
          case KeyTypes.digit:
            if (Notifiers.isEquationCompleteNotifier.value) {
              screenValue = '';
              Notifiers.isEquationCompleteNotifier.value = false;
            }

            if (operators.contains(Notifiers.screenDisplayNotifier.value)) {
              screenValue = '';
            }

            Notifiers.screenDisplayNotifier.value =
                screenValue + (buttonValue ?? '');
            break;
          default:
        }
      },
      child: Container(
        height: height ?? 80,
        width: width ?? 80,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          border: Border.all(
            color: Colors.black,
            width: borderWidth ?? 4,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: shadowOffset ?? const Offset(4, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
