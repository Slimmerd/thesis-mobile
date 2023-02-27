import 'package:flutter/material.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/view/new_ui/screens/edit_address_screen.dart';
import 'package:thesis_mobile/view/new_ui/widgets/address/address_checkbox.dart';

class AddressSelector extends StatelessWidget {
  final Address address;
  final int currentID;
  final int addressesLength;
  final Function(Address newAddress)? setNew;
  final Function(Address address)? remove;

  const AddressSelector({
    Key? key,
    required this.address,
    required this.currentID,
    required this.setNew,
    required this.remove,
    required this.addressesLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(address.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: AppColors.lightRed,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10.0),
        child: const Icon(Icons.delete_forever, color: AppColors.cloud),
      ),
      confirmDismiss: (DismissDirection dir) async {
        if (addressesLength > 1 && address.id != currentID) {
          remove?.call(address);
        } else {
          return false;
        }
      },
      child: Material(
        child: InkWell(
          onTap: () {
            setNew?.call(address);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddressCheckBox(
                      isChecked: address.id == currentID,
                      onChange: (bool isChecked) {
                        if (isChecked) {
                          setNew?.call(address);
                        }
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${address.street} ${address.building}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    customPagePush(
                        context, EditAddressScreen(address: address));
                  },
                  child: const Icon(Icons.settings),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
