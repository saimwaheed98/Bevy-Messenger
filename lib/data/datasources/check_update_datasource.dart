import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

abstract class CheckUpdateDataSource {
  Future<bool> checkForUpdate();
  void update();
}

class CheckUpdateDataSourceImpl implements CheckUpdateDataSource {
  CheckUpdateDataSourceImpl();

  @override
  Future<bool> checkForUpdate() async {
    bool isUpdateAvailable = false;
    debugPrint('checking for Update');
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        debugPrint('update available');
        return isUpdateAvailable = true;
      }
    }).catchError((e) {
      debugPrint(e.toString());
      return isUpdateAvailable = false;
    });
    debugPrint('isUpdateAvailable: $isUpdateAvailable');
    return isUpdateAvailable;
  }

  @override
  void update() async {
    debugPrint('Updating');
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
      debugPrint(e.toString());
    });
  }
}
