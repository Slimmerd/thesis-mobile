import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/form_input_style.dart';

class PayDropdown extends StatefulWidget {
  final String payMethod;
  final Function(String dropdownValue) callback;

  const PayDropdown({Key? key, required this.payMethod, required this.callback})
      : super(key: key);

  @override
  State<PayDropdown> createState() => _PayDropdownState();
}

class _PayDropdownState extends State<PayDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      borderRadius: BorderRadius.circular(14.0),
      decoration: formInputStyle(''),
      dropdownColor: AppColors.dorian,
      value: widget.payMethod,
      icon: const Icon(Icons.expand_more),
      iconSize: 24,
      isExpanded: true,
      elevation: 16,
      style: const TextStyle(
          color: AppColors.graphite, fontSize: 18, fontWeight: FontWeight.w400),
      onChanged: (String? newValue) {
        widget.callback.call(newValue!);
      },
      items: [
        'Card',
        // Platform.isAndroid ? 'Google Pay' :'Apple Pay'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
