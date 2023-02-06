import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/form_input_style.dart';

class PayDrodown extends StatefulWidget {
  final String payMethod;
  final Function(String dropdownValue) callback;

  const PayDrodown({Key? key, required this.payMethod, required this.callback})
      : super(key: key);

  @override
  _PayDrodownState createState() => _PayDrodownState();
}

class _PayDrodownState extends State<PayDrodown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      borderRadius: BorderRadius.circular(14.0),
      decoration: formInputStyle(''),
      dropdownColor: AppColors.Dorian,
      value: widget.payMethod,
      icon: Icon(Icons.expand_more),
      iconSize: 24,
      isExpanded: true,
      elevation: 16,
      style: const TextStyle(
          color: AppColors.Graphite, fontSize: 18, fontWeight: FontWeight.w400),
      onChanged: (String? newValue) {
        widget.callback.call(newValue!);
      },
      items: [
        'Картой',
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
