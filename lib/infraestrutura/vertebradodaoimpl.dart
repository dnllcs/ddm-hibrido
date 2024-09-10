import 'package:ddm_hibrido/dominio/entities/vertebrado.dart';
import 'package:ddm_hibrido/dominio/interfaces/IVertebradoDao.dart';
import 'package:ddm_hibrido/infraestrutura/connection.dart';
import 'package:sqflite/sqflite.dart';

class VertebradoDaoImpl implements IVertebradoDao {
  @override
  Future<void> deletarPorId(int id) async {
    final db = await Connection.getDatabase();
    await db.delete(
      'vertebrado',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<Vertebrado> recuperarPorId(int id) async {
    final db = await Connection.getDatabase();
    final result = await db.query(
      'vertebrado',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Vertebrado.fromMap(result.first);
    } else {
      throw Exception('Vertebrado não encontrado');
    }
  }

  @override
  Future<Vertebrado> salvar(Vertebrado vertebrado) async {
    final db = await Connection.getDatabase();

    if (vertebrado.id == null) {
      final id = await db.insert('vertebrado', vertebrado.toMap());
      vertebrado.id = id;
    } else {
      await db.update(
        'vertebrado',
        vertebrado.toMap(),
        where: 'id = ?',
        whereArgs: [vertebrado.id],
      );
    }

    return vertebrado;
  }
}
