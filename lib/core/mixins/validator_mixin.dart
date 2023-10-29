mixin ValidatorMixin {
  String? validateNotEmpty(String? value) =>
      value != null && value.isEmpty ? 'Field cannot be empty' : null;

  String? validateFullName(String? value) =>
      value != null && value.split(' ').length < 2
          ? 'Enter a valid Full Name'
          : null;

  String? validateEmail(String? value) {
    if (value == null) return 'Please enter an email address';

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return !emailValid ? 'Enter a Valid Email Address' : null;
  }

  String? validateNotNullEmail(String? value) {
    if (value == null) return 'Please enter an email address';

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return value.isEmpty
        ? null
        : !emailValid
            ? 'Enter a Valid Email Address'
            : null;
  }

  String? validatePhoneNumber(String? value) =>
      value != null && value.length < 10 ? 'Enter a Valid Phone Number' : null;

  String? validatePassword(String? value) {
    if (value != null && value.length < 5) {
      return 'Password must be a minimum of 5 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? password) =>
      value != null && value != password ? 'Passwords do not match' : null;

  String? validateOtp(String? value) =>
      value != null && value.length == 4 ? null : 'Invalid code';

  String? validateGender(String? value) => value != null && value == 'Gender'
      ? 'Choose one of male or female'
      : null;

  String? validateBvn(String? value) {
    if (value == null || value.length != 11) return 'Enter a Valid BVN';
    bool emailValid = RegExp(r"\b(?<!\.)\d+(?!\.)\b").hasMatch(value);
    return !emailValid ? 'Enter a Valid BVN' : null;
  }

  String? validateResetCode(String? value) {
    if (value == null || value.length != 6) {
      return 'Enter a valid code';
    }
    bool emailValid = RegExp(r"\b(?<!\.)\d+(?!\.)\b").hasMatch(value);
    return !emailValid ? 'Enter a calid code' : null;
  }
}
