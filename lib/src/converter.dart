abstract class Converter {
  dynamic mapValue(dynamic input, Map<String, dynamic> config);

  dynamic unmapValue(dynamic inout, Map<String, dynamic> config);
}

abstract class TypedConverter implements Converter {
  final List<Type> mappedTypes;
  final List<Type> unmappedTypes;

  const TypedConverter({this.mappedTypes, this.unmappedTypes});
}

class NoConverter extends TypedConverter {
  const NoConverter();

  @override
  dynamic mapValue(input, Map<String, dynamic> config) {
    return input;
  }

  @override
  dynamic unmapValue(input, Map<String, dynamic> config) {
    return input;
  }
}

class GeneralConverter extends TypedConverter {
  final dynamic Function(dynamic, Map<String, dynamic>) map;
  final dynamic Function(dynamic, Map<String, dynamic>) unmap;
  final Map<String, dynamic> config;

  const GeneralConverter(
      {this.map,
      this.unmap,
      this.config,
      List<Type> mappedTypes,
      List<Type> unmappedTypes})
      : super(mappedTypes: mappedTypes, unmappedTypes: unmappedTypes);

  @override
  dynamic mapValue(input, config) {
    return map(input, {...this.config, ...config});
  }

  @override
  dynamic unmapValue(input, config) {
    return unmap(input, {...this.config, ...config});
  }
}
