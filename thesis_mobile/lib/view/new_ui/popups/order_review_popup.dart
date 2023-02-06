import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/make_dismissible.dart';

class OrderReviewBS extends StatefulWidget {
  final int orderID;

  OrderReviewBS({Key? key, required this.orderID}) : super(key: key);

  @override
  State<OrderReviewBS> createState() => _OrderReviewBSState();
}

class _OrderReviewBSState extends State<OrderReviewBS> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
          initialChildSize: 0.50,
          maxChildSize: 0.60,
          minChildSize: 0.50,
          builder:
              (BuildContext buildContext, ScrollController scrollController) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.Cloud,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
                child: Column(children: [
                  Text('Оставьте отзыв о вашем заказе',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: 20,
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: AppColors.MintGreen,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() => _rating = rating);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text('Отправить'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _rating > 0
                              ? AppColors.MintGreen
                              : AppColors.GrayPick,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(34.0),
                          ),
                          elevation: 0,
                          minimumSize: Size(210, 48),
                          maximumSize: Size(225, 53),
                          textStyle: TextStyle(fontSize: 18)))
                ]));
          }),
    );
  }
}
