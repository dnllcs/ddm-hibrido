import 'package:ddm_hibrido/infraestrutura/vertebradodaoimpl.dart';
import 'package:flutter/material.dart';
import 'package:ddm_hibrido/dominio/entities/vertebrado.dart';

class VertebradoCrudPage extends StatefulWidget {
  @override
  _VertebradoCrudPageState createState() => _VertebradoCrudPageState();
}

class _VertebradoCrudPageState extends State<VertebradoCrudPage> {
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _especieController = TextEditingController();
  final _tipoEsqueletoController = TextEditingController();
  final _numeroMembrosController = TextEditingController();
  bool _sangueQuente = false;
  final _dao = VertebradoDaoImpl();
  List<Vertebrado> _vertebrados = [];

  @override
  void initState() {
    super.initState();
    _listarVertebrados();
  }

  Future<void> _listarVertebrados() async {
    setState(() {});
  }

  Future<void> _criarOuAtualizarVertebrado([int? id]) async {
    final nome = _nomeController.text;
    final idade = int.tryParse(_idadeController.text) ?? 0;
    final especie = _especieController.text;
    final tipoEsqueleto = _tipoEsqueletoController.text;
    final numeroMembros = int.tryParse(_numeroMembrosController.text) ?? 0;
    final sangueQuente = _sangueQuente;

    if (id == null) {
      final vertebrado = Vertebrado(
        null,
        nome,
        idade,
        especie,
        tipoEsqueleto,
        sangueQuente,
        numeroMembros,
      );
      await _dao.salvar(vertebrado);
    } else {
      final vertebrado = Vertebrado(
        id,
        nome,
        idade,
        especie,
        tipoEsqueleto,
        sangueQuente,
        numeroMembros,
      );
      await _dao.salvar(vertebrado);
    }

    _nomeController.clear();
    _idadeController.clear();
    _especieController.clear();
    _tipoEsqueletoController.clear();
    _numeroMembrosController.clear();
    setState(() {
      _listarVertebrados();
    });
  }

  Future<void> _deletarVertebrado(int id) async {
    await _dao.deletarPorId(id);
    setState(() {
      _listarVertebrados();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Vertebrados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _idadeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Idade'),
            ),
            TextField(
              controller: _especieController,
              decoration: InputDecoration(labelText: 'Espécie'),
            ),
            TextField(
              controller: _tipoEsqueletoController,
              decoration: InputDecoration(labelText: 'Tipo de Esqueleto'),
            ),
            TextField(
              controller: _numeroMembrosController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número de Membros'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Sangue Quente'),
                Switch(
                  value: _sangueQuente,
                  onChanged: (value) {
                    setState(() {
                      _sangueQuente = value;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => _criarOuAtualizarVertebrado(),
              child: Text('Criar ou Atualizar'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _vertebrados.length,
                itemBuilder: (context, index) {
                  final vertebrado = _vertebrados[index];
                  return ListTile(
                    title: Text(vertebrado.nome),
                    subtitle: Text('Espécie: ${vertebrado.especie}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _nomeController.text = vertebrado.nome;
                            _idadeController.text = vertebrado.idade.toString();
                            _especieController.text = vertebrado.especie;
                            _tipoEsqueletoController.text =
                                vertebrado.tipoEsqueleto;
                            _numeroMembrosController.text =
                                vertebrado.numeroMembros.toString();
                            _sangueQuente = vertebrado.sangueQuente;
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deletarVertebrado(vertebrado.id!),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
