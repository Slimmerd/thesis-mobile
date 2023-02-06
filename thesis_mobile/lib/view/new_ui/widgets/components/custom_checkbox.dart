import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';

class CustomCheckBox extends StatefulWidget {
  final bool isChecked;
  final Function(bool isChecked)? onChange;

  CustomCheckBox({
    Key? key,
    required this.isChecked,
    required this.onChange,
  }) : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 20,
        height: 20,
        child: Checkbox(
          activeColor: AppColors.Dorian,
          checkColor: AppColors.Graphite,
          value: widget.isChecked,
          onChanged: (value) {
            setState(() {
              this.value = value!;
              widget.onChange?.call(value);
            });
          },
        ),
      ),
    );
  }
}
