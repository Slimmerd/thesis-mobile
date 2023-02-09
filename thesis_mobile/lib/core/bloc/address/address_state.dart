part of 'address_bloc.dart';

class AddressState extends Equatable {
  final String key;
  final Address? currentAddress;
  final List<Address> addresses;

  AddressState({this.currentAddress, this.addresses = const [], this.key = ''});

  int indexWhere(Address address) {
    return addresses.indexWhere((element) => element.id == address.id);
  }

  bool has(Address address) {
    return indexWhere(address) != -1;
  }

  AddressState set(Address newAddress) {
    if (has(newAddress)) {
      int index = indexWhere(newAddress);
      return copyWith(
        currentAddress: addresses[index],
        addresses: [...addresses],
        key: Uuid().v1(),
      );
    } else {
      return copyWith(
        currentAddress: newAddress,
        addresses: [...addresses, newAddress],
        key: Uuid().v1(),
      );
    }
  }

  AddressState update(Address address) {
    if (has(address)) {
      int index = indexWhere(address);
      addresses[index] = address;
    }
    return copyWith(key: Uuid().v1());
  }

  AddressState remove(Address address) {
    if (has(address) &&
        addresses.length > 1 &&
        currentAddress!.id != address.id) {
      int index = indexWhere(address);
      addresses.removeAt(index);
    }

    return copyWith(key: Uuid().v1());
  }

  int get latestAddress {
    if (addresses.isNotEmpty) {
      return addresses.last.id;
    } else {
      return 0;
    }
  }

  AddressState copyWith(
      {Address? currentAddress, List<Address>? addresses, String? key}) {
    return AddressState(
        currentAddress: currentAddress ?? this.currentAddress,
        addresses: addresses ?? this.addresses,
        key: key ?? this.key);
  }

  @override
  List<Object?> get props => [currentAddress, addresses, key];
}
