import 'dart:convert';

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
          CREATE TABLE lowongan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            perusahaan_id integer,
            nama_perusahaan TEXT,
            kategori TEXT,
            posisi TEXT,
            deskripsi TEXT,
            syarat TEXT,
            gaji TEXT,
            tipe TEXT,
            periode_awal TEXT,
            periode_akhir TEXT,
            lokasi TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE cv (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            pendidikan TEXT,
            umur INTEGER,
            tentang_saya TEXT,
            universitas TEXT,
            jurusan TEXT,
            kontak TEXT,
            title TEXT,
            subtitle TEXT,
            FOREIGN KEY(user_id) REFERENCES users(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE skillCV (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cv_id INTEGER,
            skill TEXT,
            kemampuan INTEGER,
            FOREIGN KEY(cv_id) REFERENCES cv(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE pengalaman (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cv_id INTEGER,
            pengalaman TEXT,
            durasi TEXT,
            FOREIGN KEY(cv_id) REFERENCES cv(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE kontak (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cv_id INTEGER,
            email TEXT,
            no_telepon TEXT,
            linkedIn TEXT,
            FOREIGN KEY(cv_id) REFERENCES cv(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE lamaran (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            perusahaan_id INTEGER,
            cv_id INTEGER,
            status TEXT,
            lowongan_id INTEGER,
            FOREIGN KEY(lowongan_id) REFERENCES lowongan(id),
            FOREIGN KEY(cv_id) REFERENCES cv(id),
            FOREIGN KEY(user_id) REFERENCES users(id),
            FOREIGN KEY(perusahaan_id) REFERENCES perusahaan(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE wawancara (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            perusahaan_id INTEGER,
            status TEXT,
            lowongan_id INTEGER,
            jam_mulai TEXT,
            jam_selesai TEXT,
            tanggal TEXT,
            link_meet TEXT,
            pesan TEXT,
            FOREIGN KEY(lowongan_id) REFERENCES lowongan(id),
            FOREIGN KEY(user_id) REFERENCES users(id),
            FOREIGN KEY(perusahaan_id) REFERENCES perusahaan(id)
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
      onOpen: (db) async {
        await insertDummyLowonganIfEmpty(db);
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

  static Future<List<String>> getSkillUser(int userId) async {
    final db = await _getDB();
    final res = await db.query(
      'keahlian',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return res.map((e) => e['nama_skill'].toString()).toList();
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

  // INSERT LOWONGAN
  static Future<int> insertLowongan({
    required String nama_perusahaan,
    required int perusahaanId,
    required String kategori,
    required String posisi,
    required String deskripsi,
    required String syarat,
    required String gaji,
    required String tipe,
    required String periodeAwal,
    required String periodeAkhir,
    required String lokasi,
  }) async {
    final db = await _getDB();
    final lowonganId = await db.insert('lowongan', {
      'perusahaan_id': perusahaanId,
      'nama_perusahaan': nama_perusahaan,
      'kategori': kategori,
      'posisi': posisi,
      'deskripsi': deskripsi,
      'syarat': syarat,
      'gaji': gaji,
      'tipe': tipe,
      'periode_awal': periodeAwal,
      'periode_akhir': periodeAkhir,
      'lokasi': lokasi,
    });

    print(
      "\x1B[32mLOWONGAN INSERT SUCCESS: ID = $lowonganId, Posisi = $posisi\x1B[0m",
    );

    final semuaLowongan = await db.query('lowongan', orderBy: "id DESC");

    print("\n===== DAFTAR SEMUA LOWONGAN =====");
    for (var job in semuaLowongan) {
      print(
        "ID: ${job['id']} | "
        "Perusahaan: ${job['nama_perusahaan']} | "
        "Posisi: ${job['posisi']} | "
        "Gaji: ${job['gaji']} | "
        "Lokasi: ${job['lokasi']} | "
        "Periode: ${job['periode_awal']} - ${job['periode_akhir']}",
      );
    }
    print("==================================\n");
    return lowonganId;
  }

  static Future<Map<String, dynamic>?> getRekomendasiLowongan(
    int userId,
  ) async {
    final db = await _getDB();

    List<String> skills = await getSkillUser(userId);
    if (skills.isEmpty) return null;

    String likeQuery = skills.map((_) => "kategori LIKE ?").join(" OR ");
    List<String> likeArgs = skills.map((s) => "%$s%").toList();

    final res = await db.query(
      'lowongan',
      where: likeQuery,
      whereArgs: likeArgs,
      orderBy: "RANDOM()",
      limit: 1,
    );

    return res.isNotEmpty ? res.first : null;
  }

  static Future<int> insertCV({
    required int userId,
    required String pendidikan,
    required int umur,
    required String tentangSaya,
    required String universitas,
    required String jurusan,
    required String kontak,
    required String title,
    required String subtitle,
  }) async {
    final db = await _getDB();

    final cvId = await db.insert('cv', {
      'user_id': userId,
      'pendidikan': pendidikan,
      'umur': umur,
      'tentang_saya': tentangSaya,
      'universitas': universitas,
      'jurusan': jurusan,
      'kontak': kontak,
      'title': title,
      'subtitle': subtitle,
    });

    print("\x1B[32mCV INSERT SUCCESS — ID: $cvId\x1B[0m");

    return cvId;
  }

  static Future<int> insertSkillCV({
    required int cvId,
    required String skill,
    required int kemampuan,
  }) async {
    final db = await _getDB();

    final id = await db.insert('skillCV', {
      'cv_id': cvId,
      'skill': skill,
      'kemampuan': kemampuan,
    });

    print(
      "\x1B[32mSKILL INSERT SUCCESS — CV: $cvId, Skill: $skill ($kemampuan%)\x1B[0m",
    );

    return id;
  }

  static Future<int> insertPengalaman({
    required int cvId,
    required String pengalaman,
    required String durasi,
  }) async {
    final db = await _getDB();

    final id = await db.insert('pengalaman', {
      'cv_id': cvId,
      'pengalaman': pengalaman,
      'durasi': durasi,
    });

    print(
      "\x1B[32mPENGALAMAN INSERT SUCCESS — CV: $cvId, $pengalaman ($durasi)\x1B[0m",
    );

    return id;
  }

  static Future<int> insertKontak({
    required int cvId,
    required String email,
    required String noTelepon,
    required String linkedIn,
  }) async {
    final db = await _getDB();

    final id = await db.insert('kontak', {
      'cv_id': cvId,
      'email': email,
      'no_telepon': noTelepon,
      'linkedIn': linkedIn,
    });

    print("\x1B[32mKONTAK INSERT SUCCESS — CV: $cvId, Email: $email\x1B[0m");

    return id;
  }

  static Future<List<Map<String, dynamic>>> getCVByUserId(int userId) async {
    final db = await _getDB();
    return await db.query('cv', where: 'user_id = ?', whereArgs: [userId]);
  }

  //INSERT LOWONGAN
  static Future<int> insertLamaran({
    required int lowongan_id,
    required int user_id,
    required int perusahaan_id,
    required int cv_id,
  }) async {
    final db = await _getDB();

    final lamaranId = await db.insert('lamaran', {
      'lowongan_id': lowongan_id,
      'user_id': user_id,
      'perusahaan_id': perusahaan_id,
      'cv_id': cv_id,
      'status': "Process",
    });

    print("\x1B[32mLamaran INSERT SUCCESS — ID: $lamaranId\x1B[0m");
    final semuaLamaran = await db.query('lamaran', orderBy: "id DESC");

    print("\n===== DAFTAR SEMUA LOWONGAN =====");
    for (var job in semuaLamaran) {
      print(
        "User ID: ${job['user_id']} | "
        "Perusahaan ID: ${job['perusahaan_id']} | "
        "Lowongan ID: ${job['lowongan_id']} | "
        "CV ID: ${job['cv_id']} | "
        "Status: ${job['status']} | ",
      );
    }
    print("==================================\n");

    return lamaranId;
  }

  //fungsi megnambil lowogan berdasarkan id
  // fungsi mengambil lowongan berdasarkan perusahaan sekaligus jumlah pelamar
  static Future<List<Map<String, dynamic>>> getLowonganByPerusahaanId(
    int perusahaanId,
  ) async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query(
      'lowongan',
      where: 'perusahaan_id = ?',
      whereArgs: [perusahaanId],
      orderBy: 'id DESC',
    );

    // get jumlah pelamar
    List<Map<String, dynamic>> result = [];

    for (var item in maps) {
      int lowonganId = item['id'];
      int jumlahPelamar = await getJumlahPelamar(lowonganId);

      result.add({
        'id': lowonganId,
        'judul': item['posisi'],
        'mulai': item['periode_awal'],
        'akhir': item['periode_akhir'],
        'pelamar': jumlahPelamar,
      });
    }

    return result;
  }

  // GET JUMLAH PELAMAR BERDASARKAN LOWONGAN ID
  static Future<int> getJumlahPelamar(int lowonganId) async {
    final db = await _getDB();

    final result = await db.rawQuery(
      "SELECT COUNT(*) as total FROM lamaran WHERE lowongan_id = ?",
      [lowonganId],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  //untuk get pelamar by lowongan
  static Future<List<Map<String, dynamic>>> getPelamarByLowongan(
    int lowonganId,
  ) async {
    final db = await _getDB();

    final result = await db.rawQuery(
      """
    SELECT 
      lamaran.user_id AS user_id, 
      users.fullname AS nama,
      users.email AS email,
      cv.title AS cv_title,
      cv.id AS cv_id
    FROM lamaran
    JOIN users ON users.id = lamaran.user_id
    JOIN cv ON cv.id = lamaran.cv_id
    WHERE lamaran.lowongan_id = ?
    """,
      [lowonganId],
    );

    return result;
  }

  static Future<Map<String, dynamic>?> getDetailLowongan(int lowonganId) async {
    final db = await _getDB();

    final result = await db.query(
      'lowongan',
      where: 'id = ?',
      whereArgs: [lowonganId],
    );

    if (result.isEmpty) return null;
    return result.first;
  }

  static Future<Database> getDBPublic() async {
    return await _getDB();
  }

  static Future<int> buatWawancara({
    required int userId,
    required int perusahaanId,
    required int lowonganId,
    required String jamMulai,
    required String jamSelesai,
    required String tanggal,
    required String linkMeet,
    required String pesan,
  }) async {
    final db = await _getDB();

    final wawancaraId = await db.insert('wawancara', {
      'user_id': userId,
      'perusahaan_id': perusahaanId,
      'lowongan_id': lowonganId,
      'status': "process",
      'jam_mulai': jamMulai,
      'jam_selesai': jamSelesai,
      "tanggal": tanggal,
      'link_meet': linkMeet,
      'pesan': pesan,
    });

    print("\x1B[32mWawancara INSERT SUCCESS — ID: $wawancaraId\x1B[0m");

    return wawancaraId;
  }

  static Future<int?> getPerusahaanIdByLowonganId(int lowonganId) async {
    final db = await _getDB();

    final result = await db.query(
      'lowongan',
      columns: ['perusahaan_id'],
      where: 'id = ?',
      whereArgs: [lowonganId],
      limit: 1,
    );

    if (result.isEmpty) return null;
    return result.first['perusahaan_id'] as int;
  }

  static Future<List<Map<String, dynamic>>> getWawancaraByUserId(
    int userId,
  ) async {
    final db = await _getDB();

    return await db.query(
      'wawancara',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: "tanggal ASC",
    );
  }

  static Future<String?> getNamaPerusahaan(int perusahaanId) async {
    final db = await _getDB();

    final res = await db.query(
      'perusahaan',
      columns: ['namaPerusahaan'],
      where: 'id = ?',
      whereArgs: [perusahaanId],
      limit: 1,
    );

    if (res.isEmpty) return null;
    return res.first['namaPerusahaan'] as String?;
  }

  static Future<String?> getPosisiByLowonganId(int lowonganId) async {
    final db = await _getDB();

    final res = await db.query(
      'lowongan',
      columns: ['posisi'],
      where: 'id = ?',
      whereArgs: [lowonganId],
      limit: 1,
    );

    if (res.isEmpty) return null;
    return res.first['posisi'] as String?;
  }

  static Future<List<Map<String, dynamic>>> getWawancaraByPerusahaanId(
    int perusahaanId,
  ) async {
    final db = await _getDB();

    return await db.query(
      "wawancara",
      where: "perusahaan_id = ?",
      whereArgs: [perusahaanId],
    );
  }

  static Future<String> getNamaUserById(int userId) async {
    final db = await _getDB();
    final res = await db.query(
      'users',
      columns: ['fullname'],
      where: 'id = ?',
      whereArgs: [userId],
      limit: 1,
    );

    return res.isNotEmpty
        ? res.first['fullname'].toString()
        : 'Tidak diketahui';
  }

  static Future<void> insertDummyLowonganIfEmpty(Database db) async {
    final result = await db.query('lowongan');

    if (result.isEmpty) {
      print("➡ Menambahkan data dummy lowongan...");

      await db.insert('lowongan', {
        'perusahaan_id': 1,
        'nama_perusahaan': 'PT Teknologi Indonesia',
        'kategori': 'Web Development',
        'posisi': 'Frontend Developer',
        'deskripsi': 'Membangun UI/UX menggunakan Flutter & Web.',
        'syarat': jsonEncode([
          "Menguasai Flutter",
          "Pengalaman 1 tahun",
          "Mengerti REST API",
        ]),
        'gaji': '7.000.000 - 10.000.000',
        'tipe': 'Full Time',
        'periode_awal': '2025-01-01',
        'periode_akhir': '2025-02-01',
        'lokasi': 'Jakarta',
      });

      await db.insert('lowongan', {
        'perusahaan_id': 2,
        'nama_perusahaan': 'PT Data Nusantara',
        'kategori': 'Data Analyst',
        'posisi': 'Junior Data Analyst',
        'deskripsi': 'Melakukan analisis data dan membuat visualisasi.',
        'syarat': jsonEncode([
          "Menguasai Excel",
          "Basic SQL",
          "Mampu membaca grafik",
        ]),
        'gaji': '5.000.000 - 8.000.000',
        'tipe': 'Full Time',
        'periode_awal': '2025-01-10',
        'periode_akhir': '2025-03-10',
        'lokasi': 'Bandung',
      });
    } else {
      print("➡ Data lowongan sudah ada, tidak insert lagi.");
    }
  }

  static Future<List<Map<String, dynamic>>> getLowongan() async {
    final db = await _getDB();
    return await db.query('lowongan', orderBy: 'id DESC');
  }

  static Future<Map<String, dynamic>?> findLowonganById(int id) async {
    final db = await _getDB();

    final result = await db.query(
      'lowongan',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return result.isNotEmpty ? result.first : null;
  }

}