import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/value_object.dart';

class TextVO extends ValueObject<String> {
  TextVO(super.value) {
    _validate();
  }

  void _validate() {
    if (value.isEmpty) {
      errorMessage = translation.messages.errorCampoObrigatorio;
    }
  }

  String replaceSpecialCharacters(String text) {
    final Map<String, String> replacements = {
      'ç': 'c',
      'Ç': 'C',
      'á': 'a',
      'Á': 'A',
      'é': 'e',
      'É': 'E',
      'í': 'i',
      'Í': 'I',
      'ó': 'o',
      'Ó': 'O',
      'ú': 'u',
      'Ú': 'U',
      'ã': 'a',
      'Ã': 'A',
      'õ': 'o',
      'Õ': 'O',
      'â': 'a',
      'Â': 'A',
      'ê': 'e',
      'Ê': 'E',
      'î': 'i',
      'Î': 'I',
      'ô': 'o',
      'Ô': 'O',
      'û': 'u',
      'Û': 'U',
      'à': 'a',
      'À': 'A',
      'è': 'e',
      'È': 'E',
      'ì': 'i',
      'Ì': 'I',
      'ò': 'o',
      'Ò': 'O',
      'ù': 'u',
      'Ù': 'U',
      'ä': 'a',
      'Ä': 'A',
      'ë': 'e',
      'Ë': 'E',
      'ï': 'i',
      'Ï': 'I',
      'ö': 'o',
      'Ö': 'O',
      'ü': 'u',
      'Ü': 'U',
      'ý': 'y',
      'Ý': 'Y',
      'ÿ': 'y',
      'Ÿ': 'Y',
    };

    return text.replaceAllMapped(RegExp('[^\x00-\x7F]'), (match) {
      String replacement = replacements[match.group(0)] ?? '';
      return replacement;
    });
  }
}
