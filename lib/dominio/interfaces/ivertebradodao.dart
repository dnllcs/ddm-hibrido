import 'package:ddm_hibrido/dominio/entities/vertebrado.dart';

abstract class IVertebradoDao {
  Future<Vertebrado> salvar(Vertebrado vertebrado);
  Future<Vertebrado> recuperarPorId(int id);
  Future<void> deletarPorId(int id);
}
