import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/delivery_type.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/make_dismissible.dart';
import 'package:thesis_mobile/utils/typography.dart';
import 'package:thesis_mobile/view/new_ui/widgets/cart/time_range_dropdown.dart';
import 'package:thesis_mobile/view/new_ui/widgets/components/cloud_card.dart';
import 'package:thesis_mobile/view/new_ui/widgets/components/custom_checkbox.dart';

class DeliveryPopup extends StatefulWidget {
  const DeliveryPopup({super.key});

  @override
  State<DeliveryPopup> createState() => _DeliveryPopupState();
}

class _DeliveryPopupState extends State<DeliveryPopup> {
  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[NEWUI][OPENED] DeliveryPopup');

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        CartBloc cart = context.read<CartBloc>();
        return makeDismissible(
            context: context,
            child: DraggableScrollableSheet(
                initialChildSize: 0.85,
                maxChildSize: 0.95,
                minChildSize: 0.8,
                builder: (BuildContext buildContext,
                    ScrollController scrollController) {
                  return Container(
                      decoration: BoxDecoration(
                        color: AppColors.Cloud,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                      ),
                      child: ListView(
                        padding: EdgeInsets.all(20),
                        controller: scrollController,
                        children: [
                          Text(
                            'Delivery',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CloudCard(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivery time 20-30 min',
                                style: NewTypography.M18600,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Working hours: 24/7',
                                style: NewTypography.M12400,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.eco,
                                    color: AppColors.MintGreen,
                                  ),
                                  Flexible(
                                    child: Text(
                                      ' - Represents reduced environmental impact from low (red) to high (green)',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                          CloudCard(
                              child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Terms',
                                    style: NewTypography.M18600,
                                  ),
                                  Text(
                                    'Cart',
                                    style: NewTypography.M18600,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //Red
                              Container(
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.eco,
                                            size: 18,
                                            color: AppColors.RedWarn,
                                          ),
                                          Text(
                                            'Delivery 3.99 £',
                                            style: NewTypography.M12400,
                                          )
                                        ],
                                      ),
                                      Text(
                                        'from 0 £',
                                        style: NewTypography.M12400,
                                      )
                                    ],
                                  )
                                ]),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              //Yellow
                              Container(
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.eco,
                                            size: 18,
                                            color: AppColors.YellowWarn,
                                          ),
                                          Text(
                                            'Delivery 1.99 £',
                                            style: NewTypography.M12400,
                                          )
                                        ],
                                      ),
                                      Text(
                                        'from 6.00 £',
                                        style: NewTypography.M12400,
                                      )
                                    ],
                                  )
                                ]),
                              ),
                              SizedBox(
                                height: 5,
                              ), //Green
                              Container(
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.eco,
                                            size: 18,
                                            color: AppColors.MintGreen,
                                          ),
                                          Text(
                                            'Delivery 0 £',
                                            style: NewTypography.M12400,
                                          )
                                        ],
                                      ),
                                      Text(
                                        'from 12.00 £',
                                        style: NewTypography.M12400,
                                      )
                                    ],
                                  )
                                ]),
                              )
                            ],
                          )),

                          //Delivery Options
                          CloudCard(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivery option',
                                style: NewTypography.M18600,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.eco,
                                            size: 18,
                                            color: AppColors.RedWarn,
                                          ),
                                          Text(
                                            'As soon as possible',
                                            style: NewTypography.M12400,
                                          )
                                        ],
                                      ),
                                      CustomCheckBox(
                                        isChecked: cart.state.deliveryType ==
                                            DeliveryType.asap,
                                        onChange: (bool value) {
                                          taskContext.addLogTask(
                                              '[NEWUI][UPDATED] DeliveryType ASAP');
                                          cart.updateDeliveryType(
                                              DeliveryType.asap);
                                        },
                                      )
                                    ],
                                  )
                                ]),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.eco,
                                            size: 18,
                                            color: AppColors.YellowWarn,
                                          ),
                                          Text(
                                            'Shorter time slot',
                                            style: NewTypography.M12400,
                                          )
                                        ],
                                      ),
                                      CustomCheckBox(
                                        isChecked: cart.state.deliveryType ==
                                            DeliveryType.sts,
                                        onChange: (bool value) {
                                          taskContext.addLogTask(
                                              '[NEWUI][UPDATED] DeliveryType STS');
                                          cart.updateDeliveryType(
                                              DeliveryType.sts);
                                        },
                                      )
                                    ],
                                  )
                                ]),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.eco,
                                            size: 18,
                                            color: AppColors.MintGreen,
                                          ),
                                          Text(
                                            'Larger time slot',
                                            style: NewTypography.M12400,
                                          )
                                        ],
                                      ),
                                      CustomCheckBox(
                                        isChecked: cart.state.deliveryType ==
                                            DeliveryType.lts,
                                        onChange: (bool value) {
                                          taskContext.addLogTask(
                                              '[NEWUI][UPDATED] DeliveryType LTS');
                                          cart.updateDeliveryType(
                                              DeliveryType.lts);
                                        },
                                      )
                                    ],
                                  )
                                ]),
                              ),
                            ],
                          )),

                          if (state.deliveryType.index > 0)
                            CloudCard(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delivery time',
                                  style: NewTypography.M18600,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TimeRangeDropdown(
                                  rangeHours: state.deliveryType.index,
                                  callback: (String dropdownValue) {
                                    taskContext.addLogTask(
                                        '[NEWUI][UPDATED] DeliveryWindow $dropdownValue');
                                    cart.updateDeliveryWindow(dropdownValue);
                                  },
                                ),
                              ],
                            ))
                        ],
                      ));
                }));
      },
    );
  }
}
