import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';

class CustomCounter extends StatefulWidget {
  final int quantity;
  final double height;
  final Function(int quantity)? onChanged;

  const CustomCounter(
      {super.key, required this.height, required this.quantity, required this.onChanged});

  @override
  State<CustomCounter> createState() => _CustomCounterState();
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
          color: AppColors.dorian, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          SizedBox(
            width: 34,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: minus,
              icon: const Icon(
                Icons.remove,
                color: AppColors.graphite,
                size: 14.0,
              ),
            ),
          ),
          Text('${widget.quantity}',
              style: const TextStyle(
                  color: AppColors.graphite,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500)),
          SizedBox(
            width: 34,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: add,
              icon: const Icon(
                Icons.add,
                color: AppColors.graphite,
                size: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
