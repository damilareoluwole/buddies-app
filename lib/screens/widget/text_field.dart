import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:buddies/settings/app_theme.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    this.hasIcon = false,
    this.enabled = true,
    this.hintText,
    this.autoFocus = false,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.isPassword = false,
    this.controller,
    this.onChanged,
    this.maxLines = 1,
    this.minLines = 1,
    this.focusNode,
    this.onTap,
    this.contentPadding,
    this.paddingBottom = 12.0,
  }) : super(key: key);

  final bool hasIcon;
  final bool enabled;
  final String? hintText;
  final bool autoFocus;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final double paddingBottom;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  var _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

// Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.paddingBottom),
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.controller,
        obscureText: _obscureText,
        cursorColor: AppTheme.blackColor,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(
                vertical: 18.0,
                horizontal: 16.0,
              ),
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              width: 2,
              color: AppTheme.textInputColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              width: 2,
              color: AppTheme.textInputColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              width: 2,
              color: AppTheme.textInputColor,
            ),
          ),
          hintStyle: AppTheme.hintText,
          suffixIcon: (widget.isPassword)
              ? InkWell(
                  onTap: () => _toggle(),
                  child: (_obscureText)
                      ? textFieldImageIconFormatter(
                          "assets/icons/password_open.png")
                      : textFieldSvgIconFormatter(
                          "assets/icons/password_hidden.svg"),
                )
              : (widget.hasIcon == true)
                  ? null //textFieldSvgIconFormatter("assets/icons/check.svg")
                  : null,
        ),
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        autofocus: widget.autoFocus,
        style: AppTheme.caption2,
        maxLines: (widget.isPassword) ? 1 : widget.maxLines,
        minLines: (widget.isPassword) ? 1 : widget.minLines,
        validator: widget.validator,
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        onTap: widget.onTap,
      ),
    );
  }
}

Widget textFieldSvgIconFormatter(String asset,
    {Color? color, double size = 40.0}) {
  // if (color == null && appSettings.d) {
  //   color = AppTheme.blackColor;
  // }
  return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: size,
      width: size,
      child: SvgPicture.asset(
        asset,
        color: color,
      ));
}

Widget textFieldImageIconFormatter(String asset,
    {Color? color, double size = 40.0}) {
  // if (color == null && appSettings.d) {
  //   color = AppTheme.blackColor;
  // }
  return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: size,
      width: size,
      child: Image.asset(
        asset,
        color: color,
      ));
}
