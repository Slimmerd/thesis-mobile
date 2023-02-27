import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';

class CustomCheckBox extends StatefulWidget {
  final bool isChecked;
  final Function(bool isChecked)? onChange;

  const CustomCheckBox({
    Key? key,
    required this.isChecked,
    required this.onChange,
  }) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: Checkbox(
        activeColor: AppColors.dorian,
        checkColor: AppColors.graphite,
        value: widget.isChecked,
        onChanged: (value) {
          setState(() {
            this.value = value!;
            widget.onChange?.call(value);
          });
        },
      ),
    );
  }
}
