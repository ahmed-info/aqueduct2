import 'package:aqueduct2/aqueduct2.dart';
import 'package:aqueduct2/model/author.dart';

class Book extends ManagedObject<_Book> implements _Book {}

@Table(name: 'books')
class _Book {
  @primaryKey
  int id;
  String name;
  @Relate(#books)
  Author author;
}
