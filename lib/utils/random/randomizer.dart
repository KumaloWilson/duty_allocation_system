import 'dart:math';

class RandomHelpers {

  static String generateRandomId() {
    // Get current timestamp
    final DateTime now = DateTime.now();

    // Extract date and time components
    final String timestamp = now.microsecondsSinceEpoch.toString();

    // Generate a random string of letters and numbers
    final String randomString = getRandomString(6);

    // Concatenate timestamp and random string to create the ID
    final String randomId = '$timestamp$randomString';

    return randomId;
  }

  static String getRandomString(int length) {
    final Random _random = Random.secure();
    const String _chars = 'abcdefghijklmnopqrstuvwxyz0123456789';

    return String.fromCharCodes(
        Iterable.generate(
          length, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length)),
        )
    );
  }

}