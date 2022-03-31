import 'package:aqueduct2/controller/authors_controller.dart';
import 'package:aqueduct2/controller/books_controller.dart';
import 'package:aqueduct2/controller/category_controller.dart';
import 'package:aqueduct2/controller/product_controller.dart';
import 'package:aqueduct2/db_config.dart';
import 'package:aqueduct2/model/author.dart';
import 'package:aqueduct2/model/book.dart';
import 'package:aqueduct2/model/category.dart';
import 'package:aqueduct2/model/product.dart';

import 'aqueduct2.dart';

class Aqueduct2Channel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final dbConf = DbConfig(options.configurationFilePath);
    final tables = ManagedDataModel([Category, Product, Author, Book]);
    //OR
    //final tables = ManagedDataModel.fromCurrentMirrorSystem();

    final dbConnection = PostgreSQLPersistentStore.fromConnectionInfo(
        dbConf.database.username,
        dbConf.database.password,
        dbConf.database.host,
        dbConf.database.port,
        dbConf.database.databaseName);
    context = ManagedContext(tables, dbConnection);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });
    router.route('/about').linkFunction((request) async {
      return Response.ok('About page');
    });
    router.route('/categories/[:id]').link(() => CategoryController(context));
    router
        .route('/categories/:categoryId/products')
        .link(() => CategoryController(context));
    router.route('/products/[:id]').link(() => ProductController(context));
    router.route('/authors/[:id]').link(() => AuthorsController(context));
    router.route('/books/[:id]').link(() => BooksController(context));
    return router;
  }
}
