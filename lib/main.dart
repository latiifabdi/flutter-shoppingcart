import 'package:flutter/material.dart';
import 'home.dart';
import 'package:scoped_model/scoped_model.dart';
import 'scopemanage.dart';
import 'details.dart';
import 'cart.dart';


void main() => runApp(Main());


class Main extends StatelessWidget {
  final routes = <String,WidgetBuilder>{
    Home.route:(BuildContext context)=>Home(),
    Cart.route :(BuildContext context)=>Cart(),

  };

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      
      model: AppModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        routes: routes,
        theme: ThemeData(
          primaryColor: Colors.white
        ),
      ),
    );
  }


}