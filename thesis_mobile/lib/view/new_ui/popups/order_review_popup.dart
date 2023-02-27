import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/make_dismissible.dart';

class OrderReview extends StatefulWidget {
  final int orderID;

  const OrderReview({Key? key, required this.orderID}) : super(key: key);

  @override
  State<OrderReview> createState() => _OrderReviewState();
}

class _OrderReviewState extends State<OrderReview> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[NEWUI][OPENED] OrderReviewPopup');

    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
          initialChildSize: 0.50,
          maxChildSize: 0.55,
          minChildSize: 0.50,
          builder:
              (BuildContext buildContext, ScrollController scrollController) {
            return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: const BoxDecoration(
                  color: AppColors.cloud,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
                child: Column(children: [
                  Text('Leave a review about your order',
                      style: Theme.of(context).textTheme.headline6),
                  const SizedBox(
                    height: 20,
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: AppColors.mintGreen,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() => _rating = rating);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        taskContext.addLogTask(
                            '[NEWUI][ADDED] OrderReview ${widget.orderID}, rate: $_rating');
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _rating > 0
                              ? AppColors.mintGreen
                              : AppColors.grayPick,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(34.0),
                          ),
                          elevation: 0,
                          minimumSize: const Size(210, 48),
                          maximumSize: const Size(225, 53),
                          textStyle: const TextStyle(fontSize: 18)),
                      child: const Text('Send'))
                ]));
          }),
    );
  }
}
