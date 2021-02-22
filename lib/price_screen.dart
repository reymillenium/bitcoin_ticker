// Packages:
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

//Components:
import 'package:bitcoin_ticker/components/drop_down_button_currency.dart';

// Utilities:
import 'utilities/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  // String dropdownValue = 'One';
  String selectedCurrency = currenciesList[0];
  int selectedCurrencyIndex = 0;

  DropdownButton getDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = currenciesList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    return DropdownButton<String>(
      value: selectedCurrency,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
          // color: Colors.deepPurple,
          ),
      underline: Container(
        height: 2,
        // color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          selectedCurrency = newValue;
        });
      },
      items: dropDownItems,
    );
  }

  CupertinoPicker getCupertinoPicker() {
    List<Text> cupertinoPickerChildren = currenciesList.map<Text>((String value) {
      return Text(value);
    }).toList();

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrencyIndex = selectedIndex;
        });
        print(selectedIndex);
      },
      children: cupertinoPickerChildren,
    );
  }

  // Widget getSelectBoxByPlatform() {
  //   bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
  //
  //   if (isIOS) {
  //     return getCupertinoPicker();
  //   } else {
  //     return getDropDownButton();
  //   }
  // }

  Widget getSelectBoxByPlatform() {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      return getCupertinoPicker();
    } else {
      return DropDownButtonCurrency(
        selectedCurrency: selectedCurrency,
        onChanged: (String newValue) {
          setState(() {
            selectedCurrency = newValue;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getSelectBoxByPlatform(),
          ),
        ],
      ),
    );
  }
}
