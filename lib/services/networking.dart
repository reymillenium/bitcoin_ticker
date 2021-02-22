// Packages:
import 'package:http/http.dart' as http;
import 'dart:convert';

// Constants:
import 'package:bitcoin_ticker/utilities/constants.dart';

class NetworkHelper {
  // Gets the exchange rate data

  Future getExchangeRateData({String assetIdBase, String assetIdQuote}) async {
    String exchangeRateURL = '$coinApiExchangeRateURL/$assetIdBase/$assetIdQuote?apikey=$freeCoinApiKey';
    print(exchangeRateURL);
    return await _getData(url: exchangeRateURL);
  }

  // Gets the data given a url:
  Future<dynamic> _getData({String url}) async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
