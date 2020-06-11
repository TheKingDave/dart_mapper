import 'dart:mirrors';

import 'annotations.dart';
import 'exceptions.dart';
import 'globalConfiguration.dart';
import 'interfaces.dart';
import 'options.dart';

class Utils {
  static bool isEntityObject(dynamic obj) {
    final classMirror = reflectClass(obj.runtimeType);
    return classMirror.metadata.map((e) => e.reflectee).whereType<Entity>().isNotEmpty;
  }
  
  static Map<String, T> getMetadataMap<T extends IWithGroup>(
      DeclarationMirror mirror) {
    return Map.fromIterable(
        mirror.metadata.map((e) => e.reflectee).whereType<T>(),
        key: (e) => e.group);
  }

  static Entity getEntity(Type type, SpecificMappingOption mappingOption) {
    final classMirror = reflectClass(type);
    final convertMap = Utils.getMetadataMap<Entity>(classMirror);

    // If no [Entity] annotation found, throw error
    // TODO: return null or keep throwing error?
    if (convertMap.isEmpty) throw NotConvertObject(type);

    var entity = GlobalMapperConfiguration.defaultEntity;
    for (var group in mappingOption.groups) {
      entity = entity?.copyWith(convertMap[group]) ?? convertMap[group];
    }
    return entity;
  }

  static Property getProperty(
      DeclarationMirror dm, SpecificMappingOption mappingOption) {
    final propertyMap = Utils.getMetadataMap<Property>(dm);

    // If no [Property] annotation found, return null
    if (propertyMap.isEmpty) return null;

    var convertField = GlobalMapperConfiguration.defaultProperty;

    for (var group in mappingOption.groups) {
      convertField =
          convertField?.copyWith(propertyMap[group]) ?? propertyMap[group];
    }
    return convertField;
  }
}
