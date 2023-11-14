import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

class InternetButtonIconWidget extends StatelessWidget {
  final InternetConnectionStore connectionStore;
  final bool error;
  final VoidCallback? onTap;

  const InternetButtonIconWidget({
    Key? key,
    required this.connectionStore,
    this.error = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [connectionStore.connection, connectionStore.synchronization]);

    Widget icon = const SizedBox.shrink();

    if (error) {
      icon = Icon(
        Icons.error,
        color: colorTheme?.warningText,
      );
    } else if (connectionStore.synchronization) {
      icon = Icon(
        Icons.cloud_sync_outlined,
        color: colorTheme?.primary,
      );
    } else if (connectionStore.isOnline) {
      icon = Icon(
        Icons.cloud_done_outlined,
        color: colorTheme?.success,
      );
    } else {
      icon = Icon(
        Icons.cloud_off,
        color: colorTheme?.icons,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: IconButton(
        onPressed: onTap,
        icon: icon,
        splashRadius: 20,
      ),
    );
  }
}
