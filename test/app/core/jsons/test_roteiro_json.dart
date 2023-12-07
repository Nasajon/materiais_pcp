const roteiroJson = {
  'roteiro': 'bf333857-7af2-45b1-b6dc-0a6a11be8fba',
  'descricao': 'Roteiro bolo de chocolate',
  'codigo': '1',
  'grupo_empresarial': '95cd450c-30c5-4172-af2b-cdece39073bf',
  'estabelecimento': '39836516-7240-4fe5-847b-d5ee0f57252d',
  'empresa': '431bc005-9894-4c86-9dcd-7d1da9e2d006',
  'tenant': 47,
  'operacoes': [
    {
      'operacao': '45f238ef-2a8b-4e30-8ab4-cf03e68c7ae8',
      'codigo': '10',
      'nome': 'Operacão 1 - Bater massa',
      'roteiro': 'bf333857-7af2-45b1-b6dc-0a6a11be8fba',
      'ordem': 1,
      'razao_conversao': 1.0,
      'medicao_tempo': 'por_lote',
      'preparacao': '00:03:00',
      'execucao': '00:03:00',
      'grupos_recursos': [
        {
          'grupo_recurso_operacao': 'd41f3167-e682-4881-aa78-bf97cff0b1f0',
          'tempo_de_preparacao': '00:10:00',
          'tempo_de_processamento': '00:10:00',
          'quantidade_minima': 1.0,
          'quantidade_maxima': 2.0,
          'quantidade_total': 5.0,
          'recursos': [
            {
              'recurso_operacao': 'd7a86214-1bcb-4e0c-9d64-1143315526c5',
              'tempo_de_preparacao': '00:10:00',
              'tempo_de_processamento': '00:10:00',
              'quantidade_minima': 1.0,
              'quantidade_maxima': 2.0,
              'quantidade_total': 5.0,
              'grupo_recurso_operacao': 'd41f3167-e682-4881-aa78-bf97cff0b1f0',
              'grupos_restricoes': [],
              'recurso': {'recurso': '005578f8-36a5-4241-b814-5bec4b9879ca', 'codigo': '3', 'nome': 'Batedeira 3'}
            },
            {
              'recurso_operacao': 'f05f1016-84d5-49ed-95ac-a2dc8fc7a1de',
              'tempo_de_preparacao': '00:10:00',
              'tempo_de_processamento': '00:10:00',
              'quantidade_minima': 1.0,
              'quantidade_maxima': 2.0,
              'quantidade_total': 5.0,
              'grupo_recurso_operacao': 'd41f3167-e682-4881-aa78-bf97cff0b1f0',
              'grupos_restricoes': [],
              'recurso': {'recurso': 'c67de3b6-fff1-4d63-ac22-ad37940eab86', 'codigo': '2', 'nome': 'Batedeira 2'}
            },
            {
              'recurso_operacao': '5ba8ff37-c07d-4f8c-90fa-425c52be53a0',
              'tempo_de_preparacao': '00:10:00',
              'tempo_de_processamento': '00:10:00',
              'quantidade_minima': 1.0,
              'quantidade_maxima': 2.0,
              'quantidade_total': 5.0,
              'grupo_recurso_operacao': 'd41f3167-e682-4881-aa78-bf97cff0b1f0',
              'grupos_restricoes': [],
              'recurso': {'recurso': 'ca19b0a6-bc76-4fd4-be31-d2778c560f90', 'codigo': '1', 'nome': 'Batedeira 1'}
            }
          ],
          'grupo_de_recurso': {
            'grupo_de_recurso': 'c6888c62-91f3-45f0-b63b-8d0687b6807b',
            'codigo': '2',
            'nome': 'Batedeiras',
            'tipo': 'equipamento'
          }
        }
      ],
      'produtos': [
        {
          'produto_operacao': 'aa577044-a301-4499-996b-2a835e06a6c7',
          'operacao': '45f238ef-2a8b-4e30-8ab4-cf03e68c7ae8',
          'quantidade': 4.0,
          'tipo_produto': 'insumo',
          'tipo_produto_operacao': 'material_ficha_tecnica',
          'ficha_tecnica_produto': 'b8188d4a-ef81-4dec-8d23-380dd3c1c5ed',
          'unidade': {'unidade': '45448dce-c4c1-4106-84fb-4c41fe476d8a', 'codigo': 'UN', 'nome': 'Unidade', 'decimais': 0},
          'produto': {
            'produto': '21d0d1fb-40f1-4c91-9581-7a40644bad9b',
            'codigo': '02',
            'nome': 'Ovo',
            'tenant': 47,
            'estabelecimento': '39836516-7240-4fe5-847b-d5ee0f57252d',
            'grupo_empresarial': '95cd450c-30c5-4172-af2b-cdece39073bf',
            'empresa': '431bc005-9894-4c86-9dcd-7d1da9e2d006'
          }
        },
        {
          'produto_operacao': '1a0d9895-2207-4202-927a-19af2cd10d33',
          'operacao': '45f238ef-2a8b-4e30-8ab4-cf03e68c7ae8',
          'quantidade': 0.05,
          'tipo_produto': 'insumo',
          'tipo_produto_operacao': 'material_ficha_tecnica',
          'ficha_tecnica_produto': '6f668fe7-184a-49b2-bc7f-6c99f8979fa0',
          'unidade': {'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70', 'codigo': 'KG', 'nome': 'Kilo', 'decimais': 2},
          'produto': {
            'produto': '59331cb7-cd94-4ff6-ae12-d69db0265802',
            'codigo': '05',
            'nome': 'Açúcar',
            'tenant': 47,
            'estabelecimento': '39836516-7240-4fe5-847b-d5ee0f57252d',
            'grupo_empresarial': '95cd450c-30c5-4172-af2b-cdece39073bf',
            'empresa': '431bc005-9894-4c86-9dcd-7d1da9e2d006'
          }
        },
        {
          'produto_operacao': '07b8fda3-b130-4597-95cd-70b15e536875',
          'operacao': '45f238ef-2a8b-4e30-8ab4-cf03e68c7ae8',
          'quantidade': 0.1,
          'tipo_produto': 'insumo',
          'tipo_produto_operacao': 'material_ficha_tecnica',
          'ficha_tecnica_produto': 'f0bf9a48-84dd-4dd6-8681-91b52457c65e',
          'unidade': {'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70', 'codigo': 'KG', 'nome': 'Kilo', 'decimais': 2},
          'produto': {
            'produto': '6b10e6e1-802d-4c02-9ed6-692907fb33a8',
            'codigo': '08',
            'nome': 'Fermento',
            'tenant': 47,
            'estabelecimento': '39836516-7240-4fe5-847b-d5ee0f57252d',
            'grupo_empresarial': '95cd450c-30c5-4172-af2b-cdece39073bf',
            'empresa': '431bc005-9894-4c86-9dcd-7d1da9e2d006'
          }
        },
        {
          'produto_operacao': 'e0751699-4704-421b-bc25-c0880be18817',
          'operacao': '45f238ef-2a8b-4e30-8ab4-cf03e68c7ae8',
          'quantidade': 0.15,
          'tipo_produto': 'insumo',
          'tipo_produto_operacao': 'material_ficha_tecnica',
          'ficha_tecnica_produto': 'ff33dbbb-73ef-4a0b-9d7c-b432d0e6d84d',
          'unidade': {'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70', 'codigo': 'KG', 'nome': 'Kilo', 'decimais': 2},
          'produto': {
            'produto': 'a2579099-1caf-4ba9-ba99-c8747c162dc9',
            'codigo': '04',
            'nome': 'Manteiga',
            'tenant': 47,
            'estabelecimento': '39836516-7240-4fe5-847b-d5ee0f57252d',
            'grupo_empresarial': '95cd450c-30c5-4172-af2b-cdece39073bf',
            'empresa': '431bc005-9894-4c86-9dcd-7d1da9e2d006'
          }
        },
        {
          'produto_operacao': 'f30c2fa9-f0e3-477f-a64c-9b8097a94309',
          'operacao': '45f238ef-2a8b-4e30-8ab4-cf03e68c7ae8',
          'quantidade': 0.95,
          'tipo_produto': 'insumo',
          'tipo_produto_operacao': 'material_ficha_tecnica',
          'ficha_tecnica_produto': '96256242-13c5-4e4d-b6f1-7c230e359405',
          'unidade': {'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70', 'codigo': 'KG', 'nome': 'Kilo', 'decimais': 2},
          'produto': {
            'produto': 'a33bd64d-d9a6-4134-86ab-049e69d099f6',
            'codigo': '06',
            'nome': 'Farinha',
            'tenant': 47,
            'estabelecimento': '39836516-7240-4fe5-847b-d5ee0f57252d',
            'grupo_empresarial': '95cd450c-30c5-4172-af2b-cdece39073bf',
            'empresa': '431bc005-9894-4c86-9dcd-7d1da9e2d006'
          }
        },
        {
          'produto_operacao': 'b2d21a23-b8b5-42a6-8675-6b9b392e5993',
          'operacao': '45f238ef-2a8b-4e30-8ab4-cf03e68c7ae8',
          'quantidade': 1.0,
          'tipo_produto': 'insumo',
          'tipo_produto_operacao': 'material_ficha_tecnica',
          'ficha_tecnica_produto': '4e1ed13e-9d4f-4eaa-a08c-f9c5b74b5b3b',
          'unidade': {'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70', 'codigo': 'KG', 'nome': 'Kilo', 'decimais': 2},
          'produto': {
            'produto': 'e6aafbcd-2ab7-4c2d-a2c6-0a2899318382',
            'codigo': '03',
            'nome': 'Leite',
            'tenant': 47,
            'estabelecimento': '39836516-7240-4fe5-847b-d5ee0f57252d',
            'grupo_empresarial': '95cd450c-30c5-4172-af2b-cdece39073bf',
            'empresa': '431bc005-9894-4c86-9dcd-7d1da9e2d006'
          }
        }
      ],
      'centro_de_trabalho': {'centro_de_trabalho': '8500df0f-73fa-4b57-9192-6b65402ad6ff', 'codigo': '07', 'nome': 'centro de trabalho 07'}
    },
    {
      'operacao': '852ac311-8205-4bd1-8772-4834dc503c6c',
      'codigo': '20',
      'nome': 'Operação 2 - Colocar no forno',
      'roteiro': 'bf333857-7af2-45b1-b6dc-0a6a11be8fba',
      'ordem': 2,
      'razao_conversao': 1.0,
      'medicao_tempo': 'por_lote',
      'preparacao': '00:03:00',
      'execucao': '00:03:00',
      'grupos_recursos': [
        {
          'grupo_recurso_operacao': '21778eba-876e-4eff-9ca4-47bae0d7792c',
          'tempo_de_preparacao': '00:10:00',
          'tempo_de_processamento': '01:30:00',
          'quantidade_minima': 1.0,
          'quantidade_maxima': 5.0,
          'quantidade_total': 20.0,
          'recursos': [
            {
              'recurso_operacao': 'bf050ca8-d223-4425-bfb1-ee4dcec28c06',
              'tempo_de_preparacao': '00:10:00',
              'tempo_de_processamento': '01:30:00',
              'quantidade_minima': 1.0,
              'quantidade_maxima': 5.0,
              'quantidade_total': 20.0,
              'grupo_recurso_operacao': '21778eba-876e-4eff-9ca4-47bae0d7792c',
              'grupos_restricoes': [
                {
                  'grupo_restricao_operacao': '1632ad86-340f-4ab0-9c42-a8eae55b784f',
                  'recurso_operacao': 'bf050ca8-d223-4425-bfb1-ee4dcec28c06',
                  'capacidade': 0.01,
                  'quantidade_necessaria': 0.01,
                  'momento_necessidade': 'tempo_antes_do_inicio_da_execucao',
                  'tempo_execucao': '00:20:00',
                  'restricoes': [
                    {
                      'restricao_recurso_operacao': '40403da1-a8c4-43b1-89f8-f680979b5a89',
                      'grupo_restricao_operacao': '1632ad86-340f-4ab0-9c42-a8eae55b784f',
                      'capacidade': 0.01,
                      'tempo_execucao': '00:20:00',
                      'restricao': {'restricao': '692a4ec4-6538-40fb-a7da-63fcd2e58e7a', 'codigo': '05', 'nome': 'teste 5'}
                    }
                  ],
                  'grupo_de_restricao': {
                    'grupo_de_restricao': '25aae237-4617-49a4-9235-8410984dc2d2',
                    'codigo': '01',
                    'nome': 'grupo 01',
                    'tipo': 'mao_de_obra'
                  }
                }
              ],
              'recurso': {'recurso': 'b68eedab-4cc2-47d5-8390-85518a34f3bd', 'codigo': '5', 'nome': 'Forno 2'}
            },
            {
              'recurso_operacao': '279da6e1-2225-4047-998b-89e46b073939',
              'tempo_de_preparacao': '00:10:00',
              'tempo_de_processamento': '01:30:00',
              'quantidade_minima': 1.0,
              'quantidade_maxima': 5.0,
              'quantidade_total': 20.0,
              'grupo_recurso_operacao': '21778eba-876e-4eff-9ca4-47bae0d7792c',
              'grupos_restricoes': [],
              'recurso': {'recurso': 'd3463218-1658-401f-a244-7a468d06c59f', 'codigo': '4', 'nome': 'Forno 1'}
            }
          ],
          'grupo_de_recurso': {
            'grupo_de_recurso': 'f499a879-3d69-4292-9f41-1e8ba67ebe59',
            'codigo': '3',
            'nome': 'Forno',
            'tipo': 'equipamento'
          }
        }
      ],
      'produtos': [
        {
          'produto_operacao': 'db44dc04-7ca8-4dfc-89ec-fc5cb2cdba63',
          'operacao': '852ac311-8205-4bd1-8772-4834dc503c6c',
          'quantidade': 2.0,
          'tipo_produto': 'insumo',
          'tipo_produto_operacao': 'material_ficha_tecnica',
          'ficha_tecnica_produto': 'b8188d4a-ef81-4dec-8d23-380dd3c1c5ed',
          'unidade': {'unidade': '45448dce-c4c1-4106-84fb-4c41fe476d8a', 'codigo': 'UN', 'nome': 'Unidade', 'decimais': 0},
          'produto': {
            'produto': '21d0d1fb-40f1-4c91-9581-7a40644bad9b',
            'codigo': '02',
            'nome': 'Ovo',
            'tenant': 47,
            'estabelecimento': '39836516-7240-4fe5-847b-d5ee0f57252d',
            'grupo_empresarial': '95cd450c-30c5-4172-af2b-cdece39073bf',
            'empresa': '431bc005-9894-4c86-9dcd-7d1da9e2d006'
          }
        },
        {
          'produto_operacao': '18f1882d-786e-4f03-a7e1-61ddf24f238c',
          'operacao': '852ac311-8205-4bd1-8772-4834dc503c6c',
          'quantidade': 0.0,
          'tipo_produto': 'insumo',
          'tipo_produto_operacao': 'material_ficha_tecnica',
          'ficha_tecnica_produto': '6f668fe7-184a-49b2-bc7f-6c99f8979fa0',
          'unidade': {'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70', 'codigo': 'KG', 'nome': 'Kilo', 'decimais': 2},
          'produto': {
            'produto': '59331cb7-cd94-4ff6-ae12-d69db0265802',
            'codigo': '05',
            'nome': 'Açúcar',
            'tenant': 47,
            'estabelecimento': '39836516-7240-4fe5-847b-d5ee0f57252d',
            'grupo_empresarial': '95cd450c-30c5-4172-af2b-cdece39073bf',
            'empresa': '431bc005-9894-4c86-9dcd-7d1da9e2d006'
          }
        },
        {
          'produto_operacao': 'df74e130-9c44-46af-a4b1-ff842af3944f',
          'operacao': '852ac311-8205-4bd1-8772-4834dc503c6c',
          'quantidade': 0.0,
          'tipo_produto': 'insumo',
          'tipo_produto_operacao': 'material_ficha_tecnica',
          'ficha_tecnica_produto': 'f0bf9a48-84dd-4dd6-8681-91b52457c65e',
          'unidade': {'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70', 'codigo': 'KG', 'nome': 'Kilo', 'decimais': 2},
          'produto': {
            'produto': '6b10e6e1-802d-4c02-9ed6-692907fb33a8',
            'codigo': '08',
            'nome': 'Fermento',
            'tenant': 47,
            'estabelecimento': '39836516-7240-4fe5-847b-d5ee0f57252d',
            'grupo_empresarial': '95cd450c-30c5-4172-af2b-cdece39073bf',
            'empresa': '431bc005-9894-4c86-9dcd-7d1da9e2d006'
          }
        },
        {
          'produto_operacao': 'fbabc62c-f492-4234-8886-20ac9b1f2922',
          'operacao': '852ac311-8205-4bd1-8772-4834dc503c6c',
          'quantidade': 0.05,
          'tipo_produto': 'insumo',
          'tipo_produto_operacao': 'material_ficha_tecnica',
          'ficha_tecnica_produto': 'ff33dbbb-73ef-4a0b-9d7c-b432d0e6d84d',
          'unidade': {'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70', 'codigo': 'KG', 'nome': 'Kilo', 'decimais': 2},
          'produto': {
            'produto': 'a2579099-1caf-4ba9-ba99-c8747c162dc9',
            'codigo': '04',
            'nome': 'Manteiga',
            'tenant': 47,
            'estabelecimento': '39836516-7240-4fe5-847b-d5ee0f57252d',
            'grupo_empresarial': '95cd450c-30c5-4172-af2b-cdece39073bf',
            'empresa': '431bc005-9894-4c86-9dcd-7d1da9e2d006'
          }
        },
        {
          'produto_operacao': 'fa894e23-3317-448e-a07d-68a307494143',
          'operacao': '852ac311-8205-4bd1-8772-4834dc503c6c',
          'quantidade': 0.05,
          'tipo_produto': 'insumo',
          'tipo_produto_operacao': 'material_ficha_tecnica',
          'ficha_tecnica_produto': '96256242-13c5-4e4d-b6f1-7c230e359405',
          'unidade': {'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70', 'codigo': 'KG', 'nome': 'Kilo', 'decimais': 2},
          'produto': {
            'produto': 'a33bd64d-d9a6-4134-86ab-049e69d099f6',
            'codigo': '06',
            'nome': 'Farinha',
            'tenant': 47,
            'estabelecimento': '39836516-7240-4fe5-847b-d5ee0f57252d',
            'grupo_empresarial': '95cd450c-30c5-4172-af2b-cdece39073bf',
            'empresa': '431bc005-9894-4c86-9dcd-7d1da9e2d006'
          }
        },
        {
          'produto_operacao': '843bf03a-a45b-4996-89f7-329a54db4c4c',
          'operacao': '852ac311-8205-4bd1-8772-4834dc503c6c',
          'quantidade': 0.0,
          'tipo_produto': 'insumo',
          'tipo_produto_operacao': 'material_ficha_tecnica',
          'ficha_tecnica_produto': '4e1ed13e-9d4f-4eaa-a08c-f9c5b74b5b3b',
          'unidade': {'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70', 'codigo': 'KG', 'nome': 'Kilo', 'decimais': 2},
          'produto': {
            'produto': 'e6aafbcd-2ab7-4c2d-a2c6-0a2899318382',
            'codigo': '03',
            'nome': 'Leite',
            'tenant': 47,
            'estabelecimento': '39836516-7240-4fe5-847b-d5ee0f57252d',
            'grupo_empresarial': '95cd450c-30c5-4172-af2b-cdece39073bf',
            'empresa': '431bc005-9894-4c86-9dcd-7d1da9e2d006'
          }
        }
      ],
      'centro_de_trabalho': {'centro_de_trabalho': '8500df0f-73fa-4b57-9192-6b65402ad6ff', 'codigo': '07', 'nome': 'centro de trabalho 07'}
    }
  ]
};
