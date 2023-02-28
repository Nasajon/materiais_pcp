import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:nsj_flutter_login/nsj_login.dart';

class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final profileStore = Modular.get<ProfileStore>();

    final token = await profileStore.tokenUpdated;

    options.headers['Authorization'] = 'Bearer ${token!.accessToken}';

    super.onRequest(options, handler);
  }
}
