
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import '../../data/datasources/internet_connection_datasource.dart';
part '../states/internet_con_state.dart';

class InternetConCubit extends Cubit<InternetConState> {
  final InternetConnectionDataSource _internetConnectionDataSource;
  InternetConCubit(this._internetConnectionDataSource)
      : super(InternetConInitial());

  bool isConnected = false;

  Future<bool> checkInternetConnection() async {
    final inInternetConnected =
        await _internetConnectionDataSource.checkInternetConnection();
    if (inInternetConnected) {
      isConnected = true;
      emit(InternetConConnected());
      return true;
    } else {
      isConnected = false;
      emit(InternetConDisconnected());
      return false;
    }
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
    } else if (connectivityResult == ConnectivityResult.wifi) {
    } else {
      // No internet connection
    }
  }

  void listenToConnectivityChanges() {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    Connectivity().onConnectivityChanged.listen((event) {
      for (var i in event) {
        if (i == ConnectivityResult.none) {
          AuthDataSource.firestore
              .collection("users")
              .doc(authCubit.userData.id)
              .update({
            "userInternetState": false,
          });
        } else {
          AuthDataSource.firestore
              .collection("users")
              .doc(authCubit.userData.id)
              .update({
            "userInternetState": true,
          });
        }
      }
    });
  }
}
