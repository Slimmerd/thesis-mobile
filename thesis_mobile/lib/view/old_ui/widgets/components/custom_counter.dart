import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';

class CustomCounter extends StatefulWidget {
  final int quantity;
  final double height;
  final Function(int quantity)? onChanged;

  CustomCounter(
      {required this.height, required this.quantity, required this.onChanged});

  @override
  _CustomCounterState createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  void add() {
    setState(() {
      if (widget.quantity < 30) widget.onChanged?.call(widget.quantity + 1);
    });
  }

  void minus() {
    setState(() {
      if (widget.quantity >= 0) widget.onChanged?.call(widget.quantity - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
          color: AppColors.Dorian, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            width: 34,
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: minus,
              // child: Icon(Icons.remove, color: Colors.black),
              icon: Icon(
                Icons.remove,
                color: AppColors.Graphite,
                size: 14.0,
              ),
            ),
          ),
          Text('${widget.quantity}',
              style: TextStyle(
                  color: AppColors.Graphite,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500)),
          Container(
            width: 34,
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: add,
              icon: Icon(
                Icons.add,
                color: AppColors.Graphite,
                size: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
