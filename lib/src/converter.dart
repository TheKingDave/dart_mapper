abstract class Converter<T> {
  dynamic mapValue(T input, [Map<String, dynamic> config]);

  T unmapValue(dynamic inout, [Map<String, dynamic> config]);
}

class NoConverter implements Converter<dynamic> {
  const NoConverter();

  @override
  dynamic mapValue(input, [config]) {
    return input;
  }

  @override
  dynamic unmapValue(input, [config]) {
    return input;
  }
}

class GeneralConverter<T> implements Converter<T> {
  final dynamic Function(T, [Map<String, dynamic>]) map;
  final T Function(dynamic, [Map<String, dynamic>]) unmap;
  final Map<String, dynamic> config;

  const GeneralConverter(
      {this.map,
      this.unmap,
      this.config,
      List<Type> mappedTypes,
      List<Type> unmappedTypes});

  @override
  dynamic mapValue(input, [config]) {
    return map(input, {...this.config, ...config});
  }

  @override
  T unmapValue(input, [config]) {
    return unmap(input, {...this.config, ...config});
  }
}
