import 'package:flutter/material.dart';
import 'package:pos2024/models/SelectedProduct.dart';
import 'package:pos2024/pages/CasherPage.dart';
import 'package:pos2024/widgets/CategoryButton.dart';
import 'package:pos2024/models/Product.dart';
import 'package:pos2024/widgets/OptionButton.dart';
import 'package:pos2024/widgets/Quantity.dart';
import 'package:pos2024/models/SelectedProduct.dart';
import 'package:pos2024/widgets/Cart.dart';

class OderPage extends StatefulWidget {
  OderPage({super.key, required this.title, required this.waitingOder});

  final String title;
  Map<DateTime,List<SelectedProduct>> waitingOder;

  @override
  State<OderPage> createState() => _OderPage();
}

class _OderPage extends State<OderPage> {
  int selectedItem = 0;

  Product GrilledChickenThigh = Product(name: '焼き鳥(もも)', stock: 100, prise: 100, options: ['塩','甘口','中辛','辛口','デス']);
  Product GrilledChickenSkin = Product(name: '焼き鳥(かわ)', stock: 100, prise: 100, options: ['塩','甘口','中辛','辛口','デス']);
  ///商品名ボタンで選択された商品のオブジェクト
  Product selectedProductObject = Product(name: '', stock: 0, prise: 0, options: []);
  int selectedProductOption = 0;
  int selectedProductQuantity = 1;
  String memo = '';
  List<SelectedProduct> selectedProducts = [];
  int totalPrice = 0;

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

  void addCart(){
    getObject();
    getTotalPrice();
  }

  void getObject(){
    setState(() {
      selectedProducts.add(
        SelectedProduct(object:this.selectedProductObject, optionNumber:this.selectedProductOption, oderPieces: selectedProductQuantity, memo: this.memo)
      );
    });
  }

  void getTotalPrice(){
    setState(() {
      for(int i = 0; i < selectedProducts.length; i++){
        totalPrice += selectedProducts[i].calculatSubtotal();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 233, 230),
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),

        actions: [
          TextButton.icon(
            onPressed: ()=>Navigator.push(
              context,
              MaterialPageRoute(builder:(context){
                return CasherPage(title: '会計ページ',selectedProducts: selectedProducts, waitingOder: widget.waitingOder);
              })
            ),
            icon: const Icon(Icons.point_of_sale),
            label: const Text('会計',selectionColor: Color.fromARGB(0, 0, 100, 0),),
          ),
        ],
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
                      width: screenWidth * 0.35,
                      height: screenHeight * 0.25,
                      child: Row(children: [Text('合計金額'),Text('$totalPrice 円')]),
                    ),
                  ),
                  Container(
                    alignment: const Alignment(0,0),
                    child: Container(
                      width: screenWidth * 0.35,
                      height: screenHeight * 0.62,
                      child: CartWidget(selectedProducts: selectedProducts)),
                  ),
                  Container()
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Container(
                color: const Color.fromARGB(255, 255, 162, 13),//右側の土台
                width: screenWidth * 0.625,
                height: screenHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: const Alignment(-0.9,-0.9),
                      child: CategoryButton(
                        width: screenWidth * 0.18,
                        height: screenHeight,
                        title:'商品名',
                        products:[GrilledChickenThigh.name,GrilledChickenSkin.name], //実装後は変数とかにする
                        selectedProduct: selectedProductObject,
                        P:[GrilledChickenThigh,GrilledChickenSkin],//実装後は変数とかにする
                        buttonUpdate: updateName,
                      ),
                    ),
                    Container(
                      alignment: const Alignment(-0.9,-0.9),
                      child: OptionButton(
                        width: screenWidth * 0.18,
                        height: screenHeight,
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
                        width: screenWidth * 0.255,
                        height: screenHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Quantity(
                              width: screenWidth * 0.3,
                              height: screenHeight * 0.3,
                              title: '個数', 
                              index: selectedProductQuantity,
                              onQuantityChange: (newQuantity) {
                                setState(() {
                                  selectedProductQuantity = newQuantity;
                                });
                              },
                            ),
                            Container(height: screenHeight * 0.005,),
                            Container(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              width: screenWidth * 0.385,
                              height: screenHeight * 0.2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 380,
                                    height: screenHeight * 0.03,
                                    margin: const EdgeInsets.all(3.0),
                                    color: const Color.fromARGB(248, 228, 227, 227),
                                    child: Center(child:Text('メモ',selectionColor: Color.fromARGB(255, 255, 254, 254),)),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.38,
                                    height: screenHeight * 0.15,
                                    child: TextFormField(
                                      maxLines: 3,
                                      onChanged: (value){
                                        memo = value;
                                      },
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        hintText: "Text",
                                        border: OutlineInputBorder(
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
                                  ),
                                ],
                              ),
                            ),
                            Container(height: screenHeight * 0.005),
                            Container(height: screenHeight * 0.231, width: 390, color: Color.fromARGB(255, 255, 255, 255),),
                            Container(height: screenHeight * 0.005),
                            Container(
                              width: 390,
                              height: screenHeight * 0.14,
                              color: Color.fromARGB(255, 255, 255, 255),
                              child:  Container(
                                width: 100,
                                height: screenHeight * 0.14,
                                child: ElevatedButton(                         
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    minimumSize: const Size(10,10),
                                  ),
                                  onPressed: () => addCart(),
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
      endDrawer: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.icecream),
        label: const Text('アイスクリームアイコンのボタン'),
      ),
    

            

//'一本ずつ注文（種類、味、本数をスクロールバー？的なので実装）'),
                  

//'できれば本数を簡単に+-できるボタンも欲しい,簡単なメモができるのもあるといい'),
                 


           
  

      drawer: const Drawer(child:Center(child:Text("注文画面、在庫管理画面(グラフ的なものも欲しい)、金調整"))),
    );
  }
}
