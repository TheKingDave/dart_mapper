A library to convert between maps and objects.

## Usage

A simple usage example:

```dart
import 'package:dart_mapper/dart_mapper.dart';

main() {
  final mapper = Mapper();
  print(mapper.toMap(TestClass("stringValue", 'otherValue')));
  // {stringField: stringValue, otherName: otherValue}
}

@Entity()
class TestClass {
  @Property()
  String stringField;

  @Property(name: 'otherName')
  String namedField;
  
  TestClass(this.stringField, this.namedField);
}
```

## License

The licence can be found [here](./LICENSE)

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/TheKingDave/dart_mapper/issues
