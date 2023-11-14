import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:nsj_flutter_login/nsj_login.dart';

class EntidadesEmpresariaisInterceptor extends Interceptor {
  final bool estabelecimento;
  final bool tenant;
  final bool grupoEmpresarial;
  final bool empresa;

  EntidadesEmpresariaisInterceptor({
    this.estabelecimento = true,
    this.tenant = true,
    this.grupoEmpresarial = true,
    this.empresa = true,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final profileStore = Modular.get<ProfileStore>();

    if (options.method == ClientRequestMethods.POST.name || options.method == ClientRequestMethods.PUT.name) {
      _addBodyParameters(options, profileStore);
    } else {
      _addQueryParameters(options, profileStore);
    }
    // _addBodyParameters(options, profileStore);
    // _addQueryParameters(options, profileStore);

    super.onRequest(options, handler);
  }

  // TODO: Apagar esse comentario
  void _addBodyParameters(RequestOptions options, ProfileStore profileStore) {
    if (tenant) {
      options.data['tenant'] = 47;
    }

    if (grupoEmpresarial) {
      options.data['grupo_empresarial'] = '95cd450c-30c5-4172-af2b-cdece39073bf';
    }

    if (empresa) {
      options.data['empresa'] = '431bc005-9894-4c86-9dcd-7d1da9e2d006';
    }

    if (estabelecimento) {
      options.data['estabelecimento'] = '39836516-7240-4fe5-847b-d5ee0f57252d';
    }
  }

  // void _addBodyParameters(RequestOptions options, ProfileStore profileStore) {
  //   if (tenant) {
  //     options.data['tenant'] = profileStore.tenantSelecionado?.id;
  //   }

  //   if (grupoEmpresarial) {
  //     options.data['grupo_empresarial'] = profileStore.grupoEmpresarialSelecionado?.id;
  //   }

  //   if (empresa) {
  //     options.data['empresa'] = profileStore.empresaSelecionada?.id;
  //   }

  //   if (estabelecimento) {
  //     options.data['estabelecimento'] = profileStore.estabelecimentoSelecionado?.id;
  //   }
  // }
  // TODO: Apagar esse comentario
  void _addQueryParameters(RequestOptions options, ProfileStore profileStore) {
    if (tenant) {
      options.queryParameters['tenant'] = 47;
    }

    if (grupoEmpresarial) {
      options.queryParameters['grupo_empresarial'] = '95cd450c-30c5-4172-af2b-cdece39073bf';
    }

    if (empresa) {
      options.queryParameters['empresa'] = '431bc005-9894-4c86-9dcd-7d1da9e2d006';
    }

    if (estabelecimento) {
      options.queryParameters['estabelecimento'] = '39836516-7240-4fe5-847b-d5ee0f57252d';
    }
  }

  // void _addQueryParameters(RequestOptions options, ProfileStore profileStore) {
  //   if (tenant) {
  //     options.queryParameters['tenant'] = profileStore.tenantSelecionado?.id;
  //   }

  //   if (grupoEmpresarial) {
  //     options.queryParameters['grupo_empresarial'] = profileStore.grupoEmpresarialSelecionado?.id;
  //   }

  //   if (empresa) {
  //     options.queryParameters['empresa'] = profileStore.empresaSelecionada?.id;
  //   }

  //   if (estabelecimento) {
  //     options.queryParameters['estabelecimento'] = profileStore.estabelecimentoSelecionado?.id;
  //   }
  // }
}
