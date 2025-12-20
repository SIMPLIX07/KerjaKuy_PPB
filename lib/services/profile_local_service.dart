import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../database/db_helper.dart';

class ProfileLocalService {
  static Future<String> saveProfileImage({
    required int userId,
    required File imageFile,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final profileDir = Directory('${dir.path}/profile_images');

    if (!await profileDir.exists()) {
      await profileDir.create(recursive: true);
    }

    final filePath = join(profileDir.path, 'user_$userId.jpg');
    final savedImage = await imageFile.copy(filePath);

    // simpan path ke SQLite
    final db = await DBHelper.getDBPublic();
    await db.update(
      'users',
      {'photo_path': savedImage.path},
      where: 'id = ?',
      whereArgs: [userId],
    );

    return savedImage.path;
  }
}
