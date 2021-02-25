// Packages:
import 'package:bitcoin_ticker/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:deep_pick/deep_pick.dart';
import 'dart:async'; // Allows to use the Timer
import 'package:flutter/services.dart'; // Allows to use inputFormatters in TextField components

import 'dart:io' show Platform;

//Components:
import 'package:bitcoin_ticker/components/multi_platform_select_box.dart';

// Services:
import 'package:bitcoin_ticker/services/networking.dart';

// Utilities:
import 'package:bitcoin_ticker/utilities/coin_data.dart';

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
  TextEditingController _controller;

  // Properties:
  String selectedCryptoValueAssetBase = cryptoList[0];
  int selectedCurrencyIndexAssetBase = 0;
  String selectedCurrencyValueAssetQuote = currenciesList[0];
  int selectedCurrencyIndexAssetQuote = 0;
  double cryptoAmount = 1 ?? 0;
  double currencyAmount = 1;
  Timer searchOnStoppedTypingCrypto;
  Timer searchOnStoppedTypingCurrency;
  Timer searchOnStoppedTypingAmount;

  // From Coin API Exchange Data:
  double rate = 0;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: '1');
    updateUI(widget.coinApiExchangeRateData);
  }

  void updateUI(dynamic coinApiExchangeRateData) {
    setState(() {
      rate = pick(coinApiExchangeRateData, 'rate').asDoubleOrNull() ?? 0;
      currencyAmount = double.parse((cryptoAmount * rate).toStringAsFixed(2));
    });
  }

  void getExchangeRateData() async {
    var exchangeRateData = await NetworkHelper().getExchangeRateData(assetIdBase: selectedCryptoValueAssetBase, assetIdQuote: selectedCurrencyValueAssetQuote);
    updateUI(exchangeRateData);
  }

  _onChangeCryptoHandler() {
    const duration = Duration(milliseconds: 500); // set the duration that you want call search() after that.
    if (searchOnStoppedTypingCrypto != null) {
      setState(() => searchOnStoppedTypingCrypto.cancel()); // clear timer
    }
    setState(() => searchOnStoppedTypingCrypto = new Timer(duration, () {
          getExchangeRateData();
        }));
  }

  _onChangeCurrencyHandler() {
    const duration = Duration(milliseconds: 500); // set the duration that you want call search() after that.
    if (searchOnStoppedTypingCurrency != null) {
      setState(() => searchOnStoppedTypingCurrency.cancel()); // clear timer
    }
    setState(() => searchOnStoppedTypingCurrency = new Timer(duration, () {
          getExchangeRateData();
        }));
  }

  _onChangeAmountHandler(value) {
    const duration = Duration(milliseconds: 500); // set the duration that you want call search() after that.
    if (searchOnStoppedTypingAmount != null) {
      setState(() => searchOnStoppedTypingAmount.cancel()); // clear timer
    }
    setState(() => searchOnStoppedTypingAmount = new Timer(duration, () {
          setState(() {
            print(value);
            String valueToParse = (value == null || value == '') ? '0.0' : value;
            print(valueToParse);
            cryptoAmount = double.parse(valueToParse);
          });
          getExchangeRateData();
        }));
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
                  // '1 $selectedCryptoValueAssetBase = $currencyAmount $selectedCurrencyValueAssetQuote',
                  '$cryptoAmount $selectedCryptoValueAssetBase = ${currencyFormat.format(currencyAmount)} $selectedCurrencyValueAssetQuote',
                  // '1 $selectedCryptoValueAssetBase = ${currencyFormat.format(132323.4343)} $selectedCurrencyValueAssetQuote',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Crypto Amount Text Field
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              autofocus: true,
              style: kTextFieldInputStyle,
              decoration: kTextFieldDecoration,
              cursorColor: Colors.black,
              cursorWidth: 2,
              onChanged: (value) {
                _onChangeAmountHandler(value);
              },
              onSubmitted: (value) async {
                await Future.delayed(const Duration(milliseconds: 500));
                _onChangeAmountHandler(value);
              },
              controller: _controller,
            ),
          ),

          // Crypto & Currency Selectors
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Crypto Select Box
                Flexible(
                  child: Container(
                    child: MultiPlatformSelectBox(
                      onSelectedItemChangedIOS: (selectedIndex) async {
                        setState(() {
                          selectedCurrencyIndexAssetBase = selectedIndex;
                          selectedCryptoValueAssetBase = cryptoList[selectedCurrencyIndexAssetBase];
                        });
                        _onChangeCryptoHandler();
                      },
                      selectedCurrencyValueAndroid: selectedCryptoValueAssetBase,
                      onChangedAndroid: (String newValue) async {
                        setState(() {
                          selectedCryptoValueAssetBase = newValue;
                        });
                        _onChangeCryptoHandler();
                      },
                      itemsList: cryptoList,
                    ),
                  ),
                ),

                // Currency Select Box
                Flexible(
                  child: Container(
                    child: MultiPlatformSelectBox(
                      onSelectedItemChangedIOS: (selectedIndex) async {
                        setState(() {
                          selectedCurrencyIndexAssetQuote = selectedIndex;
                          selectedCurrencyValueAssetQuote = currenciesList[selectedCurrencyIndexAssetQuote];
                        });
                        _onChangeCurrencyHandler();
                      },
                      selectedCurrencyValueAndroid: selectedCurrencyValueAssetQuote,
                      onChangedAndroid: (String newValue) async {
                        setState(() {
                          selectedCurrencyValueAssetQuote = newValue;
                        });
                        _onChangeCurrencyHandler();
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
