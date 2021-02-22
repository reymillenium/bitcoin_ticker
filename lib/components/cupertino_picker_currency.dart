// Packages:
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Components:
import 'package:bitcoin_ticker/utilities/coin_data.dart';

class CupertinoPickerCurrency extends StatelessWidget {
  final Function onSelectedItemChanged;

  CupertinoPickerCurrency({this.onSelectedItemChanged});

  @override
  Widget build(BuildContext context) {
    List<Text> cupertinoPickerChildren = currenciesList.map<Text>((String value) {
      return Text(value);
    }).toList();

    return CupertinoPicker(
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
