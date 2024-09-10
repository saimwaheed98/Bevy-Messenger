import 'package:dio/dio.dart';

import '../utils/app_links.dart'; 

BaseOptions baseOptions() {
  return BaseOptions(
    baseUrl: AppLinks.onesignalBaseUrl,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Basic ${AppLinks.oneSignalRestApiKey}',
    },
  );
}
