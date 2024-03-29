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
  final coinApiSpecificExchangeRateData;

  // Constructor:
  PriceScreen({
    this.coinApiSpecificExchangeRateData,
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
    updateUI(widget.coinApiSpecificExchangeRateData);
  }

  void updateUI(dynamic coinApiSpecificExchangeRateData) {
    setState(() {
      rate = pick(coinApiSpecificExchangeRateData, 'rate').asDoubleOrNull() ?? 0;
      currencyAmount = double.parse((cryptoAmount * rate).toStringAsFixed(2));
    });
  }

  void getSpecificExchangeRateData() async {
    var specificExchangeRateData = await NetworkHelper().getSpecificExchangeRateData(assetIdBase: selectedCryptoValueAssetBase, assetIdQuote: selectedCurrencyValueAssetQuote);
    updateUI(specificExchangeRateData);
  }

  _onChangeCryptoHandler() {
    const duration = Duration(milliseconds: 500); // set the duration that you want call search() after that.
    if (searchOnStoppedTypingCrypto != null) {
      setState(() => searchOnStoppedTypingCrypto.cancel()); // clear timer
    }
    setState(() => searchOnStoppedTypingCrypto = new Timer(duration, () {
          getSpecificExchangeRateData();
        }));
  }

  _onChangeCurrencyHandler() {
    const duration = Duration(milliseconds: 500); // set the duration that you want call search() after that.
    if (searchOnStoppedTypingCurrency != null) {
      setState(() => searchOnStoppedTypingCurrency.cancel()); // clear timer
    }
    setState(() => searchOnStoppedTypingCurrency = new Timer(duration, () {
          getSpecificExchangeRateData();
        }));
  }

  _onChangeAmountHandler(value) {
    const duration = Duration(milliseconds: 500); // set the duration that you want call search() after that.
    if (searchOnStoppedTypingAmount != null) {
      setState(() => searchOnStoppedTypingAmount.cancel()); // clear timer
    }
    setState(() => searchOnStoppedTypingAmount = new Timer(duration, () {
          setState(() {
            String valueToParse = (value == null || value == '') ? '0.0' : value;
            cryptoAmount = double.parse(valueToParse);
          });
          getSpecificExchangeRateData();
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
                  '$cryptoAmount $selectedCryptoValueAssetBase = ${currencyFormat.format(currencyAmount)} $selectedCurrencyValueAssetQuote',
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
              // Only numbers, but does not accepts the dot (not enough)
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],

              // Accepts numbers, commas and more than one dot (not good)
              // keyboardType: TextInputType.numberWithOptions(decimal: true),
              // inputFormatters: [
              //   FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
              // ],
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
