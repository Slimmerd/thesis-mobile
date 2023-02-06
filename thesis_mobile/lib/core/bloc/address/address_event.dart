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
