import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/enum/tipo_de_restricao_enum.dart';

class LocalTipoDeRestricaoMapper extends TypeAdapter<TipoDeRestricaoEnum> {
  @override
  int get typeId => 5;

  @override
  TipoDeRestricaoEnum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return TipoDeRestricaoEnum.selectTipoRestricao(fields[0]);
  }

  @override
  void write(BinaryWriter writer, TipoDeRestricaoEnum obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.value);
  }
}
