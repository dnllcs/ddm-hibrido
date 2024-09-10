import 'package:ddm_hibrido/dominio/entities/animal.dart';

class Vertebrado extends Animal {
  String tipoEsqueleto;
  bool sangueQuente;
  int numeroMembros;

  Vertebrado(super.id, super.nome, super.idade, super.especie,
      this.tipoEsqueleto, this.sangueQuente, this.numeroMembros);

  static Vertebrado fromMap(Map<String, dynamic> map) {
    return Vertebrado(
      map['id'] as int?,
      map['nome'] as String,
      map['idade'] as int,
      map['especie'] as String,
      map['tipoEsqueleto'] as String,
      map['sangueQuente'] == 1,
      map['numeroMembros'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'especie': especie,
      'tipoEsqueleto': tipoEsqueleto,
      'sangueQuente': sangueQuente ? 1 : 0,
      'numeroMembros': numeroMembros,
    };
  }
}
