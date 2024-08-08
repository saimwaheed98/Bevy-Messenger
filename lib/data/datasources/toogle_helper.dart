import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:bevy_messenger/utils/app_links.dart';

class ToggleHelper {
  static final StreamController<bool> _controller =
      StreamController<bool>.broadcast();

  static Stream<bool> get toggleStream => _controller.stream;

  static Future<void> _fetchToggle() async {
    Uri url = Uri.parse(AppLinks.toogleValue);
    try {
      http.Response response = await http.patch(url);
      if (response.statusCode == 200) {
        log(response.body);
        var json = jsonDecode(response.body);
        if (json["value"] == true) {
          log(json["value"]);
          _controller.sink.add(true);
        } else {
          _controller.sink.add(false);
        }
      } else {
        _controller.sink.add(false);
      }
    } catch (e) {
      _controller.sink.addError(e);
    }
  }

  static void startFetching() {
    Timer.periodic(const Duration(seconds: 5), (Timer t) => _fetchToggle());
  }

  static void stopFetching() {
    _controller.close();
  }
}
