import 'package:flutter/material.dart';
import 'package:buddies/settings/app_theme.dart';

class CheckBox extends StatefulWidget {
  const CheckBox(
      {super.key,
      required this.onChanged,
      required this.initial,
      required this.text});

  final Function(bool) onChanged;
  final bool initial;
  final String text;
  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    isChecked = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppTheme.darkGreyColor;
    }

    return InkWell(
      child: Row(
        children: [
          Transform.scale(
            scale: 1.3,
            child: SizedBox(
              height: 24.0,
              width: 24.0,
              child: Checkbox(
                checkColor: AppTheme.whiteColor,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                  widget.onChanged(isChecked);
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.text,
              style: AppTheme.caption2.copyWith(color: AppTheme.grey2),
            ),
          ),
        ],
      ),
      onTap: () {
        debugPrint('YYY');
        setState(() {
          isChecked = !isChecked;
        });
      },
    );
  }
}
