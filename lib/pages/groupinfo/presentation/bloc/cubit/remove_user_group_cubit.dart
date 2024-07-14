import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part '../state/remove_user_group_state.dart';

class RemoveUserGroupCubit extends Cubit<RemoveUserGroupState> {
  RemoveUserGroupCubit() : super(RemoveUserGroupInitial());

  List<String> user = [];

  removeUser(String user){
    emit(RemovingUserLoading());
    if(this.user.contains(user)){
      this.user.remove(user);
      emit(RemovedUserLoaded());
    }else{
      this.user.add(user);
      emit(RemovedUserLoaded());
    }
  }

  // empty the list
  emptyList(){
    emit(RemovingUserLoading());
    user = [];
    emit(RemovedUserLoaded());
  }
}
