import 'dart:mirrors';

import 'globalConfiguration.dart';
import 'options.dart';
import 'utils.dart';

import 'converter.dart';
import 'tuple.dart';

class Mapper {
  static final typeConverters = <Tuple<Type, Type>, TypedConverter>{};

  TypedConverter getTypeConverter(Type t1, Type t2) {
    return typeConverters[Tuple(t1, t2)];
  }

  Map<String, dynamic> toMap(dynamic object,
      [SpecificMappingOption mappingOption]) {
    mappingOption =
        GlobalMapperConfiguration.defaultMappingOption.copyWith(mappingOption);
    final entity = Utils.getEntity(object.runtimeType, mappingOption);
    mappingOption = mappingOption.copyWith(entity);

    // Return map
    final ret = <String, dynamic>{};

    final decl = reflectClass(object.runtimeType).declarations;
    decl.forEach((k, v) {
      final property = Utils.getProperty(v, mappingOption);

      // Ignore if there is no [Property] annotation or it is excluded
      if (property == null || property.exclude) return;

      // Get name and give it to the [NamingConvention]
      final name = mappingOption.namingConvention
          .toConvention(property.name ?? MirrorSystem.getName(k));

      // Get value and give it to the [Converter]
      final value = property.converter
          .mapValue(reflect(object).getField(k).reflectee, {});

      ret[name] = value;
    });

    return ret;
  }
}
