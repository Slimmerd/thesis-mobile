import 'package:flutter/material.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/view/new_ui/screens/edit_address_screen.dart';
import 'package:thesis_mobile/view/new_ui/widgets/address/address_checkbox.dart';

class AddressSelector extends StatelessWidget {
  final Address address;
  final Address current;
  final List<Address> addressData;
  final Function(Address newAddress)? setNew;
  final bool resultDelete = false;

  const AddressSelector({
    Key? key,
    required this.address,
    required this.current,
    required this.setNew,
    required this.addressData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(address.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: AppColors.LightRed,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10.0),
        child: Icon(Icons.delete_forever, color: AppColors.Cloud),
      ),
      confirmDismiss: (DismissDirection _dir) async {
        // if (addressData.length > 1) {
        //   runDeleteAddressMutation({'id': address.id});
        // } else
        //   return false;

        // if (resultDelete!.hasException) {
        //   return false;
        // } else {
        //   return true;
        // }
        return false;
      },
      child: Material(
        child: InkWell(
          onTap: () {
            if (resultDelete) {
              return;
            }
            setNew?.call(address);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            child: resultDelete
                ? CircularProgressIndicator(color: AppColors.MintGreen)
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddressCheckBox(
                            isChecked: address.building == current.building,
                            onChange: (bool isChecked) {
                              if (isChecked) {
                                setNew?.call(address);
                              }
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'улица ${address.street} ${address.building}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          customPagePush(
                                  context, EditAddressScreen(address: address))
                              .then((value) => {});
                        },
                        child: Icon(Icons.settings),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
