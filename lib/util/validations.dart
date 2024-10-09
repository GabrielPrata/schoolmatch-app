import 'package:image_picker/image_picker.dart';

class Validations {
  static String? verifyEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Ops! Acho que você esqueceu do seu e-mail!';
    }

    if (email.length > 120) {
      return 'Que e-mail gigante é esse? Coloque um e-mail de até 120 caracteres.';
    }

    // Regex para validação de e-mail
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@alunos\.fho\.edu\.br$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Use seu e-mail da FHO.';
    }

    return null; // Retorna null se o e-mail for válido
  }

  static String? verifyPassword(String? password, String? confirmPassword) {
    if (password == null || password.isEmpty) {
      return 'Inventa uma senha aí...';
    }

    if (password.length < 8 || password.length > 30) {
      return 'A senha deve ter entre 8 e 30 caracteres';
    }

    // Regex para verificar a presença de ao menos uma letra
    final letterRegex = RegExp(r'[a-zA-Z]');
    // Regex para verificar a presença de ao menos um número
    final numberRegex = RegExp(r'[0-9]');
    // Regex para verificar a presença de ao menos um caractere especial
    final specialCharRegex = RegExp(r'[!@#\$&*~]');

    if (!letterRegex.hasMatch(password) ||
        !numberRegex.hasMatch(password) ||
        !specialCharRegex.hasMatch(password)) {
      return 'A gente sabe que é um **, mas é pro seu bem. Sua senha deve conter ao menos um número, uma letra e um caracter especial';
    }

    if (confirmPassword != password) {
      return 'Confere as senhas aí!';
    }

    return null; // Retorna null se a senha for válida
  }

  static String? validateString(String? value,
      {int? minLength,
      int? maxLength,
      String? pattern,
      String fieldName = 'O campo'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName não pode ser vazio';
    }

    if (minLength != null && value.length < minLength) {
      return '$fieldName deve ter pelo menos $minLength caracteres';
    }

    if (maxLength != null && value.length > maxLength) {
      return '$fieldName deve ter no máximo $maxLength caracteres';
    }

    if (pattern != null) {
      final regex = RegExp(pattern);
      if (!regex.hasMatch(value)) {
        return '$fieldName contém caracteres inválidos';
      }
    }

    return null;
  }

  static String? validateList(List<dynamic> list,
      {int? minLength, int? maxLength, String fieldName = 'O campo'}) {
    if (list.length < minLength!) {
      return 'Marque pelo menos $minLength opções!';
    }

    if (list.length > maxLength!) {
      return 'Marque até $maxLength opções!';
    }

    return null;
  }

  static String? validateImages(List<XFile> images) {
    if (images.length < 2!) {
      return 'Pelo menos duas fotos!';
    }

    if (images.length > 6!) {
      return 'Envie até 6 fotos!';
    }

    return null;
  }

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text; // Retorna a string original se estiver vazia
    return text[0].toUpperCase() + text.substring(1);
  }
}
