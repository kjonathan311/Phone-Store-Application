import 'package:flutter/material.dart';
import 'package:phone_store_application/phone.dart';

class CartProvider extends ChangeNotifier {
  List<Phone> _allcart = [];
  List<int> _qty = [];
  List<bool> _isCheck = [];

  List<Phone> get allcart => _allcart;
  List<int> get qty => _qty;
  List<bool> get isCheck => _isCheck;

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
    }
    else{
      _qty[index] = _qty[index]-1;
    }
    notifyListeners();
  }


  // @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }
}