import 'package:logger/logger.dart';

import '../resources/utils/logger.dart';

class BaseService {
  Logger? log;
  BaseService({String? title}) {
    log = getLogger(title ?? runtimeType.toString());
  }
}    
