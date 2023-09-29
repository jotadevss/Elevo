class EmailValidator {
  static String? validate(String? text) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (text == null || text.isEmpty) {
      return "Please enter an email address.";
    }

    if (!regex.hasMatch(text)) {
      return "The entered email address is not valid.";
    }

    return null;
  }
}
