import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import '../../domain/entities/tipo_de_recurso.dart';
import '../stores/tipo_de_recurso_list_store.dart';

class TipoDeRecursoDropdownWidget extends StatefulWidget {
  final String? label;
  final void Function(TipoDeRecurso value) onSelected;
  final ValueNotifier<DropdownItem<TipoDeRecurso?>?> listenable;
  final bool isRequiredField;
  final bool isEnabled;
  final String? errorMessage;

  const TipoDeRecursoDropdownWidget({
    super.key,
    this.label,
    required this.onSelected,
    required this.listenable,
    this.isRequiredField = false,
    this.isEnabled = true,
    this.errorMessage,
  });

  @override
  State<TipoDeRecursoDropdownWidget> createState() =>
      _TipoDeRecursoDropdownWidgetState();
}

class _TipoDeRecursoDropdownWidgetState
    extends State<TipoDeRecursoDropdownWidget> {
  final _store = Modular.get<TipoDeRecursoListStore>();

  @override
  Widget build(BuildContext context) {
    return CustomDropdownWidget(
      label: widget.label ?? context.l10n.materiaisPcpTipoDeRecursoLabel,
      valueListenable: widget.listenable,
      isRequiredField: widget.isRequiredField,
      isEnabled: widget.isEnabled,
      onSelected: (value) => widget.onSelected(value!),
      errorMessage: widget.errorMessage ??
          context.l10n.materiaisPcpEsteCampoPrecisaEstarPreenchido,
      items: _store.state
          .map((tipoDeRecurso) =>
              DropdownItem(value: tipoDeRecurso, label: tipoDeRecurso.name))
          .toList(),
    );
  }
}
