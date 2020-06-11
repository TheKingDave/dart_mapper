import 'dart:mirrors';

import 'globalConfiguration.dart';
import 'options.dart';
import 'utils.dart';

import 'converter.dart';

class Mapper {
  static final typeConverters = <Type, Converter>{};
  
  void addTypedConverter<T>(Converter<T> converter) {
    if(typeConverters.containsKey(T)) {
      throw ArgumentError('This typedConverter is already set: $T');
    }
    typeConverters[T] = converter;
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
      var value = property.converter
          .mapValue(reflect(object).getField(k).reflectee, {});
      
      if(!mappingOption.allowedTypes.contains(value.runtimeType)) {
        if(Utils.isEntityObject(value)) {
          value = toMap(value, mappingOption);
        } else if(typeConverters.containsKey(value.runtimeType)){
          value = typeConverters[value.runtimeType].mapValue(value);
        }
      }

      ret[name] = value;
    });

    return ret;
  }
}
