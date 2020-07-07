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
  final regex = RegExp("[0-9]{11}");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite apenas números sem pontuações!';
}

String rgValidator(String value, String field) {
  final regex = RegExp("[0-9]{2}\.?[0-9]{3}\.?[0-9]{3}\-?[0-9]{1}");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite um RG válido!';
}

String nascimentoValidator(String value, String field) {
  final regex = RegExp("^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.]((19|20)\\d\\d)");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite uma data válida!';
}

String cepValidator(String value, String field) {
  final regex = RegExp("^[0-9]{5}(?:-[0-9]{3})?");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite um CEP válido!';
}

String numeroCartaoValidator(String value, String field) {
  final regex = RegExp("[0-9]{2}(?:[\.])?[0-9]{2}(?:[\.])?[0-9]{8}(?:[\.])?[0-9]{1}");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite um número válido!';
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

String maxLegthTelefoneValidator(String value, String field) {
  if (value.length > 11) {
    return 'Máximo de 11 dígitos para $field!';
  }
  return null;
}

String maxLegthCEPValidator(String value, String field) {
  if (value.length > 8) {
    return 'Máximo de 8 dígitos para $field!';
  }
  return null;
}

String maxLegthCPFValidator(String value, String field) {
  if (value.length > 11) {
    return 'Máximo de 11 dígitos para $field!';
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
