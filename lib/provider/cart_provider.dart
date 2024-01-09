import 'package:flutter/material.dart';
import 'package:phone_store_application/phone.dart';
import 'package:intl/intl.dart';


class CartProvider extends ChangeNotifier {
  final formatter = NumberFormat.simpleCurrency(locale: 'id_ID');
  List<Phone> _allcart = [];
  List<int> _qty = [];
  List<bool> _isCheck = [];
  int _totalHarga = 0;

  List<Phone> get allcart => _allcart;
  List<int> get qty => _qty;
  List<bool> get isCheck => _isCheck;
  int get countCheck => _isCheck.where((item) => item == true).length;
  // int get totalHarga => _totalHarga;
  String get totalHarga => formatter.format(_totalHarga);
  

  void addCart(Phone item){
    if (_allcart.contains(item)){
      int index = _allcart.indexWhere((element) => element == item);
      int temp = _qty[index];
      temp++;
      _qty[index] = temp;
    }
    else{
      _allcart.add(item);
      _qty.add(1);
      _isCheck.add(false);
    }

    notifyListeners();
  }

  void addQty(int index){
    _qty[index] = _qty[index]+1;
    notifyListeners();
  }

  void removeQty(int index){
    if (_qty[index]-1 == 0){
      _qty.removeAt(index);
      _allcart.removeAt(index);
      _isCheck.removeAt(index);
    }
    else{
      _qty[index] = _qty[index]-1;
    }
    notifyListeners();
  }

  void checkAction(int index){
    String harga = allcart[index].price.replaceAll(new RegExp(r'[^\w\s]+'),''); // di sini untuk menghilangkan semua titik dari string harga
    String harga2 = harga.substring(3,harga.length);
    int valHarga = int.parse(harga2);
    if (_isCheck[index] == false){
      _isCheck[index] = true;
      _totalHarga+=valHarga;
    }
    else{
      _isCheck[index] = false;
      _totalHarga-=valHarga;
    }
    notifyListeners();
  }


  // @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }
}