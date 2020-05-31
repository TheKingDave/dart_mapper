import 'dart:convert';

import 'package:dart_mapper/dart_mapper.dart';
import 'package:intl/intl.dart';

import 'utils.dart';

final moneyFormat = NumberFormat.currency(locale: 'de_AT', symbol: '€');

class MoneyConverter extends Converter {
  const MoneyConverter()
      : super(mappedTypes: const [double], unmappedTypes: const [String]);

  @override
  dynamic mapValue(dynamic input, Map<String, dynamic> config) {
    return moneyFormat.format(input);
  }

  @override
  dynamic unmapValue(dynamic input, Map<String, dynamic> config) {
    return moneyFormat.parse(input);
  }
}

void main() {
  final mapper = Mapper();

  final test = TestClass(
      stringField: 'Testing',
      excludedField: 'should not be displayed',
      intField: 23,
      doubleField: 22.238,
      apiField: 'only in api');

  final optionList = <SpecificMappingOption>[
    null,
    SpecificMappingOption(namingConvention: NamingConvention.snakeCase),
    SpecificMappingOption(groups: ['api']),
    SpecificMappingOption(groups: ['api', 'api_x']),
    SpecificMappingOption(groups: ['api_x']),
  ];

  for (var options in optionList) {
    final map = mapper.toMap(test, options);
    print('${options?.groups}: ${mapToString(map)}');
    // TODO: implement fromMap
    //print(mapper.fromMap<TestJson>(map, list));
  }
}

@Entity()
class TestClass {
  @Property(name: 'someName')
  String stringField;

  @Property(exclude: true)
  String excludedField;

  @Property()
  int intField;

  @Property(converter: MoneyConverter())
  @Property(group: 'api', name: 'double', converter: NoConverter())
  @Property(group: 'api_x', converter: MoneyConverter())
  double doubleField;

  @Property(exclude: true)
  @Property(group: 'api', exclude: false)
  @Property(group: 'api_x', name: 'apiXField')
  String apiField;

  @override
  String toString() {
    return 'TestJson{stringField: $stringField, excludedField: $excludedField, '
        'intField: $intField, doubleField: $doubleField, apiField: $apiField}';
  }

  TestClass(
      {this.stringField,
      this.excludedField,
      this.intField,
      this.doubleField,
      this.apiField});
}
