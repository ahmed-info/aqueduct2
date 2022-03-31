import 'package:aqueduct/aqueduct.dart';
import 'package:aqueduct2/model/product.dart';

@Table(name: 'categories')
class Category extends ManagedObject<_Category> implements _Category {}

class _Category {
  @primaryKey
  int id;
  String name;
  ManagedSet<Product> products;
}
