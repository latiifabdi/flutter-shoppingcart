import 'package:scoped_model/scoped_model.dart';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:localstorage/localstorage.dart';


class AppModel extends Model {

  var data;
  List<Product> cartItems = [];

  List<Product> _cartList = [];

  String  cartMsg = "";
  bool success = false;

  List<Product> getProducts(String str) {
    final jsonData = json.decode(str);
    return new List<Product>.from(jsonData.map((x) => Product.fromJson(x)));
  }



  Future<List<Product>> fetchProducts() async {
    var response = await http.get("http://shop.test/api/products");
    
    var jsonData = json.decode(response.body);

    List<Product> products = [];

    for (var product in jsonData) {
      products.add(
        Product(
          id: product["id"], 
          name: product["name"], 
          description: product["description"],
          price: product["price"],
          image: product["image"], 
          fav: product["fav"], 
          rating: product["rating"]
      ));
    }

    print(products.length);

    return products;
  }

  AppModel() {
    data = fetchProducts();


  }

  Future<List<Product>> get products => data;

  void emptyCart() {
    _cartList.clear();
    notifyListeners();
  }

  void addCart(product){
    print(product);

    _cartList.add(product);

    print(_cartList[0].name);
    
    cartMsg = "added successfully";

    success = true;

    notifyListeners();
  }

  List<Product> get getCartList {
    return List.from(_cartList);
  }

  addToFav(product){
    print(product.fav);

    product.fav = !product.fav;

    notifyListeners();
  }

  double get getCartPrice {
    double price = 0;
    getCartList.forEach((Product pro) {
      price += pro.price;
    });

    return price;
  }

  void removeCart(product) {
    print(product.name);

    _cartList.remove(product);

    cartMsg = "removed from the cart successfully";

    success = true;


    notifyListeners();
  }


}


class Product{
  String name;
  int id;
  String image;
  double rating;
  int price;
  bool fav;
  String description;

  Product({this.id, this.name, this.description, this.price, this.image, this.fav, this.rating});

  factory Product.fromJson(Map<String, dynamic> json) => new Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
        fav: json["fav"],
        rating: json["rating"]
      );


}