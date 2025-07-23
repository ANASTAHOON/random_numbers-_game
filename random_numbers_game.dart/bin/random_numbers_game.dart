import 'dart:io';
import 'dart:math';

void main() {
  // >>>> Take the MAX and MIN values from the user <<<<<
  double correctAnswers = 0;
  double wrongAnswers = 0;
  int level = 1;
  String continuePlay = 'yes';

  print(" WELCOME TO THE MATCH GAME ");
  print("Please enter Enter range ( MIN ) space  ( MAX ) numbers ");

  List<String> rangeNumbers = (stdin.readLineSync() ?? '').split(' ');
  int rangeMin = int.parse(rangeNumbers[0]);
  int rangeMax = int.parse(rangeNumbers[1]);



  while (continuePlay.toLowerCase() == 'yes') {
    // >>>>> TASK 2 ADD LEVELS <<<<
    List<String> operations = ['+'];
        // in lvl 1 we have only "+" operation

    int currentRangeMax = rangeMax + (level - 1) * 10;
// i used this formula so that each level increases the range
    //without increasing it from the first level  because it will be multiplied by 0 at the beginning

    if (level >= 2) operations.add('-');
    if (level >= 3) operations.add('*');
    if (level >= 4) operations.add('/');
// to add extra operations in each level

    Random random = Random();
    int num1 = random.nextInt(currentRangeMax - rangeMin + 1) + rangeMin;
    int num2 = random.nextInt(currentRangeMax - rangeMin + 1) + rangeMin;
    String op = operations[random.nextInt(operations.length)];
    double correctAnswer;
// generata numbers in random

    if (op == '+') {
      correctAnswer = num1 + num2.toDouble();
    } else if (op == '-') {
      correctAnswer = num1 - num2.toDouble();
    } else if (op == '*') {
      correctAnswer = num1 * num2.toDouble();
    } else {
      while (num2 == 0 || (num1 / num2) != (num1 / num2).truncateToDouble()) {
        num2 = random.nextInt(currentRangeMax - rangeMin + 1) + rangeMin;
      }
            //regenerate new numbers if the division is not an integer

      correctAnswer = (num1 / num2).truncateToDouble();
    }

    print("Level $level  Solve $num1 $op $num2 = ?");
    double Answer = double.parse(stdin.readLineSync()!);
//i could use abs() to turn negative values into positive as well
    //but that would make most answers appear correct and the final score wouldn’t be accurate
    // so I removed it.

    if (Answer == correctAnswer) {
      print("Correct Answer");
      correctAnswers++;

      if (correctAnswers % 4 == 0 && level < 4) {
        level++;
        print(" Wowww Pass Level Welcome to Level $level");
      } else if (level == 4) {
        print(" You reached the maximum level");
      }
    } else {
      print(" Wrong Answer The correct answer is ${correctAnswer.toStringAsFixed(2)}");
      wrongAnswers++;
    }

    print("Do you want to continue? (yes/no)");
    continuePlay = stdin.readLineSync() ?? 'no';
//null aware to avoid spaces in the input
  }

  // >>>> TASK 3 ADVANCED LEVEL <<<<
  double total = correctAnswers + wrongAnswers;
// calculate the accurate of correct answers
  double accurate;
  if (total > 0) {
    accurate = (correctAnswers / total) * 100;
  } else {
    accurate = 0;
  }

  print("It was a great game Here are your statistics ");
  print(" Correct: $correctAnswers");
  print(" Wrong: $wrongAnswers");
  print(" Your Score = ${accurate.toStringAsFixed(0)}%");
 // accurate output = 100 , 50 , 70 ... etc
  if (accurate >= 50) {
    print(" Congratulations You passed");
  } else {
    print(" Work harder next time");
  }

}
