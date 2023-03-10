import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';

class AddressCheckBox extends StatefulWidget {
  final bool isChecked;
  final Function(bool isChecked)? onChange;

  const AddressCheckBox(
      {Key? key, required this.isChecked, required this.onChange})
      : super(key: key);

  @override
  State<AddressCheckBox> createState() => _AddressCheckBoxState();
}

class _AddressCheckBoxState extends State<AddressCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              widget.onChange?.call(!widget.isChecked);
            });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: widget.isChecked
                    ? AppColors.mintGreen
                    : AppColors.dorian),
            child: widget.isChecked
                ? const Icon(
                    Icons.check,
                    size: 20.0,
                    color: AppColors.cloud,
                  )
                : const Icon(
                    null,
                    size: 20.0,
                  ),
          ),
        ),
      ],
    );
  }
}
