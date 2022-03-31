import 'package:aqueduct2/aqueduct2.dart';
import 'package:aqueduct2/model/book.dart';

class BooksController extends ResourceController {
  BooksController(this.context);
  ManagedContext context;
  @Operation.get()
  Future<Response> getAllBooks() async {
    final q = Query<Book>(context);
    final books = await q.fetch();
    if (books == null) {
      return Response.notFound();
    }
    return Response.ok(books);
  }

  @Operation.get('id')
  Future<Response> getBookById(@Bind.path('id') int id) async {
    final q = Query<Book>(context)
      ..join(object: ((b) => b.author))
      ..where((b) => b.id).equalTo(id);
    final book = await q.fetchOne();
    if (book == null) {
      return Response.notFound();
    }
    return Response.ok(book);
  }
}
