import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/form_input_style.dart';

class TimeRangeDropdown extends StatefulWidget {
  final int rangeHours;
  final Function(String dropdownValue) callback;

  const TimeRangeDropdown(
      {Key? key, required this.callback, required this.rangeHours})
      : super(key: key);

  static Map<int, String> hoursRange2 = {
    0: "00:00-02:00",
    2: "02:00-04:00",
    4: "04:00-06:00",
    6: "06:00-08:00",
    8: "08:00-10:00",
    10: "10:00-12:00",
    12: "12:00-14:00",
    14: "14:00-16:00",
    16: "16:00-18:00",
    18: "18:00-20:00",
    20: "20:00-22:00",
    22: "22:00-00:00"
  };

  static Map<int, String> hoursRange1 = {
    0: "00:00-01:00",
    1: "01:00-02:00",
    2: "02:00-03:00",
    3: "03:00-04:00",
    4: "04:00-05:00",
    5: "05:00-06:00",
    6: "06:00-07:00",
    7: "07:00-08:00",
    8: "08:00-09:00",
    9: "09:00-10:00",
    10: "10:00-11:00",
    11: "11:00-12:00",
    12: "12:00-13:00",
    13: "13:00-14:00",
    14: "14:00-15:00",
    15: "15:00-16:00",
    16: "16:00-17:00",
    17: "17:00-18:00",
    18: "18:00-19:00",
    19: "19:00-20:00",
    20: "20:00-21:00",
    21: "21:00-22:00",
    22: "22:00-23:00",
    23: "23:00-00:00",
  };

  @override
  State<TimeRangeDropdown> createState() => _TimeRangeDropdownState();
}

class _TimeRangeDropdownState extends State<TimeRangeDropdown> {
  List<String> timeRange = [];

  void updateTimeRange() {
    List<String> _timeRange = [];
    int time = DateTime.now().hour;
    if (widget.rangeHours == 1) {
      TimeRangeDropdown.hoursRange2.forEach((key, value) {
        if (key > time) {
          _timeRange.add(value);
        }
      });
    } else if (widget.rangeHours == 2) {
      TimeRangeDropdown.hoursRange1.forEach((key, value) {
        if (key > time) {
          _timeRange.add(value);
        }
      });
    }
    timeRange = _timeRange;
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
      dropdownColor: AppColors.Dorian,
      value: timeRange[0],
      icon: Icon(Icons.expand_more),
      iconSize: 24,
      isExpanded: true,
      elevation: 16,
      style: const TextStyle(
          color: AppColors.Graphite, fontSize: 18, fontWeight: FontWeight.w400),
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
