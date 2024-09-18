import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pos2024/models/Product.dart';
import 'package:pos2024/models/SelectedProduct.dart';
import 'package:intl/intl.dart';

class Firestore{

  final db = FirebaseFirestore.instance;

  Future<List<Product>> getProductList() async {
  try {
    CollectionReference collectionRef = db.collection('productCollection');
    debugPrint('Fetching data from Firestore...');
    QuerySnapshot querySnapshot = await collectionRef.get();
    debugPrint('Data fetched successfully');

    if (querySnapshot.docs.isEmpty) {
      debugPrint('No documents found in the collection');
    }

    List<Product> productList = querySnapshot.docs.map((doc) {
      debugPrint('Document data: ${doc.data()}');
      return Product.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();

    debugPrint('Product list length: ${productList.length}');
    return productList;
  } catch (e) {
    debugPrint('Error: $e');
    return [];
  }
}

  Future<void> addServedProduct(List<SelectedProduct> product, int number) async {
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String sNumber = number.toString();

    
    for(int i = 0; i < product.length; i++){
      try{
        await db.collection('servedProduct').doc(todayDate).collection(sNumber).add({
          'productName': product[i].object.name,
          'quantity': product[i].oderPieces,
          'option': product[i].getOptionString(),
          'time': DateTime.now()
        });
      }
      catch (e) {
        print("Error adding data: $e");
      }
    }
  }
}
