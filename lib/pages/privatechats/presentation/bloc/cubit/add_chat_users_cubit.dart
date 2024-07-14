import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../state/add_chat_users_state.dart';

class AddChatUsersCubit extends Cubit<AddChatUsersState> {
  AddChatUsersCubit() : super(AddChatUsersInitial());

  Future<void> addChatUser(UserModel userData) async {
    emit(AddChatUsersLoading());
    await AuthDataSource.addChatUsers(userData);
    emit(AddChatUsersSuccess());
  }
}
