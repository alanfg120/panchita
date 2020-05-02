import 'package:panchita/src/componentes/productos/models/producto_model.dart';
import 'package:panchita/src/plugins/firebase_service.dart';

class ProductoRepocitorio {

  final String colletionCategorias = 'categorias';
  final String colletionMarcas     = 'marcas';
  final String colletionProductos  = 'productos';

  Future<List> getCategorias() async {
    final categorias =  await getDocument(colletionCategorias, "v8Y9rDVNqd0QHCzprsiA");
    return categorias.data['categorias'];
  }
  Future<List> getMarcas() async {
    final marcas =  await getDocument(colletionMarcas, "XSWX06SVV6sydXJBlZ1e");
    return marcas.data['marcas'];
  }

  Future<List<Producto>> getProductos() async{
       final productos = await getDocuments(colletionProductos);
       return productos.documents.map((p)=>Producto.map(p)).toList();
    
  }
}
