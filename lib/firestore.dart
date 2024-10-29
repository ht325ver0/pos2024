import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pos2024/models/Product.dart';
import 'package:pos2024/models/SelectedProduct.dart';
import 'package:intl/intl.dart';
import 'package:pos2024/pages/OderPage.dart';

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
    }catch (e) {
      print("Error adding data: $e");
    }
  }
  


  Future<void> addServedProductWithLoading(BuildContext context, List<SelectedProduct> product, int number, int totalPrice, String payment,  Map<DateTime,List<SelectedProduct>> waitingOder) async {
  try{
  // ローディング画面を表示
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // 通信が完了するまで待つ
    await addServedProduct(product, number, totalPrice, payment);

    // 通信が完了したらローディング画面を閉じる
    Navigator.of(context).pop();

    

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('会計完了',style: TextStyle(fontSize: 24)),
          actions: [
            TextButton(
              child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
          ],
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text('以下の内容の注文を登録しました.',style: TextStyle(fontSize: 20)),
                Text('呼び出し番号:${number}番',style: TextStyle(fontSize: 18)),
                Container(
                  color: Color.fromARGB(248, 247, 195, 131),
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      for (var i in product)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              color: Color.fromARGB(248, 255, 255, 255),
                              child: Text(
                                '${i.object.name}(${i.object.options[i.optionNumber]}) 個数: ${i.oderPieces}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          

                            
        );
        },
      );

    
    Navigator.push(
        context,
        MaterialPageRoute(builder:(context){
          return OderPage(
            title: '注文ページ',
            waitingOder: waitingOder,
            customerCounter: number
          );
        })
      );
  }catch(e) {
    debugPrint('Erorro:$e');
  }
  }

  Future<void> addServedProduct(List<SelectedProduct> product, int number, int totalPrice, String payment) async {
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String sNumber = number.toString();
    DocumentReference todayData = db.collection('servedProduct').doc(todayDate);

    try {
      List<Future<void>> futures = [];

      for (int i = 0; i < product.length; i++) {
        futures.add(
          todayData.collection(sNumber).doc(i.toString()).set({
            'productName': product[i].object.name,
            'quantity': product[i].oderPieces,
            'option': product[i].optionNumber,
            'time': DateTime.now(),
          })
        );
      }

      

      await todayData.collection(sNumber).doc('Info').set({
        'served': false,
        'cooked': false,
        'totalPrice': totalPrice,
        'payment': payment,
        'id': number
      });
      await todayData.set({'oderCounter': number});

    } catch (e) {
      print("Error adding data: $e");
    }
  }

}
