import 'dart:io';
import 'package:mybookshelf/models/book.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static const String tableBooks = 'books';

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'dokudoku.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
	  CREATE TABLE $tableBooks (
		id INTEGER PRIMARY KEY,
		googleBookId TEXT,
		title TEXT NOT NULL,
		subtitle TEXT,
		thumbnail TEXT,
		isCompleted INTEGER NOT NULL,
		previewLink TEXT,
		authors TEXT,
		publisher TEXT,
		publishedDate TEXT,
		description TEXT,
		pageCount INTEGER,
		categories TEXT,
		currencyCode TEXT,
		price REAL
	  )
	''');
  }

  Future<List<Book>> getBooks() async {
    Database db = await instance.database;
    var books = await db.query(tableBooks, orderBy: 'title');
    List<Book> bookList = books.isNotEmpty
        ? books.map((book) => Book.fromJson(book)).toList()
        : [];
    return bookList;
  }

  Future<Book> getBookById(int? id) async {
    Database db = await instance.database;
    var book = await db.query(tableBooks, where: 'id = ?', whereArgs: [id]);
    return Book.fromJson(book.first);
  }

  Future<List<String>> getGoogleBookIds() async {
    Database db = await instance.database;
    var googleBookIds = await db.query(tableBooks,
        columns: ['googleBookId'], where: 'googleBookId IS NOT NULL');
    List<String> idList = googleBookIds.isNotEmpty
        ? googleBookIds.map((id) => id['googleBookId'].toString()).toList()
        : [];
    return idList;
  }

  Future<int> addBook(Book book) async {
    Database db = await instance.database;
    return await db.insert(tableBooks, book.toJson());
  }

  Future<int> removeById(int? id) async {
    Database db = await instance.database;
    return await db.delete(tableBooks, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> removeByGoogleBookId(String googleBookId) async {
    Database db = await instance.database;
    return await db.delete(tableBooks,
        where: 'googleBookId = ?', whereArgs: [googleBookId]);
  }

  Future<int> removeAllBooks() async {
    Database db = await instance.database;
    return await db.delete(tableBooks);
  }

  Future<int> updateBook(Book book) async {
    Database db = await instance.database;
    return await db.update(
      tableBooks,
      book.toJson(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> updateBookById(int? id, Book book) async {
    Database db = await instance.database;
    return await db.update(
      tableBooks,
      book.toJson(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
