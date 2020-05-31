import 'package:dart_mapper/dart_mapper.dart';

class MappingOption {
  final List<Type> allowedTypes;
  final NamingConvention namingConvention;

  const MappingOption({this.allowedTypes, this.namingConvention});
}

class UnmappingOption {
  final bool ignoreUnknown;
  final NamingConvention namingConvention;

  const UnmappingOption({this.ignoreUnknown, this.namingConvention});
}
