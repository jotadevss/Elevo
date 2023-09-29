class UsernameValidator {
  static String? validate(String? text) {
    if (text == null || text.isEmpty) {
      return "Please provide a valid username";
    }

    return null;
  }
}
