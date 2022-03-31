import 'dart:js';

import 'package:aqueduct2/aqueduct2.dart';
import 'package:aqueduct2/model/author.dart';

class AuthorsController extends ResourceController {
  AuthorsController(this.context);
  ManagedContext context;
  @Operation.get()
  Future<Response> getAllAuthors() async {
    final q = Query<Author>(context);
    final authors = await q.fetch();
    if (authors == null) {
      return Response.notFound();
    }
    return Response.ok(authors);
  }

  @Operation.get('id')
  Future<Response> getAuthorById(@Bind.path('id') int id) async {
    final q = Query<Author>(context)
      ..join(set: ((a) => a.books))
      ..where((a) => a.id).equalTo(id);
    final author = await q.fetchOne();
    if (author == null) {
      return Response.notFound();
    }
    return Response.ok(author);
  }
}
