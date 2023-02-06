import 'package:flutter/material.dart';

class SMSScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _sms = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Enter code from SMS'),
              Text('Code sent to + 7 909 000 00 00'),
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
                  _sms = value!;
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
          )),
    );
  }
}
