import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_material_mapper.dart';

void main() {
  test('Deve converter um Map em MaterialEntity', () async {
    final response = RemoteMaterialMapper.fromMapToMaterialEntity(map);
    expect(response, isA<MaterialEntity>());
    expect(response.fichaTecnicaId, 'aace47ba-c40e-49ae-9fa5-ccef6d5e0f6f');
  });
}

const map = <String, dynamic>{
  'ficha_tecnica_produto': 'aace47ba-c40e-49ae-9fa5-ccef6d5e0f6f',
  'quantidade': 10.0,
  'ficha_tecnica': '21f44ff6-bdcc-44dc-9c81-e9ebe7134dc6',
  'produto': {
    'produto': 'e6aafbcd-2ab7-4c2d-a2c6-0a2899318382',
    'codigo': '03',
    'nome': 'Leite',
    'unidade_padrao': '482cb303-0a84-46a6-a8e6-5345fd655c70'
  },
  'unidade': {
    'unidade': 'fca69f81-ddd6-47ff-ade7-c516488e90ad',
    'codigo': 'LT',
    'nome': 'Litro',
    'decimais': 2,
  }
};
