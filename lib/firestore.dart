import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pos2024/models/Product.dart';
import 'package:pos2024/models/SelectedProduct.dart';
import 'package:intl/intl.dart';

class Firestore{

  final db = FirebaseFirestore.instance;

  Future<int> getCustomerCounte() async {

    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    var todayData = await db.collection('servedProduct').doc(today).get();

    int counte;

    if(todayData.exists){
      counte = todayData.get('oderCounter');
    }else{
      counte = 0;
    }
//customerCOunter修正からとりあえず情報は取れてることわかったから
    debugPrint('$counte');

    return counte;
  }

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

  Future<void> writeCashInfo(int totalPrice, String payment,int number) async {
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String sNumber = number.toString();

    try{
        await db.collection('servedProduct').doc(todayDate).collection(sNumber).doc('Info').set({
          'totalPrice': totalPrice,
          'payment': payment,
        });
      }
      catch (e) {
        print("Error adding data: $e");
      }
    }
  


  Future<void> addServedProduct(List<SelectedProduct> product, int number, int totalPrice, String payment) async {
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String sNumber = number.toString();

    
    for(int i = 0; i < product.length; i++){
      try{
        DocumentReference todayData = db.collection('servedProduct').doc(todayDate);
        await todayData.collection(sNumber).doc(i.toString()).set({
          'productName': product[i].object.name,
          'quantity': product[i].oderPieces,
          'option': product[i].optionNumber,
          'time': DateTime.now(),
        });
        todayData.collection(sNumber).doc('Info').set({
          'served': false,
          'totalPrice': totalPrice,
          'payment': payment,
          'id': number
        });
        await todayData.set({'oderCounter': number,});

      }
      catch (e) {
        print("Error adding data: $e");
      }
    }
  }
}
