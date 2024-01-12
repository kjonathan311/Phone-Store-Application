import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phone_store_application/phone.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class CartProvider extends ChangeNotifier {

  List<Phone> listPhone = phoneList;
  final formatter = NumberFormat.simpleCurrency(locale: 'id_ID');
  List<Phone> _allcart = [];
  List<String> _id = [];
  List<int> _qty = [];
  List<bool> _isCheck = [];
  int _totalHarga = 0;
  bool _isInitialdata = false;

  List<Phone> get allcart => _allcart;
  List<int> get qty => _qty;
  List<bool> get isCheck => _isCheck;
  int get countCheck => _isCheck.where((item) => item == true).length;
  bool get isInitialdata => _isInitialdata;
  // int get totalHarga => _totalHarga;
  String get totalHarga => formatter.format(_totalHarga);
  double get dtotalHarga => _totalHarga.toDouble();
  

  

  void addCart(Phone item, String email, BuildContext context) async{
    if (_allcart.contains(item)){
      int index = _allcart.indexWhere((element) => element == item);// untuk mendapatkan index dari cart barang yang sudah pernah ditambah sebelumnya
      int temp = _qty[index]; // menampung nilai sementara qty ke dalam var temp
      temp++; // menambahkan nilai temp
      _qty[index] = temp; // mengupdate nilai temp di list
      notifyListeners();
      
      Uri url = Uri.parse("https://phone-store-project-default-rtdb.asia-southeast1.firebasedatabase.app/cart/${_id[index]}.json");
      await http.patch(
        url,
        body: json.encode(
          {
            "qty": temp,
          }
        ),
      );
    }
    else{
      Uri url = Uri.parse("https://phone-store-project-default-rtdb.asia-southeast1.firebasedatabase.app/cart.json");
      http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "phone_name": item.name,
            "qty": 1,
            "check": false

          }
        ),
      ).then((response){
        _id.add(json.decode(response.body)["name"].toString()); // menambahkan unik id ke dalam list id
        _allcart.add(item); // menambahkan item phone ke dalam list allcart
        _qty.add(1); //menambahkan qty dengan nilai default 1
        _isCheck.add(false); //menambahakan ischeck dengan nilai default false
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar (
            content: Text("Berhasil ditambahkan ke Cart"),
            duration: Duration(seconds: 2),
          )
        );
        notifyListeners();
      });
    }

  }

  Future <void> addQty(int index) async{
    if (_isCheck[index]==true){
      String harga = allcart[index].price.replaceAll(new RegExp(r'[^\w\s]+'),''); // di sini untuk menghilangkan semua titik dari string harga
      String harga2 = harga.substring(3,harga.length);
      int valHarga = int.parse(harga2);
      _totalHarga+= valHarga;
    }
    int temp = _qty[index];
    temp++;
    _qty[index] = temp;
    notifyListeners();
    Uri url = Uri.parse("https://phone-store-project-default-rtdb.asia-southeast1.firebasedatabase.app/cart/${_id[index]}.json");
    await http.patch(
      url,
      body: json.encode(
        {
          "qty": temp,
        }
      ),
    );
  }

  Future <void> removeQty(int index, BuildContext context) async{
    if (_isCheck[index]==true){
      String harga = allcart[index].price.replaceAll(new RegExp(r'[^\w\s]+'),''); // di sini untuk menghilangkan semua titik dari string harga
      String harga2 = harga.substring(3,harga.length);
      int valHarga = int.parse(harga2);
      _totalHarga-= valHarga;
    }
    if (_qty[index]-1 == 0){
      _qty.removeAt(index);
      _allcart.removeAt(index);
      _isCheck.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar (
          content: Text("Berhasil menghapus item dari Cart"),
          duration: Duration(seconds: 2),
        )
      );
      
      notifyListeners();
      Uri url = Uri.parse("https://phone-store-project-default-rtdb.asia-southeast1.firebasedatabase.app/cart/${_id[index]}.json");
      await http.delete(url);
    }
    else{
      int temp = _qty[index];
      temp--;
      _qty[index] = temp;
      notifyListeners();
      Uri url = Uri.parse("https://phone-store-project-default-rtdb.asia-southeast1.firebasedatabase.app/cart/${_id[index]}.json");
      await http.patch(
        url,
        body: json.encode(
          {
            "qty": temp,
          }
        ),
      );
    }
  }

  void checkAction(int index) async{
    String harga = allcart[index].price.replaceAll(new RegExp(r'[^\w\s]+'),''); // di sini untuk menghilangkan semua titik dari string harga
    String harga2 = harga.substring(3,harga.length);
    int valHarga = int.parse(harga2);
    int valHarga2 = valHarga*_qty[index];
    if (_isCheck[index] == false){
      _isCheck[index] = true;
      _totalHarga+=valHarga2;
      Uri url = Uri.parse("https://phone-store-project-default-rtdb.asia-southeast1.firebasedatabase.app/cart/${_id[index]}.json");
      await http.patch(
        url,
        body: json.encode(
          {
            "check": true,
          }
        ),
      );
    }
    else{
      _isCheck[index] = false;
      _totalHarga-=valHarga2;
      Uri url = Uri.parse("https://phone-store-project-default-rtdb.asia-southeast1.firebasedatabase.app/cart/${_id[index]}.json");
      await http.patch(
        url,
        body: json.encode(
          {
            "check": false,
          }
        ),
      );
    }
    notifyListeners();
  }

  Future <void> initialData(String email) async{
    _id.clear();
    allcart.clear();
    _qty.clear();
    _isCheck.clear();
    _totalHarga = 0;
    Uri url = Uri.parse("https://phone-store-project-default-rtdb.asia-southeast1.firebasedatabase.app/cart.json");
    var hasilGet = await http.get(url);

    if (hasilGet.body!= "null"){
      var dataCart = json.decode(hasilGet.body) as Map<String, dynamic>;
    
      dataCart.forEach((key, value) {
        if(value["email"]==email){
          _id.add(key);
          _allcart.add(phoneList.singleWhere((item) => item.name == value["phone_name"]));
          _qty.add(value["qty"]);
          _isCheck.add(value["check"]);
        }
      });
      _isInitialdata = true;
    }

    notifyListeners();
  }


  // @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }
}