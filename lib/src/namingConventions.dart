import 'extensions/string.dart';

abstract class NamingConvention {
  static const NamingConvention noChange = NoChangeNamingConvention();
  static const NamingConvention camelCase = CamelCaseNamingConvention();
  static const NamingConvention snakeCase = SnakeCaseNamingConvention();
  static const NamingConvention kebabCase = KebabCaseNamingConvention();
  static const NamingConvention pascalCase = PascalCaseNamingConvention();
  static const NamingConvention upperSnakeCase = SnakeCaseNamingConvention(upperCase: true);

  const NamingConvention();

  String toConvention(String original);
}

class GeneralNamingConvention extends NamingConvention {
  final String Function(String original) convention;

  const GeneralNamingConvention(this.convention);

  @override
  String toConvention(String original) {
    return convention(original);
  }
}

class NoChangeNamingConvention extends NamingConvention {
  const NoChangeNamingConvention();

  @override
  String toConvention(String original) {
    return original;
  }
}

abstract class SplitNamingConvention extends NamingConvention {
  const SplitNamingConvention();

  static RegExp wordSplitter = RegExp('((?<=[a-z])[A-Z]|[A-Z](?=[a-z]))');
  static RegExp charSplitter = RegExp('[ _-]');

  List<String> splitString(String original) {
    return original
        .replaceAllMapped(wordSplitter, (match) => ' ${match.group(0)}')
        .toLowerCase()
        .split(charSplitter);
  }

  String listConvention(List<String> strings);

  @override
  String toConvention(String original) {
    return listConvention(splitString(original));
  }
}

class CamelCaseNamingConvention extends SplitNamingConvention {
  const CamelCaseNamingConvention();

  @override
  String listConvention(List<String> strings) {
    for (var i = 1; i < strings.length; i++) {
      strings[i] = strings[i].capitalize();
    }

    return strings.join();
  }
}

class SnakeCaseNamingConvention extends SplitNamingConvention {
  final bool upperCase;
  
  const SnakeCaseNamingConvention({this.upperCase = false});

  @override
  String listConvention(List<String> strings) {
    if(upperCase) {
      return strings.map((e) => e.toUpperCase()).join('_');
    }
    return strings.join('_');
  }
}

class KebabCaseNamingConvention extends SplitNamingConvention {
  const KebabCaseNamingConvention();

  @override
  String listConvention(List<String> strings) {
    return strings.join('-');
  }
}

class PascalCaseNamingConvention extends SplitNamingConvention {
  const PascalCaseNamingConvention();

  @override
  String listConvention(List<String> strings) {
    return strings.map((e) => e.capitalize()).join();
  }
}