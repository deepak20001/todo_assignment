class CommonFormValidation {
  ///:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  /// email validator
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  ///:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  /// name validator
  static String? nameValidator(String? value, String? title) {
    if (value == null || value.isEmpty) {
      return '$title is required';
    }
    return null;
  }

  ///:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  /// password validator
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Enter minimum 8 digit password';
    }
    return null;
  }
}
