import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

LazyDatabase openAppDatabaseConnection() {
  return LazyDatabase(() async {
    Directory dbFolder;
    try {
      dbFolder = await getApplicationDocumentsDirectory();
    } catch (_) {
      // Fallback for Linux desktops or environments without XDG dirs
      final home = Platform.environment['HOME'] ?? '/tmp';
      dbFolder = Directory(p.join(home, '.jurassic_dropshipping'));
      if (!dbFolder.existsSync()) {
        dbFolder.createSync(recursive: true);
      }
    }
    final file = File(p.join(dbFolder.path, 'jurassic_dropshipping.db'));
    return NativeDatabase.createInBackground(file);
  });
}
