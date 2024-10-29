import 'package:flutter/material.dart';

class CheckoutWidget extends StatefulWidget {
  @override
  _CheckoutWidgetState createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  double totalAmount = 5000; // 仮の合計金額
  bool isPaid = false;

  void processPayment() {
    setState(() {
      isPaid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '合計金額: ¥${totalAmount.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: isPaid ? null : processPayment,
          child: Text(isPaid ? '支払い済み' : '支払う'),
        ),
        if (isPaid)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              '支払いが完了しました',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
          ),
      ],
    );
  }
}
