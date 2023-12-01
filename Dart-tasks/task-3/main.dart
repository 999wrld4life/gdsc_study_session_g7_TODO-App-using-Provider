import 'dart:io';

class Calculator {
  double? numOne;
  double? numTwo;

  Calculator(double AnumOne, double AnumTwo) {
    this.numOne = AnumOne;
    this.numTwo = AnumTwo;
  }

  double calculateSum() {
    return this.numOne! + this.numTwo!;
  }

  double calculateProduct() {
    return this.numOne! * this.numTwo!;
  }

  double calculateDifference() {
    return this.numOne! - this.numTwo!;
  }

  double calculateQuotient() {
    if (this.numTwo == 0) {
      throw Exception('Error: Division by Zero');
    }
    return this.numOne! / this.numTwo!;
  }
}

void main() async {
  print('Enter the first number');
  double firstNum = double.parse(stdin.readLineSync()!);

  print("Enter the second number");
  double secondNum = double.parse(stdin.readLineSync()!);

  Calculator calculator = Calculator(firstNum, secondNum);
  await Future.delayed(Duration(seconds: 5));
  try {
    print(
        "The sum of $firstNum and $secondNum is ${calculator.calculateSum()}");
    print(
        "The product of $firstNum and $secondNum is ${calculator.calculateProduct()}");
    print(
        "The difference of $firstNum and $secondNum is ${calculator.calculateDifference()}");
    print(
        "The quotient of $firstNum and $secondNum is ${calculator.calculateQuotient()}");
  } catch (e) {
    print(e);
  }
}
