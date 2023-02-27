import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/utils/typography.dart';
import 'package:thesis_mobile/view/old_ui/screens/add_address_screen.dart';
import 'package:thesis_mobile/view/old_ui/widgets/address/address_selector.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[OLDUI][OPENED] AddressesScreen');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Addresses',
          style: NewTypography.m18600,
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
            color: AppColors.cloud,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: ListView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                BlocBuilder<AddressBloc, AddressState>(
                  builder: (context, state) {
                    AddressBloc addressBl = context.read<AddressBloc>();
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: state.addresses.length,
                        itemBuilder: (_, index) {
                          return AddressSelector(
                            address: state.addresses[index],
                            currentID: state.currentAddress!.id,
                            addressesLength: state.addresses.length,
                            setNew: (Address newAddress) {
                              addressBl.setAddress(
                                  Address.fromJson(newAddress.toJson()));
                              taskContext.addLogTask(
                                  '[OLDUI][UPDATED] CurrentAddress ${newAddress.id}');
                            },
                            remove: (Address address) {
                              addressBl.removeAddress(
                                  Address.fromJson(address.toJson()));
                              taskContext.addLogTask(
                                  '[OLDUI][REMOVED] Address: ${address.id}');
                            },
                          );
                        });
                  },
                ),
                InkWell(
                  onTap: () => customPagePush(context, const AddAddressScreen()),
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
              ])),
    );
  }
}
