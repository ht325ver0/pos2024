import 'package:flutter/material.dart';
import '../models/Product.dart';

class CategoryButtons extends StatelessWidget{

  ///商品名(String)
  final String title;
  ///オプション(List<String>)
  final List<String> products;
  ///どのボタンが押されたか、商品が格納される変数(Productクラス)
  Product option;
  ///現在登録されている商品のリスト(List<Product>)
  final List<Product> P;

  CategoryButtons({
    Key? key, 
    required this.title,
    required this.products,
    required this.option,
    required this.P,
  }) : super(key: key);

  Product getProductClass(name){
    for(int i = 0; i < P.length; i++){
      if(name == this.P[i].name){
        return P[i];
      }
    }
    return P[0];
  }


  @override
  Widget build(BuildContext context){
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      width: 200,
      height: 900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 190,
            height: 25,
            margin: const EdgeInsets.all(3.0),
            color: const Color.fromARGB(248, 228, 227, 227),
            child: Center(child:Text(this.title, selectionColor: Color.fromARGB(255, 255, 254, 254),)),
          ),
          for(int i = 0; i < this.products.length; i++)...[
            ElevatedButton(                            
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 250, 233, 195),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
                ),
                minimumSize: const Size(190, 100),
              ),
              onPressed: () => option = getProductClass(products[i]),
              child: 
                Text(products[i]),
            ),
            Container(height: 10),
          ]
        ]
      ),
    );
                    
  }
}