import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

LazyDatabase openAppDatabaseConnection() {
  return LazyDatabase(() async {
    // Pure-dart directory resolution so non-Flutter scripts (e.g. local API server)
    // can open the same DB file without pulling in Flutter plugins.
    final userProfile = Platform.environment['USERPROFILE'];
    final home = Platform.environment['HOME'];

    Directory dbFolder;
    if (Platform.isWindows && userProfile != null) {
      // Mirrors typical `getApplicationDocumentsDirectory()` behavior on Windows.
      dbFolder = Directory(p.join(userProfile, 'Documents'));
    } else if (home != null) {
      // Reasonable fallback for Linux/macOS / headless environments.
      dbFolder = Directory(p.join(home, '.jurassic_dropshipping'));
    } else {
      dbFolder = Directory(p.join(Directory.current.path, '.jurassic_dropshipping'));
    }

    if (!dbFolder.existsSync()) {
      dbFolder.createSync(recursive: true);
    }
    final file = File(p.join(dbFolder.path, 'jurassic_dropshipping.db'));
    return NativeDatabase.createInBackground(file);
  });
}
