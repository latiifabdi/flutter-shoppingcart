import 'scopemanage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'checkout.dart';

class Cart extends StatefulWidget{
  static final String route = "Cart-route";

  @override
  State<StatefulWidget> createState() {
    return CartState();
  }
}

class CartState extends State<Cart>{

  Widget generateCart(product){
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white12,
            border: Border(
                bottom: BorderSide(
                    color: Colors.grey[100],
                    width: 1.0
                ),
              top: BorderSide(
                  color: Colors.grey[100],
                  width: 1.0
              ),
            )
        ),
        height: 100.0,
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0
                  )
                ],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)
                ),
                image: DecorationImage(image: NetworkImage(product.image),fit: BoxFit.fill)
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0,left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(product.name,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15.0),),
                        ),
                        Container(
                            alignment: Alignment.bottomRight,
                            child: ScopedModelDescendant<AppModel>(
                              builder: (cotext,child,model){
                                return InkResponse(
                                    onTap: (){
                                      print('removing cart');
                                      model.removeCart(product);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Icon(Icons.remove_circle,color: Colors.red,),
                                    )
                                );
                              },
                            )
                        )
                      ],
                    ),
                    SizedBox(height: 5.0,),
                    Text("Price ${product.price.toString()}"),

                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0.0,
        title: Text("Cart List"),

      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 18.0),
        height: 60.0,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(color: Colors.grey[300],width: 1.0)
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 60.0,
                    child:  Text("Total Amount",style: TextStyle(fontSize: 12.0,color: Colors.grey),),
                  ),
                  Container(
                    child: ScopedModelDescendant<AppModel>(
                      builder: (context, child, model) {
                        return Text("\$${model.getCartPrice.toString()}",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w600));
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: RaisedButton(
                color: Colors.deepOrange,
                onPressed: () {
                  print("checkout page");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkout()));
                },
                child: Text("Checkout now", style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey[300],
              width: 1.0
            )
          )
        ),
        child: ScopedModelDescendant<AppModel>(
          builder: (context, child, model) {
            return ListView(
              shrinkWrap: true,
              children:  model.getCartList.map((d)=>generateCart(d)).toList(),
            );
          }
        )
      ),
    );
  }


}