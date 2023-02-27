import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/utils/make_dismissible.dart';
import 'package:thesis_mobile/utils/typography.dart';
import 'package:thesis_mobile/view/new_ui/widgets/address/address_selector.dart';
import 'package:thesis_mobile/view/new_ui/screens/add_address_screen.dart';

class AddressesPopup extends StatelessWidget {
  const AddressesPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[NEWUI][OPENED] AddressesPopup');

    return makeDismissible(
        context: context,
        child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            maxChildSize: 0.6,
            minChildSize: 0.5,
            builder:
                (BuildContext buildContext, ScrollController scrollController) {
              return Container(
                  decoration: const BoxDecoration(
                    color: AppColors.cloud,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                  child: ListView(
                      physics: const ClampingScrollPhysics(),
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            'Addresses',
                            style: NewTypography.m18600,
                          ),
                        ),
                        BlocBuilder<AddressBloc, AddressState>(
                          builder: (context, state) {
                            AddressBloc addressBl = context.read<AddressBloc>();
                            return ListView.builder(
                                shrinkWrap: true,
                                controller: scrollController,
                                physics: const ClampingScrollPhysics(),
                                itemCount: state.addresses.length,
                                itemBuilder: (_, index) {
                                  return AddressSelector(
                                    address: state.addresses[index],
                                    currentID: state.currentAddress!.id,
                                    addressesLength: state.addresses.length,
                                    setNew: (Address newAddress) {
                                      addressBl.setAddress(Address.fromJson(
                                          newAddress.toJson()));
                                      taskContext.addLogTask(
                                          '[NEWUI][UPDATED] CurrentAddress ${newAddress.id}');
                                    },
                                    remove: (Address address) {
                                      taskContext.addLogTask(
                                          '[NEWUI][REMOVED] Address ${address.id}');
                                      addressBl.removeAddress(
                                          Address.fromJson(address.toJson()));
                                    },
                                  );
                                });
                          },
                        ),
                        InkWell(
                          onTap: () =>
                              customPagePush(context, const AddAddressScreen())
                                  .then((value) => {}),
                          child: Row(
                            children: const [
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
