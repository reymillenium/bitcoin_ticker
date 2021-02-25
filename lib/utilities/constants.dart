// Packages:
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // To use FormatNumber

const coinApiExchangeRateURL = 'https://rest.coinapi.io/v1/exchangerate';

// API Keys:
const freeCoinApiKey = 'C39843FB-DCE1-4B9E-94B8-FEAC08BC4DDF';

// Currency format:
final currencyFormat = new NumberFormat("#,##0.00", "en_US");

// Text styles:
const kTextFieldInputStyle = TextStyle(
  color: Colors.white,
  // fontFamily: 'Spartan MB',
);

const kTextFieldHintStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Spartan MB',
);

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.lightBlueAccent,
  // icon: Icon(
  //   Icons.monetization_on,
  //   color: Colors.red,
  //   size: 40.0,
  // ),
  // hintText: 'Type the amount',
  hintText: 'TYPE THE AMOUNT',
  hintStyle: kTextFieldHintStyle,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
    borderSide: BorderSide.none,
  ),
);
