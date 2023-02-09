part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AddressSet extends AddressEvent {
  final Address newAddress;

  const AddressSet(this.newAddress);

  @override
  List<Object> get props => [newAddress];

  @override
  String toString() => 'AddressSet { address: $newAddress }';
}

class AddressRemove extends AddressEvent {
  final Address address;

  const AddressRemove(this.address);

  @override
  List<Object> get props => [address];

  @override
  String toString() => 'AddressRemove { address: $address }';
}

class AddressUpdate extends AddressEvent {
  final Address address;

  const AddressUpdate(this.address);

  @override
  List<Object> get props => [address];

  @override
  String toString() => 'AddressUpdate { address: $address }';
}
