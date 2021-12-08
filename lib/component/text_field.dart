import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class InAppTextField extends StatelessWidget {
  final TextEditingController? controller;

  final double? borderWidth;
  final BorderRadius? borderRadius;
  final String? label;
  final Color? borderColor;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final int? maxLines;
  final int? minLines;
  final bool? passwordText;
  final int? maxLength;
  final EdgeInsets? insetPadding;
  final TextInputType? keyboard;
  final bool? enabled;
  final Color? disabledBorderColor;
  final TextStyle? disabledTextStyle;
  final Widget? suffix;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final TextStyle? errorStyle;
  final TextInputAction? textInputAction;

  final List<TextInputFormatter>? totalInputFormatters = [];

  InAppTextField({
    Key? key,
    this.borderWidth = 1.25,
    this.inputFormatters,
    this.textInputAction = TextInputAction.done,
    this.borderRadius = BorderRadius.zero,
    this.label,
    this.borderColor = Colors.black,
    this.textStyle = const TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    this.labelStyle = const TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    this.maxLines = 1,
    this.minLines = 1,
    this.passwordText = false,
    this.maxLength = 32,
    this.insetPadding = const EdgeInsets.all(
      15,
    ),
    this.controller,
    this.keyboard = TextInputType.text,
    this.enabled = true,
    this.disabledBorderColor = Colors.grey,
    this.disabledTextStyle = const TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    this.suffix,
    this.prefix,
    this.errorText,
    this.errorStyle = const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.w600,
    ),
  }) : super(key: key) {
    if (inputFormatters != null) totalInputFormatters!.addAll(inputFormatters!);
    totalInputFormatters!.addAll([
      LengthLimitingTextInputFormatter(maxLength),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: enabled! ? textStyle : disabledTextStyle,
          controller: controller,
          keyboardType: keyboard,
          enabled: enabled,
          textInputAction: textInputAction,
          maxLines: maxLines,
          minLines: minLines,
          obscureText: passwordText!,
          inputFormatters: totalInputFormatters,
          decoration: InputDecoration(
            labelStyle: enabled! ? labelStyle : disabledTextStyle,
            suffixStyle: enabled! ? textStyle : disabledTextStyle,
            counterStyle: enabled! ? textStyle : disabledTextStyle,
            errorStyle: enabled! ? textStyle : disabledTextStyle,
            helperStyle: enabled! ? textStyle : disabledTextStyle,
            hintStyle: enabled! ? textStyle : disabledTextStyle,
            prefixStyle: enabled! ? textStyle : disabledTextStyle,
            focusedErrorBorder: border(),
            border: border(),
            disabledBorder: border(),
            contentPadding: insetPadding,
            enabledBorder: border(),
            errorBorder: border(),
            focusedBorder: border(),
            suffixIcon: suffix,
            prefixIcon: prefix,
            hintMaxLines: 1,
            labelText: label,
          ),
        ),
        if (errorText != null)
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                    child: Text(
                      errorText!,
                      textAlign: TextAlign.left,
                      style: errorStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }

  border() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: borderWidth!,
        color: enabled! ? borderColor! : disabledBorderColor!,
      ),
      borderRadius: borderRadius!,
    );
  }
}
