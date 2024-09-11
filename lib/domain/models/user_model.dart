class UserModel {
  String? nome;
  String? sobrenome;
  String? email;
  String? senha;
  
  int? idCurso;
  String? curso;

  int? idBlocoPrincipal;
  String? blocoPrincipal;

  List<int?> idsBlocosSecundarios;
  List<String?> blocosSecundarios;

  DateTime? dataNascimento;
  DateTime? dataIngresso;

  int? idGenero;
  String? genero;

  int? idPreferencia;

  String? sexualidade;
  String? bio;
  String? cidade;
  String? signo;
  String? semestre;
  String? linguagemAmor;
  List<String?> interesses;
  String? pets;
  String? bebida;
  String? fumante;
  String? atividadeFisica;
  String? tipoRole;
  String? musica;

  UserModel({
    this.nome,
    this.sobrenome,
    this.email,
    this.senha,
    this.idCurso,
    this.curso,
    this.idBlocoPrincipal,
    this.blocoPrincipal,
    this.idsBlocosSecundarios = const [],
    this.blocosSecundarios = const [],
    this.dataNascimento,
    this.dataIngresso,
    this.idGenero,
    this.genero,
    this.idPreferencia,
    this.sexualidade,
    this.bio,
    this.cidade,
    this.signo,
    this.semestre,
    this.linguagemAmor,
    this.interesses = const [],
    this.pets,
    this.bebida,
    this.fumante,
    this.atividadeFisica,
    this.tipoRole,
    this.musica,
  }) {
    // Inicializa as listas se não forem nulas, senão usa listas vazias
    idsBlocosSecundarios = idsBlocosSecundarios ?? [];
    blocosSecundarios = blocosSecundarios ?? [];
    interesses = interesses ?? [];
  }
  
  // @override
  // String toString() {
  //   return 'PropouseModel{numeroOrc: $numeroOrc, idOrcamento: $idOrcamento, nomeCliente: $nomeCliente, ruaEntrega: $ruaEntrega, dataEmissao: $dataEmissao, km: $km, entret: $entret, descStatus: $descStatus}';
  // }
}
