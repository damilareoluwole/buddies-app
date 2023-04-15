import 'dart:async';

import 'package:flutter/material.dart';

class TimerButton extends StatefulWidget {
  const TimerButton({
    Key? key,
    required this.child,
    this.durration = 60,
    required this.counterWidget,
  }) : super(key: key);

  final int durration;
  final Widget Function(int) counterWidget;
  final Widget child;
  @override
  State<TimerButton> createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  _TimerButtonState();
  late int start;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    start = widget.durration;
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (start > 0) ? widget.counterWidget(start) : widget.child;
  }
}
