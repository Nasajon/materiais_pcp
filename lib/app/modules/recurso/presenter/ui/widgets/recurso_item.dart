import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import '../../../domain/entities/recurso.dart';

class RecursoItem extends StatelessWidget {
  final Recurso recurso;
  final VoidCallback onTap;

  const RecursoItem({
    Key? key,
    required this.recurso,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
          title: Text(
            recurso.codigo,
            style: AnaTextStyles.boldGrey14Px,
          ),
          tileColor: Colors.white,
          subtitle: Text(
              '${context.l10n.materiaisPcpTipoDeRecurso}: ${recurso.tipo?.name}',
              style: AnaTextStyles.lightGrey14Px.copyWith(fontSize: 12)),
          trailing: const FaIcon(FontAwesomeIcons.angleRight, size: 13),
          shape: const Border(bottom: BorderSide(color: Color(0xFFDADADA))),
          onTap: onTap),
    );
  }
}
