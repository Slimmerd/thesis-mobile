import 'package:flutter/material.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/form_input_style.dart';

class EditAddressScreen extends StatefulWidget {
  final Address address;

  const EditAddressScreen({Key? key, required this.address}) : super(key: key);

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _city = '';
  String _street = '';
  String _building = '';
  String _intercom = '';
  int? _floor;
  String _flat = '';
  List<String> availableCitiesData = ["London", "Moscow"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Редактировать адрес'),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                TextFormField(
                  enabled: false,
                  initialValue: widget.address.city,
                  decoration: formInputStyle('Город', ''),
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: formInputStyle('Улица', 'Ленина'),
                  initialValue: widget.address.street,
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Обязательное поле';
                    }
                  },
                  onSaved: (String? value) {
                    _street = value!;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: formInputStyle('Здание', '161'),
                  initialValue: widget.address.building,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.streetAddress,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Обязательное поле';
                    }
                  },
                  onSaved: (String? value) {
                    _building = value!;
                  },
                ),
                SizedBox(height: 20),
                Text('Дополнительно',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                SizedBox(height: 10),
                TextFormField(
                  decoration: formInputStyle('Домофон', '347210'),
                  initialValue: widget.address.intercom,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                    _intercom = value!;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: formInputStyle('Этаж', '2'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  initialValue: widget.address.floor != null
                      ? widget.address.floor.toString()
                      : '',
                  onSaved: (String? value) {
                    _floor = value!.length > 1 ? int.parse(value) : null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: formInputStyle('Кв./офис', '32'),
                  initialValue: widget.address.flatNumber,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.streetAddress,
                  onSaved: (String? value) {
                    _flat = value!;
                  },
                ),
                SizedBox(height: 25),
                ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState!.save();
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      if (widget.address.street != _street ||
                          widget.address.building != _building ||
                          widget.address.flatNumber != _flat ||
                          widget.address.floor != _floor ||
                          widget.address.intercom != _intercom) {
                        // runMutation({
                        //   'id': widget.address.id,
                        //   'city': widget.address.city,
                        //   'street': _street,
                        //   'building': _building,
                        //   'intercom': _intercom,
                        //   'floor': _floor,
                        //   'flat_number': _flat
                        // });
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.MintGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(34.0),
                        ),
                        elevation: 0,
                        minimumSize: Size(335, 53),
                        textStyle: TextStyle(fontSize: 18)),
                    child: Text('Готово'))
              ],
            )));
  }
}
