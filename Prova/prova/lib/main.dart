import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(home: Prova(), debugShowCheckedModeBanner: false));
}

class Prova extends StatefulWidget {
  @override
  _ProvaState createState() => _ProvaState();
}

class _ProvaState extends State<Prova> {
  List<Map<String, dynamic>> lista = [];

  TextEditingController titulo = TextEditingController();
  TextEditingController descricao = TextEditingController();

  int? idEditando;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<Database> abrirBanco() async {
    final caminho = await getDatabasesPath();
    final local = join(caminho, "banco.db");

    return openDatabase(
      local,
      version: 1,
      onCreate: (db, version) {
        return db.execute("""
          CREATE TABLE dados(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT,
            descricao TEXT,
            data TEXT
          )
        """);
      },
    );
  }

  void create() async {
    final db = await abrirBanco();

    String t = titulo.text;
    String d = descricao.text;
    String dataAtual = DateTime.now().toString();

    if (t.isEmpty || d.isEmpty) {
      print("Preencha os campos");
      return;
    }

    if (idEditando == null) {
      await db.insert("dados", {
        "titulo": t,
        "descricao": d,
        "data": dataAtual,
      });
    } else {
      await db.update(
        "dados",
        {"titulo": t, "descricao": d},
        where: "id = ?",
        whereArgs: [idEditando],
      );

      idEditando = null;
    }

    titulo.clear();
    descricao.clear();

    carregarDados();
  }

  Future<List<Map<String, dynamic>>> listar() async {
    final db = await abrirBanco();
    return db.query("dados", orderBy: "titulo ASC");
  }

  void carregarDados() async {
    final dados = await listar();

    setState(() {
      lista = dados;
    });
  }

  void excluir(int id) async {
    final db = await abrirBanco();

    await db.delete("dados", where: "id = ?", whereArgs: [id]);

    carregarDados();
  }

  void cancelarEdicao() {
    setState(() {
      idEditando = null;
      titulo.clear();
      descricao.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App de Cadastro")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: titulo,
                    decoration: InputDecoration(
                      labelText: "Título",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: descricao,
                    decoration: InputDecoration(
                      labelText: "Descrição",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: create,
              child: Text(
                idEditando == null ? "Criar" : "Atualizar",
                style: TextStyle(fontSize: 18),
              ),
            ),
            if (idEditando != null)
              TextButton(
                onPressed: cancelarEdicao,
                child: Text("Cancelar edição"),
              ),
            SizedBox(height: 20),
            Expanded(
              child: lista.isEmpty
                  ? Center(child: Text("Nenhum item cadastrado"))
                  : ListView.builder(
                      itemCount: lista.length,
                      itemBuilder: (context, index) {
                        final item = lista[index];

                        return Card(
                          child: ListTile(
                            title: Text(item["titulo"]),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item["descricao"]),
                                Text(
                                  item["data"] ?? "",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                titulo.text = item["titulo"];
                                descricao.text = item["descricao"];
                                idEditando = item["id"];
                              });
                            },
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => excluir(item["id"]),
                            ),
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
