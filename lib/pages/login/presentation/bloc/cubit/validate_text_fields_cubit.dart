import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/di/service_locator_imports.dart';
import '../../../../signup/presentation/bloc/cubit/create_profile_cubit.dart';
part '../state/validate_text_fields_state.dart';

class ValidateTextFieldsCubit extends Cubit<ValidateTextFieldsState> {
  ValidateTextFieldsCubit() : super(ValidateTextFieldsInitial());

  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isPhoneNumberValid = true;

  // check if the email is valid
  void validateEmailTextFields(String query) {
    emit(ValidatingTextFields());
    if (query.contains('@') && query.contains('.')) {
      isEmailValid = true;
      emit(ValidatedTextFields());
    } else {
      isEmailValid = false;
      emit(ValidateTextFieldsInitial());
    }
  }


  // check if the password is equal to the confirm password
  void checkIsPasswordMatch() {
    final CreateProfileCubit createProfileCubit = Di().sl<CreateProfileCubit>();
    if (createProfileCubit.passwordController.text.isNotEmpty) {
      emit(ValidatingPasswordTextFields());
      if (createProfileCubit.passwordController.text ==
          createProfileCubit.confirmPasswordController.text) {
        isPasswordValid = true;
        emit(ValidatedPasswordTextFields());
      } else {
        isPasswordValid = false;
        emit(ValidateTextFieldsInitial());
      }
    }
  }

  // check if the phone number is in the correct format and in the format of international
  void validatePhoneNumberTextFields(String query) {
    emit(ValidatingPhoneNumberTextFields());
    if (query.startsWith('+')) {
      isPhoneNumberValid = true;
      emit(ValidatedPhoneNumberTextFields());
    } else {
      isPhoneNumberValid = false;
      emit(ValidateTextFieldsInitial());
    }
  }
}
