import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/datasources/check_update_datasource.dart';
part '../states/check_app_update_state.dart';

class CheckAppUpdateCubit extends Cubit<CheckAppUpdateState> {
  final CheckUpdateDataSource _checkUpdateDataSource;
  CheckAppUpdateCubit(this._checkUpdateDataSource)
      : super(CheckAppUpdateInitial());

  Future<void> checkForUpdate() async {
    final isUpdateAvailable = await _checkUpdateDataSource.checkForUpdate();
    if (isUpdateAvailable) {
      _checkUpdateDataSource.update();
      emit(CheckAppUpdateAvailable());
    } else {
      emit(CheckAppUpdateNotAvailable());
    }
  }
}
