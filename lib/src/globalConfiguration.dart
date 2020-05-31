import 'annotations.dart';
import 'converter.dart';
import 'namingConventions.dart';
import 'options.dart';

/// Global configuration for the mapper
class GlobalMapperConfiguration {
  static var defaultEntity = Entity();
  static var defaultProperty =
      Property(exclude: false, converter: NoConverter());

  /// Default [MappingOption] for specific groups
  static final defaultMappingOptions = <String, SpecificMappingOption>{
    'default': SpecificMappingOption(
        namingConvention: NamingConvention.noChange,
        allowedTypes: {null, bool, int, double, String},
        groups: ['default']),
  };
  
  static SpecificMappingOption get defaultMappingOption {
    return defaultMappingOptions['default'];
  }

  /// Default [UnmappingOption] for specific groups
  static final defaultUnmappingOptions = <String, SpecificUnmappingOption>{
    'default': SpecificUnmappingOption(
        ignoreUnknown: true,
        namingConvention: NamingConvention.noChange,
        groups: ['default']),
  };
}
