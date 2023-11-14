import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/enum/tipo_de_recurso_enum.dart';

class LocalTipoDeRecursoMapper extends TypeAdapter<TipoDeRecursoEnum> {
  @override
  int get typeId => 3;

  @override
  TipoDeRecursoEnum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return TipoDeRecursoEnum.selecTipoDeRecurso(fields[0]);
  }

  @override
  void write(BinaryWriter writer, TipoDeRecursoEnum obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.value);
  }
}
