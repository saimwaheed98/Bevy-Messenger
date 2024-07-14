import 'package:connectivity_plus/connectivity_plus.dart';

abstract class InternetConnectionDataSource {
  Future<bool> checkInternetConnection();
}

class InternetConnectionDataSourceImpl implements InternetConnectionDataSource {
  InternetConnectionDataSourceImpl();

  @override
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }
}
