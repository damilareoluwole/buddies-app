import 'package:flutter/material.dart';
import 'package:buddies/settings/app_theme.dart';

Map<String, dynamic>? requestErrors;

Widget checkRequestErrors(String key) {
  if (requestErrors == null) return Container();

  if (requestErrors!.containsKey(key) == false) {
    return Container();
  }
  return Container(
    padding: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: ((requestErrors![key])
          .map<Widget>(
            (e) => Align(
              alignment: Alignment.centerLeft,
              child: Text(
                e,
                style: TextStyle(
                  color: AppTheme.redColor,
                  fontSize: 11,
                ),
              ),
            ),
          )
          .toList()),
    ),
  );
}
