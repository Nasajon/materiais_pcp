import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:nsj_flutter_login/nsj_login.dart';

class EntidadesEmpresariaisInterceptor extends Interceptor {
  final bool estabelecimento;
  final bool tenant;
  final bool grupoEmpresarial;
  final bool empresa;

  EntidadesEmpresariaisInterceptor({
    this.estabelecimento = false,
    this.tenant = false,
    this.grupoEmpresarial = false,
    this.empresa = false,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final profileStore = Modular.get<ProfileStore>();

    if (options.method == ClientRequestMethods.POST.name || options.method == ClientRequestMethods.PUT.name) {
      _addBodyParameters(options, profileStore);
    } else {
      _addQueryParameters(options, profileStore);
    }

    super.onRequest(options, handler);
  }

  void _addBodyParameters(RequestOptions options, ProfileStore profileStore) {
    if (tenant) {
      options.data['tenant'] = profileStore.tenantSelecionado?.id;
    }

    if (grupoEmpresarial) {
      options.data['grupoempresarial'] = profileStore.grupoEmpresarialSelecionado?.id;
    }

    if (empresa) {
      options.data['empresa'] = profileStore.empresaSelecionada?.id;
    }

    if (estabelecimento) {
      options.data['estabelecimento'] = profileStore.estabelecimentoSelecionado?.id;
    }
  }

  void _addQueryParameters(RequestOptions options, ProfileStore profileStore) {
    if (tenant) {
      options.queryParameters['tenant'] = profileStore.tenantSelecionado?.id;
    }

    if (grupoEmpresarial) {
      options.queryParameters['grupoempresarial'] = profileStore.grupoEmpresarialSelecionado?.id;
    }

    if (empresa) {
      options.queryParameters['empresa'] = profileStore.empresaSelecionada?.id;
    }

    if (estabelecimento) {
      options.queryParameters['estabelecimento'] = profileStore.estabelecimentoSelecionado?.id;
    }
  }
}
