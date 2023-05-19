import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

class InternetConnectionReducer extends RxReducer {
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  InternetConnectionReducer({
    required this.connectionStore,
    required this.scaffoldController,
  }) {
    on(() => [connectionStore.connection], _showMessage);
  }

  void _showMessage() {
    scaffoldController.showMessage = !connectionStore.isOnline;
  }
}
