import 'package:flutter/material.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String feildName;
  final Color? textColor;
  final String? errorText;
  final TextInputType? inputType;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final Widget? suffixIcon;
  final Function()? suffixPressed;
  final bool? obscure;

  const AuthTextField({
    Key? key,
    required this.controller,
    this.textColor,
    this.inputType,
    this.onChanged,
    required this.feildName,
    this.errorText,
    this.onSubmit,
    this.suffixIcon,
    this.suffixPressed,
    this.obscure,
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: widget.textColor ?? AppColors.white,
        width: 1,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(
          text: widget.feildName,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: widget.textColor ?? AppColors.white,
        ),
        const SizedBox(height: 7),
        Focus(
          focusNode: _focusNode,
          child: TextFormField(
            obscureText: widget.obscure ?? false,
            controller: widget.controller,
            onTapOutside: (event) {
              _focusNode.unfocus();
            },
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmit,
            cursorColor: widget.textColor ?? AppColors.white,
            cursorRadius: const Radius.circular(30),
            style: const TextStyle(
              fontFamily: 'dmSans',
              color: AppColors.textColor,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              constraints: const BoxConstraints(maxHeight: 40),
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              errorMaxLines: 2,
              errorStyle: const TextStyle(
                fontSize: 12,
                color: AppColors.redColor,
                fontWeight: FontWeight.w400,
              ),
              errorBorder: border,
              suffixIcon: _focusNode.hasFocus
                  ? IconButton(
                onPressed: widget.suffixPressed,
                icon: widget.suffixIcon ?? const SizedBox(),
              )
                  : null,
            ),
            keyboardType: widget.inputType,
            enableSuggestions: true,
            magnifierConfiguration: TextMagnifier.adaptiveMagnifierConfiguration,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.bottomRight,
          child: AppTextStyle(
            text: widget.errorText ?? '',
            fontSize: 12,
            color: widget.textColor ?? AppColors.white,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
