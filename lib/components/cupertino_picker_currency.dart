// Packages:
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Utilities:
import 'package:bitcoin_ticker/utilities/coin_data.dart';

class CupertinoPickerCurrency extends StatelessWidget {
  final Function onSelectedItemChanged;
  final List<String> itemsList;

  CupertinoPickerCurrency({this.onSelectedItemChanged, this.itemsList});

  @override
  Widget build(BuildContext context) {
    List<Text> cupertinoPickerChildren = itemsList.map<Text>((String value) {
      return Text(value);
    }).toList();

    return CupertinoPicker(
      // useMagnifier: false,
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        onSelectedItemChanged(selectedIndex);
        print(selectedIndex);
      },
      children: cupertinoPickerChildren,
    );
  }
}
