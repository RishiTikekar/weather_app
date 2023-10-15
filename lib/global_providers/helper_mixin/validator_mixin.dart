mixin ValidatorsMixin {
  String? emptyFieldValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This Field cannot be empty';
    }
    return null;
  }

  String? lengthValidation(
    String? value, {
    required int minRequiredLength,
    int? maxAllowedLength,
  }) {
    if (value == null || value.isEmpty) return 'This Field cannot be empty';
    if (value.length < minRequiredLength) {
      return 'Please enter at least $minRequiredLength character';
    } else if (maxAllowedLength != null && value.length > maxAllowedLength) {
      return 'Cannot have more than $maxAllowedLength character';
    }
    return null;
  }
}
