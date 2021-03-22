// Packages:
import 'package:http/http.dart' as http;
import 'dart:convert';

// Constants:
import 'package:bitcoin_ticker/utilities/constants.dart';

class NetworkHelper {
  // Gets the exchange rate data
  Future getSpecificExchangeRateData({String assetIdBase, String assetIdQuote}) async {
    // String specificExchangeRateURL = '$coinApiExchangeRateURL/$assetIdBase/$assetIdQuote?apikey=$freeCoinApiKey';
    String specificExchangeRateURL = 'https://rest-api-freecoin.herokuapp.com/api/v1/general_exchange_${assetIdBase.toLowerCase()}_rows/general_exchange_${assetIdBase.toLowerCase()}?asset_id_quote=$assetIdQuote';
    // print(specificExchangeRateURL);
    return await _getData(url: specificExchangeRateURL);
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
