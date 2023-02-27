import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/default_data.dart';
import 'package:thesis_mobile/utils/form_input_style.dart';

class TimeRangeDropdown extends StatefulWidget {
  final int rangeHours;
  final Function(String dropdownValue) callback;

  const TimeRangeDropdown(
      {Key? key, required this.callback, required this.rangeHours})
      : super(key: key);

  @override
  State<TimeRangeDropdown> createState() => _TimeRangeDropdownState();
}

class _TimeRangeDropdownState extends State<TimeRangeDropdown> {
  List<String> timeRange = [];

  void updateTimeRange() {
    List<String> localTimeRange = [];
    int time = DateTime.now().hour;
    if (widget.rangeHours == 1) {
      DefaultData.hoursRange1.forEach((key, value) {
        if (key > time) {
          localTimeRange.add(value);
        }
      });
    } else if (widget.rangeHours == 2) {
      DefaultData.hoursRange2.forEach((key, value) {
        if (key > time) {
          localTimeRange.add(value);
        }
      });
    }
    timeRange = localTimeRange;
  }

  @override
  void initState() {
    updateTimeRange();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TimeRangeDropdown oldWidget) {
    if (oldWidget.rangeHours != widget.rangeHours) {
      updateTimeRange();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      borderRadius: BorderRadius.circular(14.0),
      decoration: formInputStyle(''),
      dropdownColor: AppColors.dorian,
      value: timeRange[0],
      icon: const Icon(Icons.expand_more),
      iconSize: 24,
      isExpanded: true,
      elevation: 16,
      style: const TextStyle(
          color: AppColors.graphite, fontSize: 18, fontWeight: FontWeight.w400),
      onChanged: (String? newValue) {
        widget.callback.call(newValue!);
      },
      items: timeRange.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
