import 'package:flutter/material.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/view/new_ui/popups/my_address_popup.dart';

class TitleAddressSelect extends StatelessWidget {
  final AddressState addressState;

  const TitleAddressSelect({super.key, required this.addressState});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => MyAddressesPopup(addressState: addressState),
            ),
            child: Text(
              '${addressState.currentAddress?.street} ${addressState.currentAddress?.building}',
              overflow: TextOverflow.fade,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.Graphite,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
