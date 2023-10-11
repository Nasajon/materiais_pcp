import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_produto_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';

ProdutoEntity prod = const ProdutoEntity(id: '2c921bfe-eba4-45fb-8ebe-e9c2f45b22c4', codigo: '01', nome: 'produto 01');
ProdutoEntity prodMaterial1 = const ProdutoEntity(id: 'cb53a49e-e36d-48d4-a9a4-3746fcaca78b', codigo: '01', nome: 'produto 01');
ProdutoEntity prodMaterial2 = const ProdutoEntity(id: 'e36a97b3-20df-40ea-9d22-fd1beb5f3278', codigo: '02', nome: 'produto 02');
ProdutoEntity prodMaterial3 = const ProdutoEntity(id: '924c269d-934c-4fae-a9f3-98b8a7b31f52', codigo: '03', nome: 'produto 03');

UnidadeEntity und = const UnidadeEntity(id: 'dd298620-ac7b-4821-85f0-2ad443674bdc', codigo: '01', decimais: 1, nome: 'Unidade 01');
UnidadeEntity undMaterial3 = const UnidadeEntity(id: 'ebb299fd-0b92-47ad-997e-21774e4cf96b', codigo: '01', decimais: 1, nome: 'Unidade 01');
UnidadeEntity undMaterial1 = const UnidadeEntity(id: 'dc9bdcd8-e29a-4ba8-b023-9c469a60ebd7', codigo: '02', decimais: 1, nome: 'Unidade 02');
UnidadeEntity undMaterial2 = const UnidadeEntity(id: '0696467b-fb83-44a7-9c67-8a75830062de', codigo: '03', decimais: 1, nome: 'Unidade 03');

List<FichaTecnicaMaterialAggregate> materiais = [
  FichaTecnicaMaterialAggregate(codigo: 1, produto: prodMaterial1, quantidade: DoubleVO(1), unidade: undMaterial1),
  FichaTecnicaMaterialAggregate(codigo: 2, produto: prodMaterial2, quantidade: DoubleVO(2), unidade: undMaterial2),
  FichaTecnicaMaterialAggregate(codigo: 3, produto: prodMaterial3, quantidade: DoubleVO(1), unidade: undMaterial3)
];

FichaTecnicaAggregate fichaTecnicaAtualizar = FichaTecnicaAggregate(
    codigo: TextVO('1'),
    descricao: TextVO('Ficha 01'),
    id: '6436dc27-76ef-4ee0-96ed-59ca5332ee3f',
    produto: prod,
    quantidade: DoubleVO(10.0),
    unidade: und,
    materiais: materiais);

// criar

FichaTecnicaAggregate fichaTecnicaCriar = FichaTecnicaAggregate(
    id: '',
    codigo: TextVO('1'),
    descricao: TextVO('Ficha 01'),
    produto: prod,
    quantidade: DoubleVO(10.0),
    unidade: und,
    materiais: materiais);
