import 'package:flutter/material.dart';
import 'plakalar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Inventory App"),
      ),*/
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://image.freepik.com/free-photo/close-up-black-marble-textured-background_53876-63511.jpg"),
              fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Plakalar())),
              child: Card(
                elevation: 15,
                child: Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: Text(
                    "Plaka Koleksiyonu",
                    style: TextStyle(
                        fontFamily: "ElYazisi",
                        fontSize: 45,
                        color: Colors.black45),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://previews.123rf.com/images/alexeybykov/alexeybykov1511/alexeybykov151100035/48245835-seamless-beige-marble-background-with-natural-pattern-tiled-cream-marble-stone-wall-texture-.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 15,
              child: Container(
                height: 200,
                alignment: Alignment.center,
                child: Text(
                  "Ebatlı Koleksiyonu",
                  style: TextStyle(
                      fontFamily: "ElYazisi",
                      fontSize: 45,
                      color: Colors.white70),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://image.freepik.com/free-photo/black-marbled-surface_53876-90798.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
