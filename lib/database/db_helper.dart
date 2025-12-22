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
            pekerjaan TEXT,
            photo_path TEXT
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
            noTelepon Text,
            photo_profile TEXT,
            photo_background TEXT
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
            tanggal TEXT,
            image_path TEXT
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
          CREATE TABLE chat_room (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER,
          perusahaan_id INTEGER,
          last_message TEXT,
          updated_at TEXT
        )
        ''');
        await db.execute('''
            CREATE TABLE chat_message (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            room_id INTEGER,
            sender_type TEXT, -- 'user' / 'perusahaan'
            message TEXT,
            created_at TEXT
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
          INSERT INTO berita (deskripsi, tanggal, image_path) VALUES
          ('Klaim Pengangguran AS Naik Tipis, dekati posisi terendah dalam sejarah', '23 Desember 2025', 'lib/assets/berita/berita1.jpg'),
          ('Gaji Minimum Regional Jakarta Resmi Naik Tahun Ini', '21 Desember 2025','lib/assets/berita/berita2.jpg'),
          ('LinkedIn Rilis Fitur Baru Untuk Pencari Kerja', '20 Desember 2025','lib/assets/berita/berita3.jpg'),
          ('Tips Lolos Wawancara HRD 2025, Simak Berikut Ini', '18 Desember 2025','lib/assets/berita/berita4.jpg'),
          ('Lowongan Developer Meningkat 45% Tahun Ini', '16 Desember 2025','lib/assets/berita/berita5.jpg'),
          ('Cara Memilih Pekerjaan yang Sesuai Passion', '15 Desember 2025','lib/assets/berita/berita6.jpg'),
          ('Fresh Graduate Banyak Dicari di Industri Digital 2025', '14 Desember 2025','lib/assets/berita/berita7.jpg'),
          ('5 Skill yang Wajib Dimiliki untuk Karir Masa Depan', '12 Desember 2025','lib/assets/berita/berita8.jpg');
      ''');
      },
      onOpen: (db) async {
        // await insertDummyLowonganIfEmpty(db);
        // await seedTelkomIfEmpty(db);
      },
    );
  }

  static Future<Database> _getDB() async {
    _database ??= await _initDB();
    return _database!;
  }

  // REGISTER PELAMAR
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

  // REGISTER PELAMAR
  static Future<int> registerPerusahaan({
    required String namaPerusahaan,
    required String email,
    required String password,
    required String alamat,
    required String deskripsi,
    required String noTelepon,
    String? photoProfile,
    String? photoBackground,
  }) async {
    final db = await _getDB();
    final userId = await db.insert('perusahaan', {
      'namaPerusahaan': namaPerusahaan,
      'email': email,
      'password': password,
      'alamat': alamat,
      'deskripsi': deskripsi,
      'noTelepon': noTelepon,
      'photo_profile': photoProfile,
      'photo_background': photoBackground,
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

    String likeQuery = skills.map((_) => "l.kategori LIKE ?").join(" OR ");
    List<String> likeArgs = skills.map((s) => "%$s%").toList();

    final res = await db.rawQuery('''
    SELECT 
      l.*,
      p.namaPerusahaan AS nama_perusahaan,
      p.photo_profile,
      p.photo_background,
      p.email,
      p.alamat,
      p.noTelepon,
      p.deskripsi as deskripsi_perusahaan
    FROM lowongan l
    JOIN perusahaan p ON p.id = l.perusahaan_id
    WHERE $likeQuery
    ORDER BY RANDOM()
    LIMIT 1
    ''', likeArgs);

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
      '''
    SELECT COUNT(*) as total 
    FROM lamaran 
    WHERE lowongan_id = ?
      AND status = 'Process'
    ''',
      [lowonganId],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  //untuk get pelamar by lowongan
  static Future<List<Map<String, dynamic>>> getPelamarByLowongan(
    int lowonganId,
  ) async {
    final db = await _getDB();

    return await db.rawQuery(
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
      AND lamaran.status = 'Process'
    """,
      [lowonganId],
    );
  }

  static Future<Map<String, dynamic>?> getDetailLowongan(int lowonganId) async {
    final db = await _getDB();

    final result = await db.rawQuery(
      '''
    SELECT 
      l.*,
      p.namaPerusahaan,
      p.photo_profile,
      p.photo_background
    FROM lowongan l
    JOIN perusahaan p ON p.id = l.perusahaan_id
    WHERE l.id = ?
    ''',
      [lowonganId],
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

  static Future<void> seedTelkomIfEmpty(Database db) async {
    final perusahaan = await db.query(
      'perusahaan',
      where: 'namaPerusahaan = ?',
      whereArgs: ['PT Telkom Indonesia'],
    );

    // Jika sudah ada → jangan insert lagi
    if (perusahaan.isNotEmpty) {
      print("➡ Telkom sudah ada, skip seeding");
      return;
    }

    // INSERT PERUSAHAAN TELKOM
    int telkomId = await db.insert('perusahaan', {
      'namaPerusahaan': 'PT Telkom Indonesia',
      'email': 'hr@telkom.co.id',
      'password': 'telkom123',
      'alamat': 'Jl. Japati No.1, Bandung, Jawa Barat',
      'deskripsi':
          'PT Telkom Indonesia adalah perusahaan BUMN yang bergerak di bidang '
          'telekomunikasi dan teknologi informasi. Telkom menyediakan layanan '
          'konektivitas jaringan, data center, cloud computing, solusi enterprise, '
          'serta platform digital untuk mendukung transformasi digital nasional.',
      'noTelepon': '021-12345678',
    });

    // INSERT USER
    int userId = await db.insert('users', {
      'username': 'rizkydev',
      'fullname': 'Rizky Pratama',
      'email': 'rizky@gmail.com',
      'password': 'password123',
      'pekerjaan': 'Pelamar',
    });

    // INSERT KEAHLIAN USER
    await db.insert('keahlian', {
      'user_id': userId,
      'nama_skill': 'Programming',
    });

    // INSERT LOWONGAN TELKOM

    print("✅ Dummy Telkom + User + Lowongan berhasil ditambahkan");
  }

  static Future<void> tolakPelamar({
    required int userId,
    required int lowonganId,
    required int perusahaanId,
  }) async {
    final db = await _getDB();

    // 1️⃣ CEK APAKAH ADA WAWANCARA
    final wawancara = await db.query(
      'wawancara',
      where: 'user_id = ? AND lowongan_id = ? AND perusahaan_id = ?',
      whereArgs: [userId, lowonganId, perusahaanId],
    );

    // 2️⃣ JIKA ADA WAWANCARA → UPDATE JADI SELESAI
    if (wawancara.isNotEmpty) {
      await db.update(
        'wawancara',
        {'status': 'selesai'},
        where: 'id = ?',
        whereArgs: [wawancara.first['id']],
      );

      print("✔ Wawancara ditemukan → status diubah ke selesai");
    } else {
      print("ℹ Tidak ada wawancara → skip update wawancara");
    }

    // 3️⃣ UPDATE LAMARAN JADI DITOLAK
    await db.update(
      'lamaran',
      {'status': 'Ditolak'},
      where: 'user_id = ? AND lowongan_id = ? AND perusahaan_id = ?',
      whereArgs: [userId, lowonganId, perusahaanId],
    );

    print("❌ Lamaran DITOLAK — user:$userId lowongan:$lowonganId");
  }

  static Future<List<Map<String, dynamic>>> getLamaranByUserId(
    int userId,
  ) async {
    final db = await _getDB();

    return await db.rawQuery(
      '''
    SELECT 
      lamaran.id AS lamaran_id,
      lamaran.status,
      perusahaan.namaPerusahaan,
      lowongan.posisi,
      lowongan.id AS lowongan_id
    FROM lamaran
    JOIN perusahaan ON perusahaan.id = lamaran.perusahaan_id
    JOIN lowongan ON lowongan.id = lamaran.lowongan_id
    WHERE lamaran.user_id = ?
    ORDER BY lamaran.id DESC
    ''',
      [userId],
    );
  }

  //STATUS WAWANCARA
  static Future<void> updateStatusPelamar(
    int wawancaraId,
    int userId,
    int lowonganId,
    String status,
  ) async {
    final db = await _getDB();

    // Update tabel wawancara
    await db.update(
      'wawancara',
      {'status': status},
      where: 'id = ?',
      whereArgs: [wawancaraId],
    );

    // Update tabel lamaran(pelamar)
    String statusLamaran = status == 'accepted' ? 'Diterima' : 'Ditolak';
    await db.update(
      'lamaran',
      {'status': statusLamaran},
      where: 'user_id = ? AND lowongan_id = ?',
      whereArgs: [userId, lowonganId],
    );

    if (status == 'accepted') {
      // Ambil nama posisi dari lowongan tersebut
      List<Map<String, dynamic>> lowongan = await db.query(
        'lowongan',
        columns: ['posisi'],
        where: 'id = ?',
        whereArgs: [lowonganId],
      );

      if (lowongan.isNotEmpty) {
        String posisiBaru = lowongan.first['posisi'];

        // Update job_title di tabel users
        await db.update(
          'users',
          {'pekerjaan': posisiBaru},
          where: 'id = ?',
          whereArgs: [userId],
        );
      }
    }
  }

  // Kategori lowongan
  static Future<List<Map<String, dynamic>>> getKategoriKaryawan(
    int perusahaanId,
  ) async {
    final db = await _getDB();
    return await db.rawQuery(
      '''
      SELECT kategori, COUNT(id) as total_job 
      FROM lowongan 
      WHERE perusahaan_id = ? 
      GROUP BY kategori
    ''',
      [perusahaanId],
    );
  }

  // List karyawan
  static Future<List<Map<String, dynamic>>> getDaftarKaryawanDiterima(
    int perusahaanId,
    String role,
  ) async {
    final db = await _getDB();
    return await db.rawQuery(
      '''
      SELECT u.fullname as nama, l.posisi, l.kategori 
      FROM wawancara w
      JOIN users u ON w.user_id = u.id
      JOIN lowongan l ON w.lowongan_id = l.id
      WHERE w.perusahaan_id = ? AND l.kategori = ? AND w.status = 'accepted'
    ''',
      [perusahaanId, role],
    );
  }

  static Future<void> updateUserPhoto({
    required int userId,
    required String photoPath,
  }) async {
    final db = await _getDB();
    await db.update(
      'users',
      {'photo_path': photoPath},
      where: 'id = ?',
      whereArgs: [userId],
    );

    print("📸 FOTO PROFILE UPDATE: user=$userId path=$photoPath");
  }

  static Future<Map<String, dynamic>?> getUserById(int userId) async {
    final db = await _getDB();
    final res = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    return res.isNotEmpty ? res.first : null;
  }

  static Future<Map<String, dynamic>?> getUserData(int userId) async {
    final db = await _getDB();
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
    return results.isNotEmpty ? results.first : null;
  }

  static Future<void> updateUserJobTitle(int userId, String newTitle) async {
    final db = await _getDB();
    await db.update(
      'users',
      {'pekerjaan': newTitle},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  static Future<Map<String, dynamic>?> getPerusahaanById(int id) async {
    final db = await _getDB();
    final res = await db.query(
      'perusahaan',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return res.isNotEmpty ? res.first : null;
  }

  static Future<void> updatePerusahaan({
    required int perusahaanId,
    required String email,
    required String alamat,
    required String deskripsi,
    required String noTelepon,
    String? photoProfile,
    String? photoBackground,
    String? password,
  }) async {
    final db = await _getDB();

    final data = {
      'email': email,
      'alamat': alamat,
      'deskripsi': deskripsi,
      'noTelepon': noTelepon,
      'photo_profile': photoProfile,
      'photo_background': photoBackground,
    };

    if (password != null) {
      data['password'] = password;
    }

    await db.update(
      'perusahaan',
      data,
      where: 'id = ?',
      whereArgs: [perusahaanId],
    );
  }

  static Future<int> createOrGetChatRoom({
    required int userId,
    required int perusahaanId,
  }) async {
    final db = await _getDB();

    final existing = await db.query(
      'chat_room',
      where: 'user_id = ? AND perusahaan_id = ?',
      whereArgs: [userId, perusahaanId],
    );

    if (existing.isNotEmpty) {
      return existing.first['id'] as int;
    }

    return await db.insert('chat_room', {
      'user_id': userId,
      'perusahaan_id': perusahaanId,
      'last_message': '',
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  static Future<List<Map<String, dynamic>>> getChatListByUser(
    int userId,
  ) async {
    final db = await _getDB();

    return await db.rawQuery(
      '''
    SELECT 
      c.id AS room_id,
      p.id AS perusahaan_id,
      p.namaPerusahaan,
      p.photo_profile,
      c.last_message,
      c.updated_at

    FROM chat_room c
    JOIN perusahaan p ON p.id = c.perusahaan_id
    WHERE c.user_id = ?
    ORDER BY c.updated_at DESC
  ''',
      [userId],
    );
  }

  static Future<void> insertChatMessage({
    required int roomId,
    required String senderType,
    required String message,
  }) async {
    final db = await _getDB();

    await db.insert('chat_message', {
      'room_id': roomId,
      'sender_type': senderType,
      'message': message,
      'created_at': DateTime.now().toIso8601String(),
    });

    await db.update(
      'chat_room',
      {'last_message': message, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [roomId],
    );
  }

  static Future<List<Map<String, dynamic>>> getChatListByPerusahaan(
    int perusahaanId,
  ) async {
    final db = await _getDB();

    return await db.rawQuery(
      '''
    SELECT 
      c.id AS room_id,
      u.id AS user_id,
      u.fullname,
      u.photo_path,
      c.last_message,
      c.updated_at
    FROM chat_room c
    JOIN users u ON u.id = c.user_id
    WHERE c.perusahaan_id = ?
    ORDER BY c.updated_at DESC
    ''',
      [perusahaanId],
    );
  }

  static Future<int> updateCV({
    required int cvId,
    required String title,
    required String subtitle,
    required String tentangSaya,
    required String universitas,
    required String jurusan,
  }) async {
    final db = await _getDB();
    return await db.update(
      'cv',
      {
        'title': title,
        'subtitle': subtitle,
        'tentang_saya': tentangSaya,
        'universitas': universitas,
        'jurusan': jurusan,
      },
      where: 'id = ?',
      whereArgs: [cvId],
    );
  }

  static Future<Map<String, dynamic>?> getCVById(int cvId) async {
    final db = await _getDB();
    final result = await db.query('cv', where: 'id = ?', whereArgs: [cvId]);
    return result.isNotEmpty ? result.first : null;
  }

  static Future<Map<String, dynamic>?> getKontakByCV(int cvId) async {
    final db = await _getDB();
    final result = await db.query(
      'kontak',
      where: 'cv_id = ?',
      whereArgs: [cvId],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  static Future<List<Map<String, dynamic>>> getSkillByCV(int cvId) async {
    final db = await _getDB();
    return await db.query('skillCV', where: 'cv_id = ?', whereArgs: [cvId]);
  }

  static Future<List<Map<String, dynamic>>> getPengalamanByCV(int cvId) async {
    final db = await _getDB();
    return await db.query('pengalaman', where: 'cv_id = ?', whereArgs: [cvId]);
  }

  static Future<int> deleteCV(int cvId) async {
    final db = await _getDB();

    final rowsDeleted = await db.delete(
      'cv',
      where: 'id = ?',
      whereArgs: [cvId],
    );

    print("\x1B[31mCV DELETE SUCCESS — ROWS: $rowsDeleted\x1B[0m");

    return rowsDeleted;
  }

  static Future<int> deleteSkillByCV(int cvId) async {
    final db = await _getDB();

    return await db.delete('skillCV', where: 'cv_id = ?', whereArgs: [cvId]);
  }

  static Future<int> deletePengalamanByCV(int cvId) async {
    final db = await _getDB();

    return await db.delete('pengalaman', where: 'cv_id = ?', whereArgs: [cvId]);
  }

  static Future<int> deleteKontakByCV(int cvId) async {
    final db = await _getDB();

    return await db.delete('kontak', where: 'cv_id = ?', whereArgs: [cvId]);
  }

  static Future<List<Map<String, dynamic>>> getRekomendasiLowonganList(
    int userId,
  ) async {
    final db = await _getDB();

    // ambil skill user
    List<String> skills = await getSkillUser(userId);
    if (skills.isEmpty) return [];

    String likeQuery = skills.map((_) => "l.kategori LIKE ?").join(" OR ");
    List<String> likeArgs = skills.map((s) => "%$s%").toList();

    final res = await db.rawQuery('''
    SELECT 
      l.*,
      p.namaPerusahaan AS nama_perusahaan,
      p.photo_profile,
      p.photo_background
    FROM lowongan l
    JOIN perusahaan p ON p.id = l.perusahaan_id
    WHERE $likeQuery
    ORDER BY l.id DESC
  ''', likeArgs);

    return res;
  }

  static Future<List<Map<String, dynamic>>> searchLowongan(
    String keyword,
  ) async {
    final db = await _getDB();

    return await db.rawQuery(
      '''
    SELECT 
      l.*,
      p.namaPerusahaan AS nama_perusahaan,
      p.photo_profile
    FROM lowongan l
    JOIN perusahaan p ON p.id = l.perusahaan_id
    WHERE 
      l.posisi LIKE ? OR
      l.kategori LIKE ?
    ORDER BY l.id DESC
    ''',
      ['%$keyword%', '%$keyword%'],
    );
  }

  static Future<List<Map<String, dynamic>>> getUserForChatByPerusahaan(
    int perusahaanId,
  ) async {
    final db = await _getDB();

    return await db.rawQuery(
      '''
    SELECT DISTINCT
      u.id AS user_id,
      u.fullname,
      u.photo_path
    FROM lamaran l
    JOIN users u ON u.id = l.user_id
    WHERE l.perusahaan_id = ?
  ''',
      [perusahaanId],
    );
  }

  static Future<List<Map<String, dynamic>>> getPerusahaanForChatByUser(
  int userId,
) async {
  final db = await _getDB();

  return await db.rawQuery('''
    SELECT DISTINCT
      p.id AS perusahaan_id,
      p.namaPerusahaan,
      p.photo_profile
    FROM lamaran l
    JOIN perusahaan p ON p.id = l.perusahaan_id
    WHERE l.user_id = ?
  ''', [userId]);
}

}
