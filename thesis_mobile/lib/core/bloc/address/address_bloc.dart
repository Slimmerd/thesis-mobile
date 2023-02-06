import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/view/new_ui/screens/edit_address_screen.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressState()) {
    init();
    on<AddressSet>(_addressSetToState);
  }

  Future<void> init() async {
    await _restore();
  }

  Future<void> _save() async {
    final Box currentAddress = await Hive.openBox('CURRENT_ADDRESS');
    await currentAddress.put('address', state.currentAddress?.toJson());
  }

  Future<void> _restore() async {
    final Box currentAddress = await Hive.openBox('CURRENT_ADDRESS');

    if (currentAddress.containsKey('address')) {
      final address = currentAddress.get('address');

      emit(state.copyWith(
          currentAddress: Address.fromJson(address.cast<String, dynamic>())));
    }
  }

  void setAddress(Address newAddress) {
    add(AddressSet(newAddress));
  }

  void _addressSetToState(AddressSet event, Emitter<AddressState> emit) {
    emit(state.set(event.newAddress));
    _save();
  }
}
