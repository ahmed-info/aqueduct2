import 'package:aqueduct2/aqueduct2.dart';
import 'package:aqueduct2/model/product.dart';

class ProductController extends ResourceController {
  ProductController(this.context);
  ManagedContext context;

  @Operation.get()
  Future<Response> getAllProducts() async {
    final q = Query<Product>(context);
    final products = await q.fetch();
    return Response.ok(products);
  }

  @Operation.get('id')
  Future<Response> getProductById(@Bind.path('id') int id) async {
    final q = Query<Product>(context)..where((p) => p.id).equalTo(id);
    final product = await q.fetchOne();
    if (product == null) {
      return Response.notFound();
    }
    return Response.ok(product);
  }

  @Operation.post()
  Future<Response> createProduct(
      @Bind.body(ignore: ['id']) Product product) async {
    final q = Query<Product>(context)..values = product;
    final insertProduct = await q.insert();
    return Response.ok(insertProduct);
  }

  @Operation.put('id')
  Future<Response> updateProduct(
      @Bind.path('id') int id, @Bind.body() Product product) async {
    final q = Query<Product>(context)
      ..where((p) => p.id).equalTo(id)
      ..values = product;
    final updatedProduct = await q.updateOne();
    if (updatedProduct == null) {
      return Response.notFound();
    }
    return Response.ok(updatedProduct);
  }

  @Operation.delete('id')
  Future<Response> deleteProduct(@Bind.path('id') int id) async {
    final q = Query<Product>(context)..where((p) => p.id).equalTo(id);
    final selectedProduct = await q.fetchOne();
    if (selectedProduct == null) {
      return Response.notFound();
    }
    final affectProduct = await q.delete();
    if (affectProduct == 0) {
      return Response.notFound();
    }
    return Response.ok({'message': 'there are $affectProduct product remove'});
  }
}
