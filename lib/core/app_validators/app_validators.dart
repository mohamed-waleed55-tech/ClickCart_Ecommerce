class AppValidators {
  AppValidators._();

  static final RegExp nameRegex = RegExp(r"^[a-zA-Z\u0600-\u06FF\s'-]{2,30}$");

  static final RegExp emailRegex = RegExp(
    r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  static final RegExp phoneRegex = RegExp(
    r'^\+?[0-9]{10,15}$',
  );

  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&.#_-]).{8,}$',
  );

  static String? firstName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) return 'Please enter your first name';
    if (!nameRegex.hasMatch(name)) return 'Please enter a valid first name';

    return null;
  }

  static String? lastName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) return 'Please enter your last name';
    if (!nameRegex.hasMatch(name)) return 'Please enter a valid last name';

    return null;
  }

  static String? email(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) return 'Please enter your email';
    if (!emailRegex.hasMatch(email)) return 'Please enter a valid email';

    return null;
  }

  static String? phoneNumber(String? value) {
    final phone = value?.trim() ?? '';

    if (phone.isEmpty) return 'Please enter your phone number';
    if (!phoneRegex.hasMatch(phone)) return 'Please enter a valid phone number';

    return null;
  }

  static String? password(String? value) {
    final password = value ?? '';

    if (password.isEmpty) return 'Please enter your password';
    if (!passwordRegex.hasMatch(password)) {
      return 'Password must be at least 8 characters with uppercase, lowercase, number, and symbol';
    }

    return null;
  }
  static String? loginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }
}