import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pos2024/models/SelectedProduct.dart';
import 'package:pos2024/pages/OderPage.dart';
import 'package:pos2024/widgets/Cart.dart';
import 'package:pos2024/widgets/KeyPad.dart';
import 'package:pos2024/firestore.dart';

class CasherPage extends StatefulWidget {
  CasherPage({super.key, required this.title, required this.selectedProducts, required this.waitingOder,required this.customerCounter});

  final String title;
  List<SelectedProduct> selectedProducts;
  int customerCounter;

  Map<DateTime,List<SelectedProduct>> waitingOder;

  @override
  State<CasherPage> createState() => _CasherPage();
}

class _CasherPage extends State<CasherPage> {

  String _input = '';
  int totalPrice = 0;
  int totalQuantity = 0;
  int change = 0;
  late Firestore collection;

  @override
  void initState() {
    updateTotalQuantity();
    collection = Firestore();
    super.initState();
  }


  void getChange(){
    setState(() {
      if(_input == ''){
        change = -totalPrice;
      }else{
        change = int.parse(_input) - totalPrice;
      }
    });
  }

  Future<void> backOderPage() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('確認',style: TextStyle(fontSize: 24)),
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
                Text('以下の内容の注文を確定しますか?',style: TextStyle(fontSize: 24)),
                Text('必ずこの画面を確認してから次に進んでください.',style: TextStyle(fontSize: 24,color: Color.fromARGB(99, 255, 0, 0))),
                Row(
                  children: [
                    Text('合計金額:',style: TextStyle(fontSize: 18)),
                    Text('${totalPrice}',style: TextStyle(fontSize: 20)),
                    Text('円',style: TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  children: [
                    Text('預かり金:',style: TextStyle(fontSize: 18)),
                    Text('${_input}',style: TextStyle(fontSize: 20)),
                    Text('円',style: TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  children: [
                    Text('お釣り:',style: TextStyle(fontSize: 18)),
                    Text('${int.parse(_input) - totalPrice}',style: TextStyle(fontSize: 20)),
                    Text('円',style: TextStyle(fontSize: 18)),
                  ],
                ),
              
              ],
            ),
          ),
          

                            
        );
        },
      );
    setState(() {
      widget.customerCounter += 1;
      widget.waitingOder[DateTime.now()] = widget.selectedProducts;
      collection.addServedProductWithLoading(
        context, 
        widget.selectedProducts, 
        widget.customerCounter, 
        totalPrice, 
        _input,
        widget.waitingOder
      );
      widget.selectedProducts = [];
      
    });
  }

  void _handleKeyPress(String key) {
    setState(() {
      debugPrint('$_input');
      
      debugPrint('$change');
      
      if (key == 'C') {
        _input = '';
      } else if (key == 'OK') {
        if(change < 0){
          showDialog(//アラート処理くわえる。
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("お金が足りません"),
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
          backOderPage();
          debugPrint("se");
        }
        //selectedProducts初期化、オーダー画面へ遷移、注文待ち状態へ
      } else {
        _input += key;
      }
      getChange();
    });
  }

  void updateTotal(){
    setState(() {
      totalPrice = 0; // 合計金額をリセット
      for (int i = 0; i < widget.selectedProducts.length; i++) {
        totalPrice += widget.selectedProducts[i].calculatSubtotal();
      }
      int discount = (totalQuantity ~/ 3) * 50;
      debugPrint('a${totalQuantity}');
      totalPrice -= discount;
    });
  }

  void updateTotalQuantity(){
    setState(() {
      totalQuantity = 0; // 合計金額をリセット
      for (int i = 0; i < widget.selectedProducts.length; i++) {
        totalQuantity +=  widget.selectedProducts[i].oderPieces;
        debugPrint('${ widget.selectedProducts[i].oderPieces}');
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

        title: Text(widget.title),

        
      ),
      body: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              alignment: Alignment.center,
              color: const Color.fromARGB(255, 255, 255, 255),
              width: screenWidth * 0.35,
              height: screenHeight * 0.88,
              child: CartWidget(height: screenHeight, width: screenWidth * 0.3,selectedProducts: widget.selectedProducts,totalPrice: totalPrice,onPush: getChange,edit: false,),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('合計金額',style: TextStyle(fontSize: 32)),
                      Text('$totalPrice 円',style: TextStyle(fontSize: 32))
                    ]
                  ),
                ),
                Divider(height: screenHeight * 0.001,),
                Container(
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.1,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('お預かり', style: TextStyle(fontSize: 32)),
                      Text('$_input 円', style: TextStyle(fontSize: 32))
                    ],

                  ),
                ),
                Divider(height: screenHeight * 0.001,),
                Container(
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.1,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('お釣り', style: TextStyle(fontSize: 32)),
                      Text('$change 円', style: TextStyle(fontSize: 32,color: (change < 0)?Color.fromARGB(224, 255, 63, 76):Color.fromARGB(223, 4, 4, 4)), ),
                    ],
                  ),
                ),
                KeypadWidget(onKeyPressed: _handleKeyPress,width: screenWidth * 0.3, height: screenHeight * 0.6),
              ],
            ),
          ]
        ),
      ),   
    );

  }

}
  Widget buildButton(String title) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: EdgeInsets.all(16),
        ),
        onPressed: () => {},
        child: Text(title, style: TextStyle(fontSize: 24)),
      ),
    );
  }