import 'package:drift/native.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';

/// Creates a fresh in-memory AppDatabase for testing.
/// Each call returns a new isolated database.
AppDatabase createTestDatabase() {
  return AppDatabase.forTesting(NativeDatabase.memory());
}
