abstract class Converter {
  final List<Type> mappedTypes;
  final List<Type> unmappedTypes;

  Converter(this.mappedTypes, this.unmappedTypes);

  dynamic mapValue(dynamic input, Map<String, dynamic> config);

  dynamic unmapValue(dynamic inout, Map<String, dynamic> config);
}

class GeneralConverter extends Converter {
  final dynamic Function(dynamic, Map<String, dynamic>) map;
  final dynamic Function(dynamic, Map<String, dynamic>) unmap;
  final Map<String, dynamic> config;

  GeneralConverter(
      {this.map,
      this.unmap,
      this.config,
      List<Type> mappedTypes,
      List<Type> unmappedTypes})
      : super(mappedTypes, unmappedTypes);

  @override
  dynamic mapValue(input, config) {
    return map(input, {...this.config, ...config});
  }

  @override
  dynamic unmapValue(input, config) {
    return unmap(input, {...this.config, ...config});
  }
}
