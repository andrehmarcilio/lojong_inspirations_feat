import '../../utils/service_locator/service_locator.dart';
import '../../utils/session_manager.dart';

abstract class ServerHost {
  static const baseUrl = ' https://applojong.com/api/';

  static Map<String, dynamic> get headers {
    final token = serviceLocator.get<SessionManager>().token;

    return {'Authorization': 'Bearer $token'};
  }
}
