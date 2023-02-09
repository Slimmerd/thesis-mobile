import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:uuid/uuid.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressState()) {
    init();
    on<AddressSet>(_addressSetToState);
    on<AddressRemove>(_addressRemoveToState);
    on<AddressUpdate>(_addressUpdateToState);
  }

  Future<void> init() async {
    await _restore();
  }

  Future<void> _save() async {
    final Box addressBox = await Hive.openBox('ADDRESS_STATE');
    await addressBox.put('address', state.currentAddress?.toJson());
    await addressBox.put(
        'addresses', state.addresses.map((item) => item.toJson()).toList());
  }

  Future<void> _restore() async {
    final Box addressBox = await Hive.openBox('ADDRESS_STATE');

    if (addressBox.containsKey('address') &&
        addressBox.containsKey('addresses')) {
      final address = addressBox.get('address');
      final addresses = addressBox.get('addresses');

      Map<String, dynamic> _parser(dynamic hiveMap) {
        final jsonString = jsonEncode(hiveMap);
        return jsonDecode(jsonString);
      }

      if (addresses is List) {
        final addressesList =
            addresses.map((item) => Address.fromJson(_parser(item))).toList();

        emit(state.copyWith(
            currentAddress: Address.fromJson(
              address.cast<String, dynamic>(),
            ),
            addresses: addressesList));
      } else {
        throw Error();
      }
    }
  }

  void setAddress(Address newAddress) {
    add(AddressSet(newAddress));
  }

  void removeAddress(Address address) {
    add(AddressRemove(address));
  }

  void updateAddress(Address address) {
    add(AddressUpdate(address));
  }

  void _addressSetToState(AddressSet event, Emitter<AddressState> emit) {
    emit(state.set(event.newAddress));
    _save();
  }

  void _addressRemoveToState(AddressRemove event, Emitter<AddressState> emit) {
    emit(state.remove(event.address));
    _save();
  }

  void _addressUpdateToState(AddressUpdate event, Emitter<AddressState> emit) {
    emit(state.update(event.address));
    _save();
  }
}
