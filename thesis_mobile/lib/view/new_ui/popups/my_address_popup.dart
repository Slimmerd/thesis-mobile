import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/utils/make_dismissible.dart';
import 'package:thesis_mobile/utils/typography.dart';
import 'package:thesis_mobile/view/new_ui/widgets/address/address_selector.dart';
import 'package:thesis_mobile/view/new_ui/screens/add_address_screen.dart';

class MyAddressesPopup extends StatelessWidget {
  const MyAddressesPopup({super.key});

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
                  child: ListView(
                      physics: ClampingScrollPhysics(),
                      controller: scrollController,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: Text(
                            'Addresses',
                            style: NewTypography.M18600,
                          ),
                        ),
                        BlocBuilder<AddressBloc, AddressState>(
                          builder: (context, state) {
                            AddressBloc addressBl = context.read<AddressBloc>();
                            return ListView.builder(
                                shrinkWrap: true,
                                controller: scrollController,
                                physics: ClampingScrollPhysics(),
                                itemCount: state.addresses.length,
                                itemBuilder: (_, index) {
                                  return AddressSelector(
                                    address: state.addresses[index],
                                    currentID: state.currentAddress!.id,
                                    addressesLength: state.addresses.length,
                                    setNew: (Address newAddress) {
                                      addressBl.setAddress(Address.fromJson(
                                          newAddress.toJson()));
                                    },
                                    remove: (Address address) {
                                      addressBl.removeAddress(
                                          Address.fromJson(address.toJson()));
                                    },
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
                                'Add',
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ]));
            }));
  }
}
