import 'package:flutter/material.dart';
import '../models/Product.dart';

class CategoryButtons extends StatelessWidget{

  final String title;
  final List<String> products;
  String option;

  CategoryButtons({
    Key? key, 
    required this.title,
    required this.products,
    this.option = '',
  }) : super(key: key);


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
              onPressed: () => this.option = products[i],
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