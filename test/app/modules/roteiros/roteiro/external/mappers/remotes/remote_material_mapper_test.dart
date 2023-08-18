import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_material_mapper.dart';

void main() {
  testWidgets('Deve converter um Map em MaterialEntity', (tester) async {
    final response = RemoteMaterialMapper.fromMapToMaterialEntity(map);
    expect(response, isA<MaterialEntity>());
    expect(response.fichaTecnicaId, '74dcd3fa-036d-4b62-b757-fe4888d354ed');
  });
}

const map = <String, dynamic>{
  'ficha_tecnica_produto': '74dcd3fa-036d-4b62-b757-fe4888d354ed',
  'quantidade': 2.0,
  'produto': '358c2657-00e1-48dc-8beb-5175d691bc30',
  'unidade': 'fbf7ab8a-11d5-4170-99c6-ade99311b4ed',
};
