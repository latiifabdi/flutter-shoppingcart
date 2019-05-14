import 'package:flutter/material.dart';
import 'home.dart';
import 'scopemanage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';


class Checkout extends StatefulWidget {
  static final String route = "Cart-route";

  @override
  State<StatefulWidget> createState() {
    return CheckoutState();
  }
}

class CheckoutState extends State<Checkout> {
  final _formKey = GlobalKey<FormState>();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
      
        title: Text("Order"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Enter Your Name"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your name';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Enter Your email"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your email';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Enter Your Address"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your addredd';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Enter Your City"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your city';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Enter zip code"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter zip code';
                  }
                },
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ScopedModelDescendant<AppModel>(
                      builder: (context, child, model) {
                    return RaisedButton(
                      color: Colors.deepOrange,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, we want to show a Snackbar
                          final snackBar = SnackBar(
                            content: Text('Yay! Your orderd successfully!'),
                            backgroundColor: Colors.green,
                            
                          );

                          
                          Scaffold.of(context).showSnackBar(snackBar);

                          model.emptyCart();

                          Timer(Duration(milliseconds: 2000), (){
                            Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
                          });
                        }
                      },
                      child:
                          Text("Submit", style: TextStyle(color: Colors.white)),
                    );
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
