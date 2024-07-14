import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part '../state/other_user_data_state.dart';

class OtherUserDataCubit extends Cubit<OtherUserDataState> {
  OtherUserDataCubit() : super(OtherUserDataInitial());

  UserModel? userData = UserModel();

  void getUserData(UserModel userModel) {
    emit(OtherUserDataLoading());
    userData = userModel;
    emit(OtherUserDataLoaded());
  }
}
