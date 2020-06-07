String emailValidator(String value, String field) {
  final regex = RegExp(
    //r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
      "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
          "\\@" +
          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
          "(" +
          "\\." +
          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
          ")+");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Email inválido!';
}

String stringValidator(String value, String field) {
  final regex = RegExp(r'^\D+$');
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite apenas letras!';
}

String numberValidator(String value, String field) {
  final regex = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite apenas números!';
}

String cpfValidator(String value, String field) {
  final regex = RegExp("[0-9]{3}\.?[0-9]{3}\.?[0-9]{3}\-?[0-9]{2}");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite um CPF válido!';
}

String rgValidator(String value, String field) {
  final regex = RegExp("[0-9]{2}\.?[0-9]{3}\.?[0-9]{3}\-?[0-9]{1}");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite um RG válido!';
}

String cepValidator(String value, String field) {
  final regex = RegExp("^\\d{5}[-]\\d{3}");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite um CEP válido!';
}

String requiredValidator(String value, String field) {
  if (value.isEmpty) {
    return 'Insira $field!';
  }
  return null;
}

String enderecoValidator(String value, String field) {
  final regex = RegExp("([\w\W]+)\s(\d+)");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite um endereço válido!';
}

String minLegthValidator(String value, String field) {
  if (value.length < 6) {
    return 'Mínimo de 6 caracteres para $field!';
  }
  return null;
}

Function(String) composeValidators(String field, List<Function> validators) {
  return (value) {
    if (validators != null && validators is List && validators.length > 0) {
      for (var validator in validators) {
        final errMessage = validator(value, field) as String;
        if (errMessage != null) {
          return errMessage;
        }
      }
    }
    return null;
  };
}
