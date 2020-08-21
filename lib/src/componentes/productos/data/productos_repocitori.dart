import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';
import 'package:panchita/src/plugins/firebase_service.dart';

class ProductoRepocitorio {

  final String colletionCategorias = 'categorias';
  final String colletionMarcas = 'marcas';
  final String colletionProductos = 'productos';
  
  Stream<DocumentReference> setProducto(Producto producto){
    return addDocument(colletionProductos,data:{
      "codigo"         : producto.codigo,
      "nombre"         : producto.nombre,
      "categoria"      : producto.categoria,
      "marca"          : producto.marca,
      "ruta1"          : producto.precioUno,
      "ruta2"          : producto.precioDos,
      "ruta3"          : producto.precioTres,
      "url_foto"       : ''
   });
}

  Future<List> getCategorias() async {
    final categorias =
        await getDocument(colletionCategorias, "v8Y9rDVNqd0QHCzprsiA");
    return categorias.data['categorias'];
  }

  Future<List> getMarcas() async {
    final marcas = await getDocument(colletionMarcas, "XSWX06SVV6sydXJBlZ1e");
    return marcas.data['marcas'];
  }

  Future<List<Producto>> getProductos() async {
    final productos = await getDocuments(colletionProductos);
    return productos.documents.map((p) => Producto.map(p)).toList();
  }

  Future<List<Producto>> filterProducto(String campo, String valor) async {
    final productos = await queryGetDocumento(colletionProductos,campo,valor);
    return productos.documents.map((p) => Producto.map(p)).toList();
  }

  
}
