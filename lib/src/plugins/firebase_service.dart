import 'package:cloud_firestore/cloud_firestore.dart';


final Firestore firestore = Firestore.instance;
                
Stream<DocumentReference> addDocument(String colletion, {Map<String, dynamic> data,String id}) {
  if(id==null)
    return firestore.collection(colletion).add(data).asStream();
  return firestore.collection(colletion).document(id).setData(data).asStream();
}

Stream updateDocument(String colletion, String id, Map<String, dynamic> data) {
  return firestore
      .collection(colletion)
      .document(id)
      .updateData(data)
      .asStream();
}

Future<QuerySnapshot> getDocuments(String colletion,[String order]) {
  if (order == null)
    return firestore.collection(colletion).getDocuments();
  else
    return firestore.collection(colletion).orderBy(order).getDocuments();
}

Stream<QuerySnapshot> getDocumentsStream(String colletion) {
  return firestore.collection(colletion).snapshots();
}

Future<bool> userExist(String colletion, String id) async {
  final user = await firestore.collection(colletion).document(id).get();
  return user.exists;
}


Future<DocumentSnapshot> getDocument(String colletion,String id){
   return firestore.collection(colletion).document(id).get();
}

Future<QuerySnapshot> queryGetDocumento(String colletion,String campo,String valor){
   return firestore.collection(colletion).where(campo,isEqualTo: valor).getDocuments();
}

 Stream deleteDocument(String colletion,String id){
  return firestore.collection(colletion).document(id).delete().asStream();
}