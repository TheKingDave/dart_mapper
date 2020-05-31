import 'namingConventions.dart';

abstract class SpecificOption {
  final List<String> groups = [];
}

abstract class MappingOption {
  final Set<Type> allowedTypes;
  final NamingConvention namingConvention;

  MappingOption({this.allowedTypes, this.namingConvention});
}

class SpecificMappingOption implements SpecificOption, MappingOption {
  @override
  final Set<Type> allowedTypes;
  @override
  final NamingConvention namingConvention;
  @override
  final List<String> groups;

  const SpecificMappingOption(
      {this.allowedTypes, this.namingConvention, this.groups});

  SpecificMappingOption copyWith(dynamic other) {
    if (other == null) return this;
    if (!(other is SpecificMappingOption || other is MappingOption)) {
      throw ArgumentError(
          'other must be of type [SpecificMappingOption] or [MappingOption]');
    }
    return SpecificMappingOption(
      allowedTypes: other.allowedTypes?.union(allowedTypes) ?? allowedTypes,
      namingConvention: other.namingConvention ?? namingConvention,
      groups:
          other is SpecificMappingOption ? other.groups == null ? groups : [...groups, ...other.groups] : groups,
    );
  }
}

abstract class UnmappingOption {
  final bool ignoreUnknown;
  final NamingConvention namingConvention;

  const UnmappingOption({this.ignoreUnknown, this.namingConvention});
}

class SpecificUnmappingOption implements UnmappingOption, SpecificOption {
  @override
  final bool ignoreUnknown;
  @override
  final NamingConvention namingConvention;
  @override
  final List<String> groups;

  SpecificUnmappingOption(
      {this.ignoreUnknown, this.namingConvention, this.groups});

  SpecificUnmappingOption copyWith(dynamic other) {
    if (other == null) return this;
    if (!(other is SpecificUnmappingOption || other is UnmappingOption)) {
      throw ArgumentError(
          'other must be of type [SpecificUnmappingOption] or [UnmappingOption]');
    }
    return SpecificUnmappingOption(
      ignoreUnknown: other.ignoreUnknown ?? ignoreUnknown,
      namingConvention: other.namingConvention ?? namingConvention,
      groups:
          other is SpecificMappingOption ? (other.groups ?? groups) : groups,
    );
  }
}
