import 'package:flutter/material.dart';
import 'package:sea_demo01/src/repositories/categories_list.dart' as categoriesList;
import 'package:sea_demo01/src/ui/pages/user/login_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Menu Page",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          elevation: 0.5,
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor,
                ])),
          ),
        ),
        body: categoriesList.list == null
            ? const Center(child: CircularProgressIndicator())
            : new GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 25.0),
                padding: const EdgeInsets.all(10.0),
                itemCount: categoriesList.list.length,
                itemBuilder: (BuildContext context, int index) {
                  return new GridTile(
                    footer: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Flexible(
                            child: new SizedBox(
                              height: 16.0,
                              width: 100.0,
                              child: new Text(
                                categoriesList.list[index]["name"],
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ]),
                    child: new Container(
                      height: 500.0,
                      child: new GestureDetector(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            new SizedBox(
                              height: 100.0,
                              width: 100.0,
                              child: new Row(
                                children: <Widget>[
                                  new Stack(
                                    children: <Widget>[
                                      new SizedBox(
                                        child: new Container(
                                          child: new CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 40.0,
                                            child: new Icon(
                                                categoriesList.list[index]
                                                    ["icon"],
                                                size: 40.0,
                                                color: categoriesList
                                                    .list[index]["color"]),
                                          ),
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onTap: () async {
                          Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()),
                                        );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
      onWillPop: () async => false,
    );
  }
}
