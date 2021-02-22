// Packages:
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Components:
import 'package:bitcoin_ticker/components/drop_down_button_currency.dart';
import 'package:bitcoin_ticker/components/cupertino_picker_currency.dart';

// Utilities:
import 'package:bitcoin_ticker/utilities/coin_data.dart';

class MultiPlatformSelectBox extends StatelessWidget {
  final Function onSelectedItemChangedIOS;
  final String selectedCurrencyValueAndroid;
  final Function onChangedAndroid;

  MultiPlatformSelectBox({this.onSelectedItemChangedIOS, this.selectedCurrencyValueAndroid, this.onChangedAndroid});

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      return CupertinoPickerCurrency(
        onSelectedItemChanged: (selectedIndex) {
          onSelectedItemChangedIOS(selectedIndex);
        },
      );
    } else {
      return DropDownButtonCurrency(
        selectedCurrencyValue: selectedCurrencyValueAndroid,
        onChanged: (String newValue) {
          onChangedAndroid(newValue);
        },
      );
    }
  }
}
