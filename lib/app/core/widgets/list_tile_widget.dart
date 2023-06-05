import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const ListTileWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(
          title,
          style: AnaTextStyles.boldGrey14Px, // TODO: Pegar o texto do tema
        ),
        tileColor: Colors.white,
        subtitle: Text(subtitle, style: AnaTextStyles.lightGrey14Px.copyWith(fontSize: 12)),
        trailing: const Icon(Icons.keyboard_arrow_right_rounded, size: 13),
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xFFDADADA),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
