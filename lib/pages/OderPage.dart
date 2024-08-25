import 'package:flutter/material.dart';
import 'package:pos2024/models/SelectedProduct.dart';
import 'package:pos2024/widgets/CategoryButton.dart';
import 'package:pos2024/models/Product.dart';
import 'package:pos2024/widgets/OptionButton.dart';
import 'package:pos2024/widgets/Quantity.dart';
import 'package:pos2024/models/SelectedProduct.dart';
import 'package:pos2024/widgets/Cart.dart';

class OderPage extends StatefulWidget {
  const OderPage({super.key, required this.title});

  final String title;



  @override
  State<OderPage> createState() => _OderPage();
}

class _OderPage extends State<OderPage> {
  int selectedItem = 0;

  Product GrilledChickenThigh = Product(name: '焼き鳥(もも)', stock: 100, prise: 100, options: ['塩','甘口','中辛','辛口','デス']);
  Product GrilledChickenSkin = Product(name: '焼き鳥(かわ)', stock: 100, prise: 100, options: ['塩','甘口','中辛','辛口','デス']);
  Product Mo = Product(name: 'もちょ', stock: 100, prise: 100, options: ['あん','カスタ']);
  ///商品名ボタンで選択された商品のオブジェクト
  Product selectedProductObject = Product(name: '', stock: 0, prise: 0, options: []);
  int selectedProductOption = 0;
  int selectedProductQuantity = 1;
  String memo = '';
  List<SelectedProduct> selectedProducts = [];

  void updateName(Product newProduct) {
    setState(() {
      selectedProductObject = newProduct;
      selectedProductOption = 0;
    });
  }
  void updateOption(int newOption) {
    setState(() {
      selectedProductOption = newOption;
    });
  }


  void getObject(){
    setState(() {
      selectedProducts.add(
        SelectedProduct(object:this.selectedProductObject, optionNumber:this.selectedProductOption, oderPieces: selectedProductQuantity, memo: this.memo)
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 233, 230),
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: const Alignment(-0.9,-0.9),
                    child: Container(
                      color: const Color.fromARGB(255, 255, 255, 255),//・合計金額・決済に進むためのボタン
                      width: 450,
                      height: 200,
                      child: Text('合計金額'),
                    ),
                  ),
                  Container(
                    alignment: const Alignment(0,0),
                    child: CartWidget(selectedProducts: selectedProducts),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Container(
                color: const Color.fromARGB(255, 255, 162, 13),//右側の土台
                width: 800,
                height: 800,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: const Alignment(-0.9,-0.9),
                      child: CategoryButton(
                        title:'商品名',
                        products:[GrilledChickenThigh.name,GrilledChickenSkin.name,Mo.name], //実装後は変数とかにする
                        selectedProduct: selectedProductObject,
                        P:[GrilledChickenThigh,GrilledChickenSkin,Mo],//実装後は変数とかにする
                        buttonUpdate: updateName,
                      ),
                    ),
                    Container(
                      alignment: const Alignment(-0.9,-0.9),
                      child: OptionButton(
                        onOptionSelected: updateOption,
                        title: 'オプション',
                        options: selectedProductObject.options,
                        selectedOption: selectedProductOption,
                        )
                    ),
                    Container(
                      alignment: const Alignment(0.9,-1),
                      child: Container(
                       //いっちゃん右(本数とか多分ダイアログとかにすると使いやすい)
                        width: 390,
                        height: 800,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Quantity(
                              title: '個数', 
                              index: selectedProductQuantity,
                              onQuantityChange: (newQuantity) {
                                setState(() {
                                  selectedProductQuantity = newQuantity;
                                });
                              },
                            ),
                            Container(height: 5,),
                            Container(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              width: 390,
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 380,
                                    height: 25,
                                    margin: const EdgeInsets.all(3.0),
                                    color: const Color.fromARGB(248, 228, 227, 227),
                                    child: Center(child:Text('メモ',selectionColor: Color.fromARGB(255, 255, 254, 254),)),
                                  ),
                                  TextFormField(
                                    maxLines: 5,
                                    onChanged: (value){
                                      memo = value;
                                    },
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      hintText: "Text",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide(
                                          width: 0.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide(
                                          width: 0.5,
                                        )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(height:5),
                            Container(height: 83, width: 390, color: Color.fromARGB(255, 255, 255, 255),),
                            Container(height:5),
                            Container(
                              width: 390,
                              height: 195,
                              color: Color.fromARGB(255, 255, 255, 255),
                              child:  Container(
                                width: 100,
                                height: 120,
                                child: ElevatedButton(                         
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    minimumSize: const Size(10,10),
                                  ),
                                  onPressed: () => getObject(),
                                  child: 
                                    Text('カートに追加'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),          
                  ],
                ),
              ),
            ),   
          ],
        ),
      ),
    

            

//'一本ずつ注文（種類、味、本数をスクロールバー？的なので実装）'),
                  

//'できれば本数を簡単に+-できるボタンも欲しい,簡単なメモができるのもあるといい'),
                 


           
  

      drawer: const Drawer(child:Center(child:Text("注文画面、在庫管理画面(グラフ的なものも欲しい)、金調整"))),
    );
  }
}
