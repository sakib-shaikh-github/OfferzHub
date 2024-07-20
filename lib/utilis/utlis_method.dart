import 'dart:math';

final random = Random();

//For the guest user to generate an id;
String generateRandomUserId() {
  Random random = Random();
  int randomNumber = random.nextInt(2000);
  return randomNumber.toString();
}

int getRandomAround() {
  return random.nextInt(5);
}
