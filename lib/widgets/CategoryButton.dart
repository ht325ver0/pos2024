import 'package:flutter/material.dart';
import '../models/Product.dart';

class CategoryButton extends StatefulWidget{

  CategoryButton({
    Key? key, 
    required this.height,
    required this.width,
    required this.title,
    required this.products,
    required this.selectedProduct,
    required this.P,
    required this.buttonUpdate,
  }) : super(key: key);

  final double height;

  final double width;

  ///商品名(String)
  final String title;
  ///オプション(List<String>)
  final List<String> products;
  ///どのボタンが押されたか、商品が格納される変数(Productクラス)
  Product selectedProduct;
  ///現在登録されている商品のリスト(List<Product>)
  List<Product> P;
  ///更新するための関数名(Function)
  Function buttonUpdate;

  @override
  State<CategoryButton> createState() => _CategoryButton();
}

class _CategoryButton extends State<CategoryButton>{



///商品名(String)を引数に、その商品のクラスを返す
  Product getProductClass(String name){
    for(int i = 0; i < widget.P.length; i++){
      if(name == widget.P[i].name){
        return widget.P[i];
      }
    }
    return Product(name: '', stock: 0, price: 0, options: []);
  }

  void onButtonPressed(String productName) {
    Product selected = getProductClass(productName);
    setState(() {
      if (productName == widget.selectedProduct.name) {
        selected = Product(name: '', stock: 0, price: 0, options: []);
      }
      widget.selectedProduct = selected;
    });
    widget.buttonUpdate(selected);
  }

  @override
  Widget build(BuildContext context){


    
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      width: widget.width,
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: widget.width * 0.95,
            height: widget.height * 0.05,
            margin: const EdgeInsets.all(3.0),
            color: const Color.fromARGB(248, 228, 227, 227),
            child: Center(child:Text(widget.title, selectionColor: Color.fromARGB(255, 255, 254, 254),style: TextStyle(fontSize: 18),)),
          ),
          for(int i = 0; i < widget.products.length; i++)...[
            ElevatedButton(                            
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.products[i] == widget.selectedProduct.name
                    ? Color.fromARGB(255, 165, 154, 129)
                    : Color.fromARGB(255, 250, 233, 195),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                minimumSize: Size(widget.width * 0.95, widget.height * 0.20),
              ),
              onPressed: () => onButtonPressed(widget.products[i]),
              child: 
                Text(widget.products[i],style: TextStyle(fontSize: 22)),
            ),
            Container(height: 10),
          ]
        ]
      ),
    );        
  }
}