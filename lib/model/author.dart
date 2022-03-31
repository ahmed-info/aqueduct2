import 'package:aqueduct2/aqueduct2.dart';
import 'package:aqueduct2/model/book.dart';

class Author extends ManagedObject<_Author> implements _Author {}

@Table(name: 'authors')
class _Author {
  @primaryKey
  int id;
  String name;
  ManagedSet<Book> books;
}
