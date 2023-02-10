import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/form_input_style.dart';

class AddAddressScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _city = '';
  String _street = '';
  String _building = '';
  String _intercom = '';
  String _floor = '';
  String _flat = '';
  List<String> availableCitiesData = ["Moscow", "London"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("New address")),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                DropdownButtonFormField(
                  borderRadius: BorderRadius.circular(15.0),
                  decoration: formInputStyle('City'),
                  dropdownColor: AppColors.Dorian,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: Theme.of(context).textTheme.bodyText2,
                  elevation: 8,
                  onChanged: (String? newValue) {
                    _city = newValue!;
                  },
                  items: availableCitiesData
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: formInputStyle('Street'),
                  style: Theme.of(context).textTheme.bodyText2,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value == null || value.isEmpty || value.length <= 1) {
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
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
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
                  onSaved: (String? value) {
                    _floor = value!;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: formInputStyle('Flat/Office'),
                  style: Theme.of(context).textTheme.bodyText2,
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.done,
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
                      addressContext.setAddress(Address(
                          id: addressContext.state.latestAddress + 1,
                          city: _city,
                          street: _street,
                          building: _building,
                          floor: _floor,
                          intercom: _intercom,
                          flatNumber: _flat));

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.MintGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        elevation: 0,
                        minimumSize: Size(335, 53),
                        textStyle: TextStyle(fontSize: 18)),
                    child: Text('Add'))
              ],
            )));
  }
}
