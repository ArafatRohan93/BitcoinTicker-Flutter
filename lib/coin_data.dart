import 'networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

String apiKey = '062F6E7E-6FA4-4F5A-AE12-778148333754';
String url = 'https://rest.coinapi.io/v1/exchangerate/';

class CoinData {
  CoinData();

  Future<dynamic> getCurrencyData(String selectedCurrency, String selectedCoin) async{
    NetworkHelper networkHelper =  NetworkHelper(url:  '${url}$selectedCoin/$selectedCurrency?apikey=$apiKey');
    var coinData = await networkHelper.getData();
    return coinData;
  }
}
