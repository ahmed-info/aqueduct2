import 'package:aqueduct/aqueduct.dart';
import 'package:aqueduct2/model/category.dart';

@Table(name: 'products')
class Product extends ManagedObject<_Product> implements _Product {}

class _Product {
  @primaryKey
  int id;
  String name;
  double price;
  @Relate(#products)
  Category category;
}
