import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _name = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Account')),
      body: ListView(children: [
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
            _name = value!;
          },
        ),
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
            _email = value!;
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
      ]),
    );
  }
}
