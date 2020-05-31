import 'package:dart_mapper/dart_mapper.dart';
import 'package:dart_mapper/src/options.dart';

/// Global configuration for the mapper
class GlobalMapperConfiguration {
  /// Default [MappingOption] for specific groups
  static final defaultMappingOptions = <String, MappingOption>{
    'default': MappingOption(
        namingConvention: NamingConvention.noChange,
        allowedTypes: [null, bool, int, double, String]),
  };

  /// Default [UnmappingOption] for specific groups
  static final defaultUnmappingOptions = <String, UnmappingOption>{
    'default': UnmappingOption(
        ignoreUnknown: true, namingConvention: NamingConvention.noChange),
  };
}
