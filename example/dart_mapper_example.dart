import 'dart:convert';

import 'package:dart_mapper/dart_mapper.dart';
import 'package:intl/intl.dart';

import 'utils.dart';

// Make money formatter from intl
final moneyFormat = NumberFormat.currency(locale: 'de_AT', symbol: '€');

// Define a converter for money fields
class MoneyConverter implements Converter {
  const MoneyConverter();

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
  // Make Mapper instance
  final mapper = Mapper();

  // Generate test instance of TestClass
  final test = TestClass(
      stringField: 'Testing',
      excludedField: 'should not be displayed',
      intField: 23,
      doubleField: 22.238,
      apiField: 'only in api');

  // Specify some Mapping Options
  final optionList = <SpecificMappingOption>[
    null,
    SpecificMappingOption(namingConvention: NamingConvention.snakeCase),
    SpecificMappingOption(groups: ['api']),
    SpecificMappingOption(groups: ['api', 'api_x']),
    SpecificMappingOption(groups: ['api_x']),
  ];

  // For every mapping option run toMap
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

  TestClass(
      {this.stringField,
      this.excludedField,
      this.intField,
      this.doubleField,
      this.apiField});

  @override
  String toString() {
    return 'TestJson{stringField: $stringField, excludedField: $excludedField, '
        'intField: $intField, doubleField: $doubleField, apiField: $apiField}';
  }
}
