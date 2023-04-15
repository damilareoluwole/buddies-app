import 'package:flutter/material.dart';
import 'package:buddies/screens/widget/text_field.dart';
import 'package:buddies/settings/app_theme.dart';
import 'package:intl/intl.dart';

class DateFieldWidget extends StatefulWidget {
  const DateFieldWidget({
    Key? key,
    required this.hintText,
    this.initialValue,
    this.maxYearInThePast = 100,
    this.maxYearInFuture = 100,
    required this.onChanged,
  }) : super(key: key);

  final int maxYearInThePast;
  final int maxYearInFuture;
  final String hintText;
  final DateTime? initialValue;
  final void Function(DateTime?) onChanged;

  @override
  State<DateFieldWidget> createState() => _DateFieldWidgetState();
}

class _DateFieldWidgetState extends State<DateFieldWidget> {
  DateTime? date;

  @override
  void initState() {
    super.initState();
    date = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    var paddingVertical = 2.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(
            top: paddingVertical,
            bottom: paddingVertical,
            left: 16,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: AppTheme.textInputColor,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  (date != null)
                      ? DateFormat('MMM dd, yyyy').format(date!)
                      : widget.hintText,
                  style: (date != null) ? AppTheme.caption2 : AppTheme.hintText,
                ),
              ),
              textFieldSvgIconFormatter("assets/icons/calender.svg",
                  color: AppTheme.redColor),
            ],
          ),
        ),
        onTap: () async {
          var now = DateTime.now();

          var initialDate = date ?? DateTime.now();
          var firstDate =
              DateTime(now.year - widget.maxYearInThePast, now.month, now.day);
          var lastDate =
              DateTime(now.year + widget.maxYearInFuture, now.month, now.day);

          var selectedDate = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: firstDate,
              lastDate: lastDate);
          setState(() {
            date = selectedDate;
          });

          widget.onChanged(selectedDate);
        },
      ),
    );
  }
}
