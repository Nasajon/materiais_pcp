enum OrigemOrdemEnum {
  servicos('servicos'),
  pedidos('pedidos'),
  pcp('pcp');

  final String code;

  const OrigemOrdemEnum(this.code);

  static OrigemOrdemEnum select(String code) => OrigemOrdemEnum.values.where((value) => value.code == code).first;
}
