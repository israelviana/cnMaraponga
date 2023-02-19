import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DB{

  DB._();

  static final DB instance = DB._();


  static Database _dataBase;

  get database async{
    if (_dataBase != null) return _dataBase;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'cnMaraponga.db'),
      version: 1,
      onCreate: _onCreate
    );
  }


  _onCreate(db, versao) async {
    await db.execute(_Usuarios);
    await db.execute(_Veiculos);
    await db.execute(_Escalas);
    await db.execute(_Voluntarios);
  }

  String get _Usuarios => '''
  CREATE TABLE usuarios(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(255),
    email VARCHAR(255),
    senha VARCHAR(255),
    telefone VARCHAR(255),
    cargo VARCHAR(255),
    cpf VARCHAR(255)
  );
''';


  String get _Veiculos => '''
  CREATE TABLE veiculos(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cor VARCHAR(255),
    placa VARCHAR(255),
    condutor VARCHAR(255),
    modelo VARCHAR(255),
    telefone VARCHAR(30)
  );
''';

  String get _Escalas => '''
  CREATE TABLE escalas(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(255),
    data VARCHAR(255),
    hora VARCHAR(255)
  );
''';

  String get _Voluntarios => '''
  CREATE TABLE voluntarios(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(255),
    cpf VARCHAR(255),
    telefone VARCHAR(255)
 
  );
''';

}