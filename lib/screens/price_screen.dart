// Packages:
import 'package:bitcoin_ticker/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

//Components:
import 'package:bitcoin_ticker/components/drop_down_button_currency.dart';
import 'package:bitcoin_ticker/components/cupertino_picker_currency.dart';
import 'package:bitcoin_ticker/components/multi_platform_select_box.dart';

// Services:
import 'package:bitcoin_ticker/services/networking.dart';

// Utilities:
import '../utilities/coin_data.dart';

class PriceScreen extends StatefulWidget {
  // Properties:
  final coinApiExchangeRateData;

  // Constructor:
  PriceScreen({
    this.coinApiExchangeRateData,
  });

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  NetworkHelper networkHelper = NetworkHelper();

  // Properties:
  String selectedCurrencyValue = currenciesList[0];
  int selectedCurrencyIndex = 0;

  // From Coin API Exchange Data:

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.coinApiExchangeRateData);
  }

  void updateUI(dynamic coinApiExchangeRateData) {
    print(coinApiExchangeRateData);
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
            child: MultiPlatformSelectBox(
              onSelectedItemChangedIOS: (selectedIndex) {
                setState(() {
                  selectedCurrencyIndex = selectedIndex;
                  selectedCurrencyValue = currenciesList[selectedCurrencyIndex];
                });
              },
              selectedCurrencyValueAndroid: selectedCurrencyValue,
              onChangedAndroid: (String newValue) {
                setState(() {
                  selectedCurrencyValue = newValue;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
