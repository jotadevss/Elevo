class PasswordValidate {
  static String? validate(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter an password.";
    }

    if (text.length < 6) {
      return "The password must contain at least 6 characters.";
    }

    return null;
  }
}
