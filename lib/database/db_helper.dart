import 'package:sqflite/sqflite.dart'; // KETIK
import 'package:path/path.dart'; // KETIK

class DBHelper {
  static Database? _database;

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'kerjakuy.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            fullname TEXT,
            email TEXT UNIQUE,
            password TEXT,
            pekerjaan TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE perusahaan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            namaPerusahaan TEXT UNIQUE,
            email TEXT UNIQUE,
            password TEXT,
            alamat TEXT,
            deskripsi Text,
            noTelepon Text
          )
        ''');

        await db.execute('''
          CREATE TABLE keahlian (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id integer,
            nama_skill TEXT,
            FOREIGN KEY(user_id) REFERENCES users(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE berita (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            deskripsi TEXT,
            tanggal TEXT
          )
        ''');

        await db.execute('''
    INSERT INTO berita (deskripsi, tanggal) VALUES
    ('Klaim Pengangguran AS Naik Tipis, dekati posisi terendah dalam sejarah', '23 Desember 2025'),
    ('Gaji Minimum Regional Jakarta Resmi Naik Tahun Ini', '21 Desember 2025'),
    ('LinkedIn Rilis Fitur Baru Untuk Pencari Kerja', '20 Desember 2025'),
    ('Tips Lolos Wawancara HRD 2025, Simak Berikut Ini', '18 Desember 2025'),
    ('Lowongan Developer Meningkat 45% Tahun Ini', '16 Desember 2025'),
    ('Cara Memilih Pekerjaan yang Sesuai Passion', '15 Desember 2025'),
    ('Fresh Graduate Banyak Dicari di Industri Digital 2025', '14 Desember 2025'),
    ('5 Skill yang Wajib Dimiliki untuk Karir Masa Depan', '12 Desember 2025');
  ''');
      },
    );
  }

  static Future<Database> _getDB() async {
    _database ??= await _initDB();
    return _database!;
  }

  // REGISTER
  static Future<int> registerUser({
    required String fullname,
    required String username,
    required String email,
    required String password,
  }) async {
    final db = await _getDB();
    final userId = await db.insert('users', {
      'username': username,
      'fullname': fullname,
      'email': email,
      'password': password,
      'pekerjaan': "Pelamar",
    });

    print(
      "\x1B[32mREGISTER SUCCESS: User ID = $userId, Username = $username, Email = $email\x1B[0m",
    );

    return userId;
  }

  // LOGIN
  static Future<Map<String, dynamic>?> loginUser({
    required String usernameOrEmail,
    required String password,
  }) async {
    final db = await _getDB();
    final res = await db.query(
      'users',
      where: '(username=? OR email=?) AND password=?',
      whereArgs: [usernameOrEmail, usernameOrEmail, password],
    );
    return res.isNotEmpty ? res.first : null;
  }

  static Future<void> tambahSkill(int userId, String namaSkill) async {
    final db = await _getDB();
    await db.insert('keahlian', {'user_id': userId, 'nama_skill': namaSkill});
  }

  static Future<List<Map<String, dynamic>>> getBerita() async {
    final db = await _getDB();
    return await db.query('berita', orderBy: 'id Desc');
  }

  static Future<int> registerPerusahaan({
    required String namaPerusahaan,
    required String email,
    required String password,
    required String alamat,
    required String deskripsi,
    required String noTelepon,
  }) async {
    final db = await _getDB();
    final userId = await db.insert('perusahaan', {
      'namaPerusahaan': namaPerusahaan,
      'email': email,
      'password': password,
      'alamat': alamat,
      'deskripsi': deskripsi,
      'noTelepon': noTelepon,
    });

    print(
      "\x1B[32mREGISTER SUCCESS: User ID = $userId, nama Perusahaan = $namaPerusahaan, Email = $email\x1B[0m",
    );

    return userId;
  }

  static Future<Map<String, dynamic>?> loginPerusahaan({
    required String email,
    required String password,
  }) async {
    final db = await _getDB();
    final res = await db.query(
      'perusahaan',
      where: 'email=? AND password=?',
      whereArgs: [email, password],
    );

    return res.isNotEmpty ? res.first : null;
  }
}
