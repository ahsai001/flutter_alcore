import 'package:flutter_alcore/env/env.dart';

class ApiEndPoint {
  static String get apiKey => Env.apiKey;

  static String protocol = Env.apiProtocol;
  static String baseAuthorityStrings = Env.apiEndPoints;
  static List<String> baseAuthorityList = [];
  static int _baseAuthorityIndex = 0;

  static int nextAuthorityIndex() {
    _baseAuthorityIndex++;
    if (_baseAuthorityIndex >= baseAuthorityList.length) {
      _baseAuthorityIndex = 0;
    }
    return _baseAuthorityIndex;
  }

  static String get baseAuthority => baseAuthorityList[_baseAuthorityIndex];

  static String get apiPath => "/syshabapi/api/";
  static String get imagePath => "/syshabapi/assets/poto_profile/";

  static String get chekSerialNumber =>
      "$protocol://$baseAuthority${apiPath}CekSerial";
}
