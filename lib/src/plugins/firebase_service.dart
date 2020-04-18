import 'package:cloud_firestore/cloud_firestore.dart';


final Firestore firestore = Firestore.instance;

Stream addDocument(String colletion, String id, Map<String, dynamic> data) {
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

Future<bool> userExist(String colletion, String id) async {
  final user = await firestore.collection(colletion).document(id).get();
  return user.exists;
}


Future<DocumentSnapshot> getDocument(String colletion,String id){
   return firestore.collection(colletion).document(id).get();
}