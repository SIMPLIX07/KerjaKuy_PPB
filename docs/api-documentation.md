project:
  name: KerjaKuy
  description: >
    KerjaKuy adalah aplikasi pencarian kerja berbasis Flutter yang menggunakan
    SQLite (Sqflite) sebagai database lokal. API yang digunakan merupakan
    Internal API (Service Layer) yang diimplementasikan melalui class DBHelper.
  type: Mobile Application
  api_type: Internal API (Non-REST)
  database: SQLite (Sqflite)

technology:
  language: Dart
  framework: Flutter
  database_engine: Sqflite

architecture:
  flow:
    - User / Perusahaan
    - Flutter UI
    - Validation Layer
    - DBHelper (Internal API)
    - SQLite Database

authentication:
  user:
    register:
      service: DBHelper.registerUser
      parameters:
        fullname: String
        username: String
        email: String
        password: String
      response:
        userId: Integer
    login:
      service: DBHelper.loginUser
      parameters:
        usernameOrEmail: String
        password: String
      response:
        id: Integer
        fullname: String
        email: String
        pekerjaan: String

user_api:
  get_by_id:
    service: DBHelper.getUserById
    parameters:
      userId: Integer
  get_user_data:
    service: DBHelper.getUserData
    parameters:
      userId: Integer
  update_photo:
    service: DBHelper.updateUserPhoto
    parameters:
      userId: Integer
      photoPath: String
  update_job_title:
    service: DBHelper.updateUserJobTitle
    parameters:
      userId: Integer
      newTitle: String

skill_api:
  add_skill:
    service: DBHelper.tambahSkill
    parameters:
      userId: Integer
      namaSkill: String
  get_skill_user:
    service: DBHelper.getSkillUser
    parameters:
      userId: Integer
    response:
      skills: List<String>

perusahaan_api:
  register:
    service: DBHelper.registerPerusahaan
    parameters:
      namaPerusahaan: String
      email: String
      password: String
      alamat: String
      deskripsi: String
      noTelepon: String
  login:
    service: DBHelper.loginPerusahaan
    parameters:
      email: String
      password: String
  get_by_id:
    service: DBHelper.getPerusahaanById
    parameters:
      perusahaanId: Integer
  update:
    service: DBHelper.updatePerusahaan
    parameters:
      perusahaanId: Integer
      email: String
      alamat: String
      deskripsi: String
      noTelepon: String
      photoProfile: String
      photoBackground: String

lowongan_api:
  insert:
    service: DBHelper.insertLowongan
    parameters:
      perusahaanId: Integer
      nama_perusahaan: String
      kategori: String
      posisi: String
      deskripsi: String
      syarat: String
      gaji: String
      tipe: String
      periodeAwal: String
      periodeAkhir: String
      lokasi: String
  get_all:
    service: DBHelper.getLowongan
  get_by_id:
    service: DBHelper.findLowonganById
    parameters:
      id: Integer
  get_detail:
    service: DBHelper.getDetailLowongan
    parameters:
      lowonganId: Integer
  search:
    service: DBHelper.searchLowongan
    parameters:
      keyword: String
  rekomendasi_single:
    service: DBHelper.getRekomendasiLowongan
    parameters:
      userId: Integer
  rekomendasi_list:
    service: DBHelper.getRekomendasiLowonganList
    parameters:
      userId: Integer

lamaran_api:
  insert:
    service: DBHelper.insertLamaran
    parameters:
      lowongan_id: Integer
      user_id: Integer
      perusahaan_id: Integer
      cv_id: Integer
  get_by_user:
    service: DBHelper.getLamaranByUserId
    parameters:
      userId: Integer
  get_pelamar_by_lowongan:
    service: DBHelper.getPelamarByLowongan
    parameters:
      lowonganId: Integer
  reject_pelamar:
    service: DBHelper.tolakPelamar
    parameters:
      userId: Integer
      lowonganId: Integer
      perusahaanId: Integer
  accept_and_reject_others:
    service: DBHelper.acceptPelamarDanTolakYangLain
    parameters:
      userId: Integer
      perusahaanIdDiterima: Integer
      lowonganIdDiterima: Integer

cv_api:
  insert:
    service: DBHelper.insertCV
    parameters:
      userId: Integer
      pendidikan: String
      umur: Integer
      tentangSaya: String
      universitas: String
      jurusan: String
      kontak: String
      title: String
      subtitle: String
  update:
    service: DBHelper.updateCV
    parameters:
      cvId: Integer
      title: String
      subtitle: String
      tentangSaya: String
      universitas: String
      jurusan: String
  delete:
    service: DBHelper.deleteCV
    parameters:
      cvId: Integer
  get_by_id:
    service: DBHelper.getCVById
    parameters:
      cvId: Integer
  get_by_user:
    service: DBHelper.getCVByUserId
    parameters:
      userId: Integer

cv_detail_api:
  skill:
    insert:
      service: DBHelper.insertSkillCV
      parameters:
        cvId: Integer
        skill: String
        kemampuan: Integer
    get:
      service: DBHelper.getSkillByCV
      parameters:
        cvId: Integer
    delete:
      service: DBHelper.deleteSkillByCV
      parameters:
        cvId: Integer
  pengalaman:
    insert:
      service: DBHelper.insertPengalaman
      parameters:
        cvId: Integer
        pengalaman: String
        durasi: String
    get:
      service: DBHelper.getPengalamanByCV
      parameters:
        cvId: Integer
    delete:
      service: DBHelper.deletePengalamanByCV
      parameters:
        cvId: Integer
  kontak:
    insert:
      service: DBHelper.insertKontak
      parameters:
        cvId: Integer
        email: String
        noTelepon: String
        linkedIn: String
    get:
      service: DBHelper.getKontakByCV
      parameters:
        cvId: Integer
    delete:
      service: DBHelper.deleteKontakByCV
      parameters:
        cvId: Integer

wawancara_api:
  create:
    service: DBHelper.buatWawancara
    parameters:
      userId: Integer
      perusahaanId: Integer
      lowonganId: Integer
      jamMulai: String
      jamSelesai: String
      tanggal: String
      linkMeet: String
      pesan: String
  get_by_user:
    service: DBHelper.getWawancaraByUserId
    parameters:
      userId: Integer
  get_by_perusahaan:
    service: DBHelper.getWawancaraByPerusahaanId
    parameters:
      perusahaanId: Integer
  update_status:
    service: DBHelper.updateStatusPelamar
    parameters:
      wawancaraId: Integer
      userId: Integer
      lowonganId: Integer
      status: String

chat_api:
  create_or_get_room:
    service: DBHelper.createOrGetChatRoom
    parameters:
      userId: Integer
      perusahaanId: Integer
  send_message:
    service: DBHelper.insertChatMessage
    parameters:
      roomId: Integer
      senderType: String
      message: String
  chat_list_user:
    service: DBHelper.getChatListByUser
    parameters:
      userId: Integer
  chat_list_perusahaan:
    service: DBHelper.getChatListByPerusahaan
    parameters:
      perusahaanId: Integer

berita_api:
  get_all:
    service: DBHelper.getBerita

error_handling:
  duplicate_data: SQLite UNIQUE constraint
  empty_result: Return null or empty list
  invalid_input: UI validation
