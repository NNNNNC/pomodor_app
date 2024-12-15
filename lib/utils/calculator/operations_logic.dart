class OperationUtil {
  static String total(List<String> history) {
    String result = '';
    double a = 0;
    double b = 0;
    String operator = '';

    for (String item in history) {
      double? operand = double.tryParse(item);

      if (operand == null) {
        operator = item;
      } else {
        if (operator != '') {
          b = operand;

          switch (operator) {
            case '/':
              if (b == 0) {
                return 'Undefined';
              }
              result = (a / b).toString();
              a = a / b;
              break;
            case 'x':
              result = (a * b).toString();
              a = a * b;
              break;
            case '-':
              result = (a - b).toString();
              a = a - b;
              break;
            case '+':
              result = (a + b).toString();
              a = a + b;
              break;
            default:
              break;
          }
        } else {
          a = operand;
        }
      }
    }

    if (result.contains('.') && result.endsWith('.0')) {
      result = result.substring(0, result.length - 2);
    }

    return result;
  }
}
