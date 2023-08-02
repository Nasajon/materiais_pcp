enum ArtigoEnum {
  ARTIGO_FEMININO_INDEFINIDO('uma'),
  ARTIGO_MASCULINO_INDEFINIDO('um'),
  ARTIGO_MASCULINO_DEFINIDO('o'),
  ARTIGO_FEMININO_DEFINIDO('a');

  final String value;

  const ArtigoEnum(this.value);
}
