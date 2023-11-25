// import 'dart:io';

//calculates the sum of the elements of the list/array
int calculateSum(List<int> numbers) {
  int sum = 0;
  for (int number in numbers) {
    sum += number;
  }
  return sum;
}

//calculates the average of the elements of the list/array
double calculateAverage(List<int> numbers) {
  int sumOfElements = calculateSum(numbers);
  return sumOfElements / numbers.length;
}

//finds the maximum element from the list/array
int findMaximum(List<int> numbers) {
  int maxNumber = numbers[0];
  for (int i = 0; i < numbers.length; i++) {
    if (numbers[i] > maxNumber) {
      maxNumber = numbers[i];
    }
  }
  return maxNumber;
}

//finds the minimum element from the list/array
int findMinimum(List<int> numbers) {
  int minNumber = numbers[0];
  for (int number in numbers) {
    if (number < minNumber) {
      minNumber = number;
    }
  }
  return minNumber;
}

void main() {
  //the following commented code populates the list/array with user's input
  // List<int> numList = [];
  // for (int i = 0; i < 6; i++) {
  //   print('Enter the elements of the array');
  //   int input = int.parse(stdin.readLineSync()!);
  //   numList.add(input);

  //but for our simple case, let's use a hardcoded list example
  final numbersList = [2, 9, 5, 3, 7, 45, 87, 69, 10, 39, 91, 76];

  print('Sum of the elements is ${calculateSum(numbersList)}');
  print('Average of the elements is ${calculateAverage(numbersList)}');
  print('The minimum number in the list is ${findMinimum(numbersList)}');
  print('The maximum number in the list is ${findMaximum(numbersList)}');
}
