import 'package:flutter/material.dart';
import "package:scoped_model/scoped_model.dart";
import "scopemanage.dart";
import 'package:flutter_rating/flutter_rating.dart';
import 'details.dart';
import 'cart.dart';

class Home extends StatefulWidget {
  static final String route = "Home-route";

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  Widget GridGenerate(products, aspectRadtio) {
    return FutureBuilder(
      future: products,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: GridView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: aspectRadtio),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(5.0),
                  child: GestureDetector(
                      onTap: () {
                        print(snapshot.data[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Details(detail: snapshot.data[index])));
                      },
                      child: Container(
                          height: 350.0,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12, blurRadius: 8.0)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 180.0,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: Image.network(
                                            snapshot.data[index].image,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: snapshot.data[index].fav
                                            ? Icon(
                                                Icons.favorite,
                                                size: 20.0,
                                                color: Colors.red,
                                              )
                                            : Icon(
                                                Icons.favorite_border,
                                                size: 20.0,
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "${snapshot.data[index].name}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new StarRating(
                                        size: 15,
                                        rating: snapshot.data[index].rating,
                                        color: Colors.orange,
                                        borderColor: Colors.grey,
                                        starCount: 5),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        "\$${snapshot.data[index].price}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ))),
                );
              }),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        elevation: 0.0,
        
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: InkResponse(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                  },
                  child: Icon(Icons.shopping_cart),
                ),
              ),
              Positioned(
                child: ScopedModelDescendant<AppModel>(
                  builder: (context, child, model) {
                    return Container(
                      child: Text(
                        (model.getCartList.length > 0) ? model.getCartList.length.toString() : "",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold),
                      )
                        
                    );
                  },
                ),
              ),
              
            ],
          )
        ],
      ),
      body: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) {
          return GridGenerate(model.products, (itemWidth / itemHeight));
        },
      ),
    );
  }
}
