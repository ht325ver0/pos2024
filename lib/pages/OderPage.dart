import 'package:flutter/material.dart';
import 'package:pos2024/models/SelectedProduct.dart';
import 'package:pos2024/pages/CasherPage.dart';
import 'package:pos2024/widgets/CategoryButton.dart';
import 'package:pos2024/models/Product.dart';
import 'package:pos2024/widgets/OptionButton.dart';
import 'package:pos2024/widgets/Quantity.dart';
import 'package:pos2024/widgets/Cart.dart';
import 'package:pos2024/firestore.dart';

class OderPage extends StatefulWidget {
  OderPage({super.key, required this.title, required this.waitingOder, required this.customerCounter});

  final String title;
  Map<DateTime,List<SelectedProduct>> waitingOder;
  int customerCounter;

  @override
  State<OderPage> createState() => _OderPage();
}

class _OderPage extends State<OderPage> {
  int selectedItem = 0;

  Product GrilledChickenThigh = Product(name: '焼き鳥(もも)', stock: 100, price: 100, options: ['塩','甘口','中辛','辛口','デス']);
  Product GrilledChickenSkin = Product(name: '焼き鳥(かわ)', stock: 100, price: 100, options: ['塩','甘口','中辛','辛口','デス']);
  ///商品名ボタンで選択された商品のオブジェクト
  Product selectedProductObject = Product(name: '', stock: 0, price: 0, options: []);
  int selectedProductOption = 0;
  int selectedProductQuantity = 1;
  String memo = '';
  List<SelectedProduct> selectedProducts = [];
  int totalPrice = 0;
  int totalQuantity = 0;

  late Firestore collection;
  List<Product> productsList = []; // ここで空のリストとして初期化
  List<String> productsNameList = []; // ここで空のリストとして初期化
  Product nullProduct = Product(name: '', stock: 0, price: 0, options: []);

  @override
  void initState() {
    super.initState();

    collection = Firestore();
    fetchData();

  }

  Future<void> fetchData() async {
    List<Product> fetchedProducts = await collection.getProductList();
    int co = await collection.getCustomerCounte();
    

    setState(() {
      productsList = fetchedProducts;
      productsNameList = productsList.map((product) => product.name).toList();
      widget.customerCounter = co;
    });
    
    debugPrint("${fetchedProducts}\n ${productsNameList}");
  }

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

  void updateTotal(){
    setState(() {
      totalPrice = 0; // 合計金額をリセット
      for (int i = 0; i < selectedProducts.length; i++) {
        totalPrice += selectedProducts[i].calculatSubtotal();
      }
      int discount = (totalQuantity ~/ 3) * 50;
      debugPrint('a${totalQuantity}');
      totalPrice -= discount;
    });
  }

  void addCart() {
    setState(() {
      getObject();
      updateTotalQuantity();
    });
  }

  void getObject() {
    selectedProducts.add(
      SelectedProduct(
        object: this.selectedProductObject, 
        optionNumber: this.selectedProductOption, 
        oderPieces: selectedProductQuantity, 
        memo: this.memo
      )
    );
  }

  void updateTotalQuantity(){
    setState(() {
      totalQuantity = 0; // 合計金額をリセット
      for (int i = 0; i < selectedProducts.length; i++) {
        totalQuantity += selectedProducts[i].oderPieces;
        debugPrint('${selectedProducts[i].oderPieces}');
      }
      updateTotal();
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

        title: Text(widget.title,style: TextStyle(fontSize: 24),),

        actions: [
          TextButton.icon(
            onPressed: (){
              debugPrint("$selectedProducts");
              if(selectedProducts.isEmpty){
                showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("カートに商品がありません"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // ダイアログを閉じる
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context){
                    return CasherPage(
                      title: '会計ページ',
                      selectedProducts: selectedProducts, 
                      waitingOder: widget.waitingOder, 
                      customerCounter: widget.customerCounter,
                    );
                  })
                );
              }
            },
            icon: const Icon(Icons.point_of_sale),
            label: const Text('会計',selectionColor: Color.fromARGB(0, 239, 216, 222),style: TextStyle(fontSize: 24),),
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
                      child: Row(
                        children: [
                          Text('合計金額:',style: TextStyle(fontSize: 20),),
                          Text('$totalPrice 円', style: TextStyle(fontSize: 40)),
                          if(totalQuantity > 2) Text('割引 -${totalQuantity ~/ 3 * 50} 円', style: TextStyle(fontSize: 20)),
                        ]
                      ),
                    ),
                  ),
                  Container(
                    alignment: const Alignment(0,0),
                    child: Container(
                      width: screenWidth * 0.35,
                      height: screenHeight * 0.62,
                      child: CartWidget(height: screenHeight * 0.3, width: screenWidth * 0.3, selectedProducts: selectedProducts, totalPrice: totalPrice, onPush: updateTotalQuantity,edit: true,)
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Container(
                color: const Color.fromARGB(255, 237, 233, 230),//右側の土台
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
                        title: '商品名',
                        products: productsNameList, //実装後は変数とかにする
                        selectedProduct: selectedProductObject,
                        P: productsList,//実装後は変数とかにする
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
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Quantity(
                                width: screenWidth * 0.3,
                                height: screenHeight * 0.35,
                                title: '個数', 
                                index: selectedProductQuantity,
                                onQuantityChange: (newQuantity) {
                                  setState(() {
                                    selectedProductQuantity = newQuantity;
                                  });
                                },
                              ),
                              Container(height: screenHeight * 0.005),
                            
                              Container(height: screenHeight * 0.005),
                              Container(
                                height: screenHeight * 0.24, 
                                width: screenWidth * 0.385, 
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              Container(height: screenHeight * 0.005),
                              Container(
                                width: screenWidth * 0.385,
                                height: screenHeight * 0.3,
                                color: Color.fromARGB(255, 255, 255, 255),
                                child:  Container(
                                  width: 100,
                                  height: screenHeight * 0.14,
                                  child: ElevatedButton(                         
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                    ),
                                    onPressed: (){
                                      if(selectedProductObject == nullProduct){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Text("カートに商品がありません"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop(); // ダイアログを閉じる
                                                  },
                                                  child: Text("OK"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }else{
                                        addCart();
                                      }
                                      },
                                    child: 
                                      Text('カートに追加', style: TextStyle(fontSize: 22)),
                                    
                                  ),
                                ),
                              ),
                            ],
                          ),
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
