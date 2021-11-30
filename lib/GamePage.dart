import 'dart:math';

import 'package:flutter/material.dart';

class ManishApp extends StatefulWidget {
  @override
  _ManishAppState createState() => _ManishAppState();
}

class _ManishAppState extends State<ManishApp> {
  //____________________________________________link images
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage lucky = AssetImage("images/rupee.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");
  //___________________________________________________variable init
  List<String> itemArray;
  int luckyNumber;
  //___________________________________________________init array
  @override
  void initState() {
    super.initState();
    setState(() {
      itemArray = List<String>.generate(25, (index) => 'empty');
      generateRandomNumber();
    });
  }

  //___________________________________________________generate Random Number
  generateRandomNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  //_________________________________________________Get image method
  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case 'lucky':
        return lucky;
        break;
      case 'unlucky':
        return unlucky;
        break;
    }
    return circle;
  }

  //_________________________________________________Play game method
  playGame(int index) {
    if (luckyNumber == index) {
      setState(() {
        itemArray[index] = 'lucky';
      });
    } else {
      setState(() {
        itemArray[index] = 'unlucky';
      });
    }
  }

  //__________________________________________________show all
  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, 'unlucky');
      itemArray[luckyNumber] = 'lucky';
    });
  }

//_____________________________________________________reset
  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, 'empty');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Scratch and win"), backgroundColor: Colors.teal),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: itemArray.length,
                itemBuilder: (context, i) => SizedBox(
                    height: 50,
                    width: 50,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          this.playGame(i);
                        },
                        child: Image(
                          image: this.getImage(i),
                        ))),
              ),
            ),
            RaisedButton(
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: showAll,
              child: Text(
                "ShowAll",
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: resetGame,
              child: Text(
                "Reset",
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
