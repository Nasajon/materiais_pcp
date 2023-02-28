import 'package:flutter/cupertino.dart';

abstract class CardWidget implements Widget {
  String get codigo;
  String get titulo;

  /// Título da sessão que o Widget pertence
  String get secao;

  /// Armazena frases ou palavras chaves que identifiquem o widget.
  ///
  /// Os textos serão utilizados na busca do launcher
  List<String> get descricoes;
  List<String> get funcoes;
  List<String> get permissoes;
  bool get exibirModoDemo;
  int get sistemaId;
  void onPressed();
}
