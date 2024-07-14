part of '../cubit/validate_text_fields_cubit.dart';

sealed class ValidateTextFieldsState extends Equatable {
  const ValidateTextFieldsState();

  @override
  List<Object> get props => [];
}

final class ValidateTextFieldsInitial extends ValidateTextFieldsState {}

final class ValidatingTextFields extends ValidateTextFieldsState {}

final class ValidatedTextFields extends ValidateTextFieldsState {}

final class ValidatingPasswordTextFields extends ValidateTextFieldsState {}

final class ValidatedPasswordTextFields extends ValidateTextFieldsState {}

final class ValidatingPhoneNumberTextFields extends ValidateTextFieldsState {}

final class ValidatedPhoneNumberTextFields extends ValidateTextFieldsState {}
