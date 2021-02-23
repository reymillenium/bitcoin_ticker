// Packages:
import 'package:bitcoin_ticker/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:deep_pick/deep_pick.dart';
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
  String selectedCryptoValueAssetBase = cryptoList[0];
  int selectedCurrencyIndexAssetBase = 0;
  String selectedCurrencyValueAssetQuote = currenciesList[0];
  int selectedCurrencyIndexAssetQuote = 0;
  double cryptoAmount = 1;
  double currencyAmount = 1;

  // From Coin API Exchange Data:
  double rate = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.coinApiExchangeRateData);
  }

  void updateUI(dynamic coinApiExchangeRateData) {
    print(coinApiExchangeRateData);
    rate = pick(coinApiExchangeRateData, 'rate').asDoubleOrNull() ?? 0;
    // print(rate);
    currencyAmount = double.parse((cryptoAmount * rate).toStringAsFixed(2));
  }

  void getExchangeRateData() async {
    var exchangeRateData = await NetworkHelper().getExchangeRateData(assetIdBase: selectedCryptoValueAssetBase, assetIdQuote: selectedCurrencyValueAssetQuote);
    // print(exchangeRateData);
    updateUI(exchangeRateData);
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
                  '1 $selectedCryptoValueAssetBase = $currencyAmount $selectedCurrencyValueAssetQuote',
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Container(
                    child: MultiPlatformSelectBox(
                      onSelectedItemChangedIOS: (selectedIndex) async {
                        setState(() {
                          selectedCurrencyIndexAssetBase = selectedIndex;
                          selectedCryptoValueAssetBase = cryptoList[selectedCurrencyIndexAssetBase];
                        });
                        getExchangeRateData();
                      },
                      selectedCurrencyValueAndroid: selectedCryptoValueAssetBase,
                      onChangedAndroid: (String newValue) async {
                        setState(() {
                          selectedCryptoValueAssetBase = newValue;
                        });
                        getExchangeRateData();
                      },
                      itemsList: cryptoList,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    child: MultiPlatformSelectBox(
                      onSelectedItemChangedIOS: (selectedIndex) async {
                        setState(() {
                          selectedCurrencyIndexAssetQuote = selectedIndex;
                          selectedCurrencyValueAssetQuote = currenciesList[selectedCurrencyIndexAssetQuote];
                        });
                        getExchangeRateData();
                      },
                      selectedCurrencyValueAndroid: selectedCurrencyValueAssetQuote,
                      onChangedAndroid: (String newValue) async {
                        setState(() {
                          selectedCurrencyValueAssetQuote = newValue;
                        });
                        getExchangeRateData();
                      },
                      itemsList: currenciesList,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
