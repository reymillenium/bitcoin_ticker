// Packages:
import 'package:bitcoin_ticker/services/networking.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// Screens:
import 'package:bitcoin_ticker/screens/price_screen.dart';

// Components:
import 'package:bitcoin_ticker/components/transition_spinner.dart';

// Services:
import 'package:bitcoin_ticker/services/routes.dart';

// Utilities:
import 'package:bitcoin_ticker/utilities/coin_data.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getExchangeRateData(assetIdBase: cryptoList[0], assetIdQuote: currenciesList[0]);
  }

  void getExchangeRateData({String assetIdBase, String assetIdQuote}) async {
    var exchangeRateData = await NetworkHelper().getExchangeRateData(assetIdBase: assetIdBase, assetIdQuote: assetIdQuote);
    // print(exchangeRateData);
    // await Future.delayed(const Duration(milliseconds: 500));
    RoutesHelper routesHelper = RoutesHelper();
    Navigator.of(context).push(routesHelper.createRoute(
        destiny: PriceScreen(
      coinApiExchangeRateData: exchangeRateData,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: TransitionSpinner(),
        ));
  }
}
