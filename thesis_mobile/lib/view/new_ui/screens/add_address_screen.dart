import 'package:flutter/material.dart';

class AddAddressScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _city = '';
  String _street = '';
  String _building = '';
  String _intercom = '';
  int? _floor;
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
                  // decoration: formInputStyle('Город'),
                  // dropdownColor: AppColors.Dorian,
                  icon: const Icon(Icons.keyboard_arrow_down),
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
                  // validator: (List<String>? value) {
                  // if (value == null || value.id == -1) {
                  // return 'Обязательное поле';
                  // }
                  // },
                ),
                SizedBox(height: 15),
                TextFormField(
                  // decoration: formInputStyle('Улица*', 'Ленина'),
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value == null || value.isEmpty || value.length <= 1) {
                      return 'Обязательное поле';
                    }

                    // if (!cyrilicValidator.hasMatch(value)) {
                    //   return 'Введите корретный адрес';
                    // }
                  },
                  onSaved: (String? value) {
                    _street = value!;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  // decoration: formInputStyle('Здание*', '161'),
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Обязательное поле';
                    }

                    // if (!cyrilicValidator.hasMatch(value)) {
                    //   return 'Введите корретный адрес';
                    // }
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
                  // decoration: formInputStyle('Домофон', '347210'),
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  onSaved: (String? value) {
                    _intercom = value!;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  // decoration: formInputStyle('Этаж', '2'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onSaved: (String? value) {
                    _floor = value!.length > 1 ? int.parse(value) : null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  // decoration: formInputStyle('Кв./офис', '32'),
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
                      // final authContext = BlocProvider.of<AuthBloc>(context);

                      // if (authContext.state.isAuth == true) {
                      // runMutation({
                      //   'city': _city,
                      //   'street': _street,
                      //   'building': _building,
                      //   'intercom': _intercom,
                      //   'floor': _floor,
                      //   'flat_number': _flat
                      // });
                      // } else {
                      // final addressContext = BlocProvider.of<AddressBloc>(context);
                      // addressContext.setAddress(EditAddressArguments(
                      //     id: -1,
                      //     city: _city,
                      //     street: _street,
                      //     building: _building,
                      //     floor: _floor,
                      //     intercom: _intercom,
                      //     flat_number: _flat));
                      // if (widget.isFirstOpened == false) {
                      //   Box isFirstOpened = await Hive.openBox('isFirstOpened');
                      //   isFirstOpened.put('state', true);
                      //   customPageReplace(context, NavWrapper());
                      // } else {
                      //   Navigator.pop(context);
                      // }
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                        // primary: AppColors.MintGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(34.0),
                        ),
                        elevation: 0,
                        minimumSize: Size(335, 53),
                        textStyle: TextStyle(fontSize: 18)),
                    child: Text('Добавить'))
              ],
            )));
  }
}
