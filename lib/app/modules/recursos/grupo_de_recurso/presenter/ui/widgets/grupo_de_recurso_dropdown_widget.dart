import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';

import '../../stores/grupo_de_recurso_list_store.dart';

class GrupoDeRecursoDropdownWidget extends StatefulWidget {
  final String? label;
  final void Function(GrupoDeRecurso value) onSelected;
  final ValueNotifier<DropdownItem<GrupoDeRecurso?>?> listenable;
  final bool isRequiredField;
  final bool isEnabled;
  final String? errorMessage;

  const GrupoDeRecursoDropdownWidget({
    super.key,
    this.label,
    required this.onSelected,
    required this.listenable,
    this.isRequiredField = false,
    this.isEnabled = true,
    this.errorMessage,
  });

  @override
  State<GrupoDeRecursoDropdownWidget> createState() => _GrupoDeRecursoDropdownWidgetState();
}

class _GrupoDeRecursoDropdownWidgetState extends State<GrupoDeRecursoDropdownWidget> {
  final _store = Modular.get<GrupoDeRecursoListStore>();

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<GrupoDeRecursoListStore, List<GrupoDeRecurso>>(
      store: _store,
      onLoading: (context) => DropdownLoadWidget(label: context.l10n.materiaisPcpGrupoDeRecurso),
      onState: (context, state) {
        if (state.isEmpty) {
          return DropdownLoadWidget(label: context.l10n.materiaisPcpGrupoDeRecurso);
        }

        return CustomDropdownWidget(
          label: widget.label ?? context.l10n.materiaisPcpGrupoDeRecurso,
          errorMessage: widget.errorMessage ?? context.l10n.materiaisPcpEsteCampoPrecisaEstarPreenchido,
          valueListenable: widget.listenable,
          isRequiredField: widget.isRequiredField,
          isEnabled: widget.isEnabled,
          onSelected: (value) => widget.onSelected(value!),
          items: _store.state.map((grupoDeRecurso) => DropdownItem(value: grupoDeRecurso, label: grupoDeRecurso.descricao)).toList(),
        );
      },
    );
  }
}
