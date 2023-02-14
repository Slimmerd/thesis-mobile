import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
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
  String _street = '';
  String _building = '';
  String _intercom = '';
  String _floor = '';
  String _flat = '';
  List<String> availableCitiesData = ["London", "Moscow"];

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[OLDUI][OPENED] EditScreen ${widget.address.id}');

    return Scaffold(
        appBar: AppBar(
          title: Text('Edit address'),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                TextFormField(
                  enabled: false,
                  initialValue: widget.address.city,
                  decoration: formInputStyle('City'),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: formInputStyle('Street'),
                  style: Theme.of(context).textTheme.bodyText2,
                  initialValue: widget.address.street,
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                  },
                  onSaved: (String? value) {
                    _street = value!;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: formInputStyle('Building'),
                  style: Theme.of(context).textTheme.bodyText2,
                  initialValue: widget.address.building,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.streetAddress,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                  },
                  onSaved: (String? value) {
                    _building = value!;
                  },
                ),
                SizedBox(height: 20),
                Text('Additional',
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 10),
                TextFormField(
                  decoration: formInputStyle('Intercom'),
                  style: Theme.of(context).textTheme.bodyText2,
                  initialValue: widget.address.intercom,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                    _intercom = value!;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: formInputStyle('Floor'),
                  style: Theme.of(context).textTheme.bodyText2,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  initialValue: widget.address.floor != null
                      ? widget.address.floor.toString()
                      : '',
                  onSaved: (String? value) {
                    _floor = value!;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: formInputStyle('Flat/Office'),
                  style: Theme.of(context).textTheme.bodyText2,
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
                      final addressContext =
                          BlocProvider.of<AddressBloc>(context);

                      taskContext.addLogTask(
                          '[OLDUI][UPDATED] Address ${widget.address.id}');

                      if (widget.address.street != _street ||
                          widget.address.building != _building ||
                          widget.address.flatNumber != _flat ||
                          widget.address.floor != _floor ||
                          widget.address.intercom != _intercom) {
                        addressContext.updateAddress(Address(
                            id: widget.address.id,
                            city: widget.address.city,
                            street: _street,
                            building: _building,
                            floor: _floor,
                            intercom: _intercom,
                            flatNumber: _flat));
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.MintGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        elevation: 0,
                        minimumSize: Size(335, 53),
                        textStyle: TextStyle(fontSize: 18)),
                    child: Text('Save'))
              ],
            )));
  }
}
