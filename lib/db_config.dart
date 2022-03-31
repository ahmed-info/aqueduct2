import 'package:aqueduct2/aqueduct2.dart';

class DbConfig extends Configuration {
  DbConfig(String path) : super.fromFile(File(path));
  DatabaseConfiguration database;
}
