import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/view/old_ui/screens/add_address_screen.dart';
import 'package:thesis_mobile/view/old_ui/widgets/address/address_selector.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Мои адреса',
          style: TextStyle(
              color: AppColors.Graphite,
              fontSize: 24,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            color: AppColors.Cloud,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child:
              // final addressContext = BlocProvider.of<AddressBloc>(context);

              // client.mutate(MutationOptions(
              //   document: ADD_ADDRESS_MUTATION_DOCUMENT,
              //   fetchPolicy: FetchPolicy.noCache,
              //   variables: {
              //     'city': addressContext.state.currentAddress!.city,
              //     'street': addressContext.state.currentAddress!.street,
              //     'building':
              //         addressContext.state.currentAddress!.building,
              //     'intercom':
              //         addressContext.state.currentAddress!.intercom,
              //     'floor': addressContext.state.currentAddress!.floor,
              //     'flat_number':
              //         addressContext.state.currentAddress!.flat_number
              //   },
              //   onCompleted: (dynamic resultData) {
              //     if (resultData == null) return;
              //     final addAddressResponse =
              //         AddAddress$Mutation.fromJson(resultData).addAddress;
              //     if (addAddressResponse.id != -1) {
              //       addressContext.setAddress(
              //           EditAddressArguments.fromJson(
              //               addAddressResponse.toJson()));
              //     }
              //   },
              // ));

              ListView(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  children: [
                BlocBuilder<AddressBloc, AddressState>(
                  builder: (context, state) {
                    AddressBloc addressBl = context.read<AddressBloc>();
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: state.addresses.length,
                        itemBuilder: (_, index) {
                          return AddressSelector(
                            address: state.addresses[index],
                            current: state.currentAddress!,
                            setNew: (Address newAddress) {
                              addressBl.setAddress(
                                  Address.fromJson(newAddress.toJson()));
                            },
                            addressData: state.addresses,
                          );
                        });
                  },
                ),
                InkWell(
                  onTap: () => customPagePush(context, AddAddressScreen())
                      .then((value) => {}),
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Добавить',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ])),
    );
  }
}
