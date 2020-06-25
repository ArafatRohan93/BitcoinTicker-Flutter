import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
//  PriceScreen({this.currencyData});
//  final currencyData;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String selectedCoin = 'BTC';
  CoinData coinData = CoinData();
  double btcRate;
  double ethRate;
  double ltcRate;
  double rate;
  Map<String, double> coinRate = {
    'BTC': 0.0,
    'ETH': 0.0,
    'LTC': 0.0,
  };
  bool wait;

  @override
  void initState() {
    super.initState();

    updatePrice('USD');
  }

  Future updatePrice(String selectedCurrency) async {
    CoinData coinData = CoinData();
    wait = true;
    var btcRate = await coinData.getCurrencyData(selectedCurrency, 'BTC');
    var ethRate = await coinData.getCurrencyData(selectedCurrency, 'ETH');
    var ltcRate = await coinData.getCurrencyData(selectedCurrency, 'LTC');

    setState(() {
      coinRate['BTC'] = btcRate['rate'];
      coinRate['ETH'] = ethRate['rate'];
      coinRate['LTC'] = ltcRate['rate'];
      print(coinRate);
      wait = false;

    });
  }

  List<Card> getCard() {
    List<Card> cards = [];
    for (String s in cryptoList) {
      var c = Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            wait ? '1 $s = ?  $selectedCurrency':'1 $s = ${coinRate[s]} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      );
      cards.add(c);
    }
    return cards;
  }

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItem = [];
    for (String s in currenciesList) {
      var newItem = DropdownMenuItem<String>(
        child: Text(s),
        value: s,
      );
      dropdownItem.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItem,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          //rate = await coinData.getCurrencyData(selectedCurrency,selectedCoin);
          updatePrice(selectedCurrency);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItem = [];
    for (String s in currenciesList) {
      var newItem = Text(
        s,
        style: TextStyle(color: Colors.white),
      );
      pickerItem.add(newItem);
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedCurrency) {
        print(selectedCurrency);
      },
      children: pickerItem,
    );
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: getCard(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}
