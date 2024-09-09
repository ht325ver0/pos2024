import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore{

  final db = FirebaseFirestore.instance;


  Future<List<Map<String, dynamic>>> getProductCollection() async { 

    CollectionReference collectionRef = db.collection('productCollection');
    QuerySnapshot querySnapshot = await collectionRef.get();

    List<Map<String, dynamic>> ProductCollection = querySnapshot.docs
      .map((doc) => doc.data() as Map<String, dynamic>)
      .toList();

    return ProductCollection;
  }
}