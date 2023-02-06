part of 'address_bloc.dart';

class AddressState extends Equatable {
  final Address? currentAddress;
  final List<Address> addresses;

  AddressState({this.currentAddress, this.addresses = const []});

  AddressState set(Address newAddress) {
    return copyWith(currentAddress: newAddress, addresses: addresses);
  }

  AddressState copyWith({Address? currentAddress, List<Address>? addresses}) {
    return AddressState(
        currentAddress: currentAddress ?? this.currentAddress,
        addresses: addresses ?? this.addresses);
  }

  @override
  List<Object?> get props => [currentAddress, addresses];
}
