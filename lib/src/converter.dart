abstract class Converter {
  final List<Type> mappedTypes;
  final List<Type> unmappedTypes;

  const Converter({this.mappedTypes, this.unmappedTypes});

  dynamic mapValue(dynamic input, Map<String, dynamic> config);

  dynamic unmapValue(dynamic inout, Map<String, dynamic> config);
}

class NoConverter extends Converter {
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

class GeneralConverter extends Converter {
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
