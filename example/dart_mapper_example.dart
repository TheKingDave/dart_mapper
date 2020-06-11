import 'package:dart_mapper/dart_mapper.dart';

import 'utils.dart';

class ObjectIdConverter implements Converter<ObjectId> {
  @override
  dynamic mapValue(ObjectId input, [config]) {
    return input.id;
  }

  @override
  ObjectId unmapValue(input, [config]) {
    if(!(input is String)) throw ArgumentError('Input musst be string.');
    return ObjectId(input);
  }
  
}

void main() {
  // Make Mapper instance
  final mapper = Mapper();
  mapper.addTypedConverter<ObjectId>(ObjectIdConverter());
  
  final id = ObjectId('507f1f77bcf86cd799439011');
  
  final testAddress = Address(
    street: 'The Other Street',
    city: 'Porters Lake',
    country: 'Canada',
  );
  
  final testPerson = Person(
    id: id,
    name: 'Julia',
    lastName: 'Last',
    address: testAddress,
    password: 'someBigSecret'
  );

  // Specify some Mapping Options
  final optionList = <SpecificMappingOption>[
    null,
    SpecificMappingOption(namingConvention: NamingConvention.snakeCase),
    SpecificMappingOption(groups: ['api']),
    SpecificMappingOption(groups: ['api', 'api_x']),
    SpecificMappingOption(groups: ['api_x']),
    SpecificMappingOption(allowedTypes: {ObjectId}),
  ];

  // For every mapping option run toMap
  // TODO: Add outputs
  for (var options in optionList) {
    final map = mapper.toMap(testPerson, options);
    print('${options?.groups}: ${mapToString(map)}');
    // TODO: implement fromMap
    //print(mapper.fromMap<TestJson>(map, list));
  }
}

// Example database class
class ObjectId {
  final String id;

  ObjectId(this.id);

  @override
  String toString() {
    return 'ObjectId($id)';
  }
}

@entity
class Address {
  @property
  String street;

  @property
  String city;

  @property
  String country;

  Address({this.street, this.city, this.country});
}

@Entity()
class Person {
  @Property()
  @Property(group: 'api', name: '_id')
  final ObjectId id;

  @Property(name: 'firstName')
  final String name;

  @Property()
  final String lastName;

  @Property(exclude: true)
  @Property(group: 'api', exclude: false)
  final String password;

  @Property()
  final Address address;

  Person({this.id, this.name, this.lastName, this.password, this.address});
}
