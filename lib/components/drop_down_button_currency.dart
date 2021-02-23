// Packages:
import 'package:flutter/material.dart';

// Utilities:
import 'package:bitcoin_ticker/utilities/coin_data.dart';

class DropDownButtonCurrency extends StatelessWidget {
  final String selectedCurrencyValue;
  final Function onChanged;
  final List<String> itemsList;

  DropDownButtonCurrency({this.selectedCurrencyValue, this.onChanged, this.itemsList});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropDownItems = itemsList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    return DropdownButton<String>(
      value: selectedCurrencyValue,
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
        onChanged(newValue);
        print(newValue);
      },
      items: dropDownItems,
    );
  }
}
