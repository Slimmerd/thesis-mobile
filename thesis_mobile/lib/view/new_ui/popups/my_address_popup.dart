import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/utils/make_dismissible.dart';
import 'package:thesis_mobile/view/new_ui/widgets/address/address_selector.dart';
import 'package:thesis_mobile/view/new_ui/screens/add_address_screen.dart';

class MyAddressesPopup extends StatelessWidget {
  final AddressState addressState;

  const MyAddressesPopup({super.key, required this.addressState});

  @override
  Widget build(BuildContext context) {
    return makeDismissible(
        context: context,
        child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            maxChildSize: 0.6,
            minChildSize: 0.5,
            builder:
                (BuildContext buildContext, ScrollController scrollController) {
              return Container(
                  decoration: BoxDecoration(
                    color: AppColors.Cloud,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
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
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: Text(
                            'Мои адреса',
                            style: TextStyle(
                                color: AppColors.Graphite,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        BlocBuilder<AddressBloc, AddressState>(
                          builder: (context, state) {
                            AddressBloc addressBl = context.read<AddressBloc>();
                            return ListView.builder(
                                shrinkWrap: true,
                                controller: scrollController,
                                physics: ClampingScrollPhysics(),
                                itemCount: addressState.addresses.length,
                                itemBuilder: (_, index) {
                                  return AddressSelector(
                                    address: addressState.addresses[index],
                                    current: addressState.currentAddress!,
                                    setNew: (Address newAddress) {
                                      addressBl.setAddress(Address.fromJson(
                                          newAddress.toJson()));
                                    },
                                    addressData: addressState.addresses,
                                  );
                                });
                          },
                        ),
                        InkWell(
                          onTap: () =>
                              customPagePush(context, AddAddressScreen())
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
                      ]));
            }));
  }
}
