import 'package:flutter/material.dart';
import '../models/Product.dart';

class CategoryButtons extends StatefulWidget{

  CategoryButtons({
    Key? key, 
    required this.title,
    required this.products,
    required this.option,
    required this.P,
    required this.buttonUpdate,
  }) : super(key: key);

  ///商品名(String)
  final String title;
  ///オプション(List<String>)
  final List<String> products;
  ///どのボタンが押されたか、商品が格納される変数(Productクラス)
  Product option;
  ///現在登録されている商品のリスト(List<Product>)
  final List<Product> P;
  ///更新するための関数名(Function)
  Function buttonUpdate;

  @override
  State<CategoryButtons> createState() => _CategoryButtonsState();
}

class _CategoryButtonsState extends State<CategoryButtons>{

///商品名(String)を引数に、その商品のクラスを返す
  Product getProductClass(String name){
    for(int i = 0; i < widget.P.length; i++){
      if(name == widget.P[i].name){
        return widget.P[i];
      }
    }
    return widget.P[0];
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
            child: Center(child:Text(widget.title, selectionColor: Color.fromARGB(255, 255, 254, 254),)),
          ),
          for(int i = 0; i < widget.products.length; i++)...[
            ElevatedButton(                            
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.products[i] == widget.option.name
                    ? Color.fromARGB(255, 165, 154, 129)
                    : Color.fromARGB(255, 250, 233, 195),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                minimumSize: const Size(190, 100),
              ),
              onPressed: () {
                Product selectedProduct = getProductClass(widget.products[i]);
                setState(() {
                  widget.option = selectedProduct;
                });
                widget.buttonUpdate(selectedProduct);
              },
              child: 
                Text(widget.products[i]),
            ),
            Container(height: 10),
          ]
        ]
      ),
    );
                    
  }
}