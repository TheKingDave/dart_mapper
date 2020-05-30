import 'interfaces.dart';
import 'namingConventions.dart';

const entity = Entity();

class Entity implements IWithGroup {
  final bool ignoreUnknowns;
  final NamingConvention namingConvention;
  @override
  final String group;

  const Entity({this.ignoreUnknowns, this.namingConvention, this.group});

  Entity copyWith(Entity other) {
    if(other == null) return this;
    return Entity(
      ignoreUnknowns: other.ignoreUnknowns ?? ignoreUnknowns,
      namingConvention: other.namingConvention ?? namingConvention,
    );
  }
}

class Property implements IWithGroup {
  final String name;
  final bool exclude;
  final String serializer;
  @override
  final String group;

  const Property(
      {this.name,
        this.exclude,
        this.serializer,
        this.group});

  Property copyWith(Property other) {
    if (other == null) return this;
    return Property(
      name: other.name ?? name,
      serializer: other.serializer ?? serializer,
      exclude: other.exclude ?? exclude,
    );
  }
}