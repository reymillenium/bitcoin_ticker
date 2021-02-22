// Packages:
import 'package:flutter/material.dart';

//Components:
import 'package:bitcoin_ticker/utilities/coin_data.dart';

class DropDownButtonCurrency extends StatelessWidget {
  final String selectedCurrency;
  final Function onChanged;

  DropDownButtonCurrency({this.selectedCurrency, this.onChanged});

  @override
  Widget build(BuildContext context) {
    // return DropdownButton<String>(
    //   value: selectedCurrency,
    //   icon: Icon(Icons.arrow_downward),
    //   iconSize: 24,
    //   elevation: 16,
    //   style: TextStyle(
    //       // color: Colors.deepPurple,
    //       ),
    //   underline: Container(
    //     height: 2,
    //     color: Colors.deepPurpleAccent,
    //   ),
    //   onChanged: (String newValue) {
    //     // setState(() {
    //     //   selectedCurrency = newValue;
    //     // });
    //     onChanged(newValue);
    //   },
    //   // items: <String>['One', 'Two', 'Free', 'Four'].map<DropdownMenuItem<String>>((String value) {
    //   items: getDropDownItems(),
    // );

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
        onChanged(newValue);
        print(newValue);
      },
      items: dropDownItems,
    );
  }
}

List<DropdownMenuItem<String>> getDropDownItems() {
  return currenciesList.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();
}
