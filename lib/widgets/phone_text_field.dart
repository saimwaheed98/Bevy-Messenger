import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_field/phone_number.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../core/di/service_locator_imports.dart';
import '../pages/signup/presentation/bloc/cubit/create_profile_cubit.dart';
import '../utils/app_text_style.dart';
import '../utils/colors.dart';

class PhoneTextField extends StatefulWidget {
  final String feildName;
  final Color? textColor;
  final String? errorText;
  final Function(PhoneNumber)? onChanged;
  final Function(String)? onSubmit;

  const PhoneTextField({
    Key? key,
    this.textColor,
    this.onChanged,
    required this.feildName,
    this.errorText,
    this.onSubmit,
  }) : super(key: key);

  @override
  _PhoneTextFieldState createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  final PhoneController _phoneController = PhoneController();
  final CreateProfileCubit _createProfileCubit = Di().sl<CreateProfileCubit>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = UnderlineInputBorder(
      borderSide:
          BorderSide(color: widget.textColor ?? AppColors.white, width: 1),
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
        const SizedBox(height: 10),
        PhoneFormField(
          controller: _phoneController,
          showFlagInInput: false,
          countryCodeStyle: const TextStyle(
            fontSize: 16,
            color: AppColors.textColor,
            fontWeight: FontWeight.w400,
          ),
          // cursorHeight: 30,
          // validator: PhoneValidator.compose([
          //   PhoneValidator.required(
          //       errorText: "Please Enter Your Number", context),
          //   PhoneValidator.validMobile(
          //       errorText: "Make Sure You Enter The Correct PhoneNumber",
          //       context),
          // ]),
          countrySelectorNavigator: const CountrySelectorNavigator.page(),
          onChanged: (phoneNumber) {
            _createProfileCubit.phoneController.text =
                '+${phoneNumber.countryCode}${phoneNumber.nsn}';
            log(_createProfileCubit.phoneController.text);
          },
          enabled: true,
          isCountrySelectionEnabled: true,
          isCountryButtonPersistent: true,
          countryButtonStyle: const CountryButtonStyle(
              showDialCode: true,
              showIsoCode: true,
              showFlag: true,
              flagSize: 16),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textColor,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            constraints: const BoxConstraints(
              maxHeight: 40,
              minHeight: 40,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                log(_createProfileCubit.phoneController.text);
                _phoneController.value =
                    const PhoneNumber(isoCode: IsoCode.US, nsn: "");
              },
              icon: const Icon(
                Icons.cancel,
                size: 16,
                color: AppColors.textColor,
              ),
            ),
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            // errorMaxLines: 2,
            // errorStyle: const TextStyle(
            //   fontSize: 12,
            //   color: AppColors.redColor,
            //   fontWeight: FontWeight.w400,
            // ),
          ),
        ),
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
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     AppTextStyle(
    //       text: widget.feildName,
    //       fontSize: 14,
    //       fontWeight: FontWeight.w500,
    //       color: widget.textColor ?? AppColors.white,
    //     ),
    //     const SizedBox(height: 10),
    //     IntlPhoneField(
    //       cursorColor: widget.textColor ?? AppColors.white,
    //       onChanged: widget.onChanged,
    //       cursorRadius: const Radius.circular(30),
    //       style: const TextStyle(
    //         fontFamily: 'dmSans',
    //         color: AppColors.textColor,
    //         fontSize: 16,
    //         fontWeight: FontWeight.w400,
    //       ),
    //       controller: _phoneController,
    //       decoration: InputDecoration(
    //         constraints: const BoxConstraints(
    //           maxHeight: 40,
    //           minHeight: 40,
    //         ),
    //         suffixIcon: IconButton(
    //           onPressed: () {
    //             log(_createProfileCubit.phoneController.text);
    //             _phoneController.clear();
    //           },
    //           icon: const Icon(
    //             Icons.cancel,
    //             size: 16,
    //             color: AppColors.textColor,
    //           ),
    //         ),
    //         border: border,
    //         enabledBorder: border,
    //         focusedBorder: border,
    //         errorMaxLines: 2,
    //         errorStyle: const TextStyle(
    //           fontSize: 12,
    //           color: AppColors.redColor,
    //           fontWeight: FontWeight.w400,
    //         ),
    //         counterText: "",
    //         errorBorder: border,
    //       ),
    //       onSubmitted: widget.onSubmit,
    //     ),
    //     const SizedBox(height: 8),
    //     Align(
    //       alignment: Alignment.bottomRight,
    //       child: AppTextStyle(
    //         text: widget.errorText ?? '',
    //         fontSize: 12,
    //         color: widget.textColor ?? AppColors.white,
    //         fontWeight: FontWeight.w700,
    //         textAlign: TextAlign.end,
    //       ),
    //     ),
    //   ],
    // );
  }
}

final CreateProfileCubit _createProfileCubit = Di().sl<CreateProfileCubit>();
