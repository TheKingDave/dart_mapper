import 'converter.dart';
import 'options.dart';
import 'interfaces.dart';
import 'namingConventions.dart';

const entity = Entity();

/// Annotation to mark a class as an Entity
class Entity implements IWithGroup, MappingOption, UnmappingOption {
  @override
  final bool ignoreUnknown;
  @override
  final NamingConvention namingConvention;
  @override
  final Set<Type> allowedTypes;
  @override
  final String group;

  const Entity(
      {this.ignoreUnknown,
      this.namingConvention,
      this.group = 'default',
      this.allowedTypes = const {}});

  Entity copyWith(Entity other) {
    if (other == null) return this;
    return Entity(
      ignoreUnknown: other.ignoreUnknown ?? ignoreUnknown,
      namingConvention: other.namingConvention ?? namingConvention,
      allowedTypes: allowedTypes.union(other.allowedTypes),
    );
  }
}

const property = Property();

class Property implements IWithGroup {
  final String name;
  final bool exclude;
  final Converter converter;
  final Type mapTo;
  @override
  final String group;

  const Property(
      {this.name,
      this.exclude,
      this.converter,
      this.group = 'default',
      this.mapTo});

  Property copyWith(Property other) {
    if (other == null) return this;
    return Property(
      name: other.name ?? name,
      converter: other.converter ?? converter,
      exclude: other.exclude ?? exclude,
      mapTo: other.mapTo ?? mapTo,
    );
  }
}
