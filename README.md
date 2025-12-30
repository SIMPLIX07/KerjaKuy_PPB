# KerjaKuy

KerjaKuy adalah aplikasi pencarian kerja berbasis Flutter yang dirancang untuk mempertemukan **pelamar kerja** dan **perusahaan**.  
Aplikasi ini menggunakan **SQLite (Sqflite)** sebagai database lokal dan menerapkan konsep **Internal API (Service Layer)** untuk mengelola data dan logika bisnis.

Project ini dibuat untuk keperluan akademik.

---

## API Documentation

Project ini menggunakan **Internal API berbasis SQLite** yang diimplementasikan melalui class `DBHelper`.

Dokumentasi API menjelaskan:
- Proses registrasi & login
- Manajemen user dan perusahaan
- Lowongan pekerjaan
- Lamaran kerja
- CV dan skill
- Wawancara
- Fitur chat

**[Lihat API Documentation](docs/api-documentation.md)**

---

## Fitur Utama

###  Pelamar
- Registrasi & Login
- Manajemen Profil
- Manajemen CV & Skill
- Melamar Lowongan
- Melihat Status Lamaran
- Jadwal Wawancara
- Chat dengan Perusahaan

### Perusahaan
- Registrasi & Login
- Manajemen Profil Perusahaan
- Membuat & Mengelola Lowongan
- Melihat Daftar Pelamar
- Menjadwalkan Wawancara
- Menerima / Menolak Pelamar
- Chat dengan Pelamar

---

## Teknologi yang Digunakan

| Teknologi | Keterangan |
|---------|-----------|
| Flutter | Framework frontend |
| Dart | Bahasa pemrograman |
| Sqflite | Database lokal (SQLite) |
| Internal API | Service Layer (`DBHelper`) |

---

## Struktur Project

```text
kerjakuy/
├── lib/                 # Source code Flutter
├── assets/              # Asset gambar & resource
├── docs/                # Dokumentasi
│   └── api-documentation.md
├── pubspec.yaml
└── README.md
