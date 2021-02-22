// Packages:
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Components:
import 'package:bitcoin_ticker/components/drop_down_button_currency.dart';
import 'package:bitcoin_ticker/components/cupertino_picker_currency.dart';

// Utilities:
import 'package:bitcoin_ticker/utilities/coin_data.dart';

class MultiPlatformSelectBox extends StatelessWidget {
  final Function onSelectedItemChanged;
  final String selectedCurrencyValue;
  final Function onChanged;

  MultiPlatformSelectBox({this.selectedCurrencyValue, this.onSelectedItemChanged, this.onChanged});

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      return CupertinoPickerCurrency(
        onSelectedItemChanged: (selectedIndex) {
          onSelectedItemChanged(selectedIndex);
        },
      );
    } else {
      return DropDownButtonCurrency(
        selectedCurrencyValue: selectedCurrencyValue,
        onChanged: (String newValue) {
          onChanged(newValue);
        },
      );
    }
  }
}
