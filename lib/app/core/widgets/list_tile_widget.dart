// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ListTileWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    this.trailing,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(
          title,
          style: AnaTextStyles.boldGrey14Px,
        ),
        tileColor: Colors.white,
        subtitle: Text(subtitle, style: AnaTextStyles.lightGrey14Px.copyWith(fontSize: 12)),
        trailing: trailing,
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
