import 'package:flutter/material.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/view/old_ui/screens/addresses_screen.dart';

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
            onTap: () => customPagePush(context, const AddressesScreen()),
            child: addressState.currentAddress == null
                ? const Text('Loading...')
                : Text(
                    '${addressState.currentAddress?.street} ${addressState.currentAddress?.building}',
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.graphite,
                      fontSize: 18,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
