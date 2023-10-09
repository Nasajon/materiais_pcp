import 'package:flutter_core/ana_core.dart';

class BaseUrl {
  const BaseUrl._();

  static String url() {
    switch (actualFlavorType) {
      case FlavorTypeEnum.dev:
        return 'http://192.168.1.104:5000/pcp/3411';
      case FlavorTypeEnum.stg:
        return 'http://localhost:5000/pcp/3411';
      case FlavorTypeEnum.prod:
        return 'http://localhost:5000';
    }
  }
}
