String minLengthPwdValidator(String value, String field) {
  if (value.length < 8) {
    return 'Mínimo de 8 caracteres para $field!';
  }
  return null;
}

String nomeLengthValidator(String value, String field) {
  if (value.length < 3) {
    return 'Digite o $field!';
  }
  return null;
}

String horaLengthValidator(String value, String field) {
  if (value.length == 4) {
    return 'Mínimo de 4 caracteres para $field!';
  }
  return null;
}

String maxLengthNumero6Validator(String value, String field) {
  if (value.length > 6) {
    return 'Máximo de 6 dígitos para $field!';
  }
  return null;
}

//value.length < 2 ? 'Name must be greater than two characters' : null

String maxLengthTelefoneValidator(String value, String field) {
  if (value.length > 11) {
    return 'Máximo de 11 dígitos para $field!';
  }
  return null;
}

String maxLengthCEPValidator(String value, String field) {
  if (value.length > 8) {
    return 'Máximo de 8 dígitos para $field!';
  }
  return null;
}

String maxLengthCPFValidator(String value, String field) {
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

Function(String) notRequiredValidators(
    String field, List<Function> validators) {
  return (value) {
    if (validators != null && validators is List && validators.length > 0) {
      // for (var validator in validators) {
      //   final errMessage = validator(value, field) as String;
      //   if (errMessage != null) {
      //     return errMessage;
      //   }
      // }
    }
    return null;
  };
}

String placaValidator(String value, String field) {
  final regex = RegExp("^[a-zA-Z0-9]+");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite uma placa válida!';
}

String dataValidator(String value, String field) {
  final regex = RegExp(
      "^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.]((19|20)\\d\\d)");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite uma data válida!';
}

String horaValidator(String value, String field) {
  final regex = RegExp("^[0-2][0-3]:[0-5][0-9]");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite uma hora válida!';
}

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
  final regex = RegExp(r'^[0-9]{6}$');
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite 6 números!';
}

String onlyNumberValidator(String value, String field) {
  final regex = RegExp(r'^[0-9]*$');
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite apenas números!';
}

String numberPswValidator(String value, String field) {
  final regex = RegExp(r'^[0-9]{8}$');
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite 8 números!';
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
  final regex = RegExp(
      "^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.]((19|20)\\d\\d)");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite uma data válida!';
}

String cepValidator(String value, String field) {
  final regex = RegExp("^[0-9]{5}(?:-[0-9]{3})?");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Digite um CEP válido!';
}

String numeroCartaoValidator(String value, String field) {
  final regex =
      RegExp("[0-9]{2}(?:[\.])?[0-9]{2}(?:[\.])?[0-9]{8}(?:[\.])?[0-9]{1}");
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

String minLengthValidator(String value, String field) {
  if (value.length < 6) {
    return 'Mínimo de 6 caracteres para $field!';
  }
  return null;
}
