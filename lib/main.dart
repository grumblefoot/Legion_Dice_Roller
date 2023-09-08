import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Legion Dice Roller',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Legion Dice Roller Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}
class Dice extends StatelessWidget {
  final int dice_no;

  Dice({required this.dice_no});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: FloatingActionButton(
          child: Image.asset('assets/images/inverted-dice-$dice_no.png'),
          onPressed: () {
            // You can add any logic here if needed
          },
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;
  int _currentDiceNo = 1;
  int _numberOfDice = 1; // the number of dice to be rolled

  List<int?> _diceResults = List.filled(25,null);

  void _rollDice(){
    _numberOfDice = _counter;
    setState(() {
      for (int i = 0; i < _numberOfDice; i++) {
        _currentDiceNo = Random().nextInt(6) + 1; // Generate a new random value
        _diceResults[i] = _currentDiceNo;
      }
    });
  }
  void _decrementCounter() {
    setState(() {
      _counter = _counter > 1 ? _counter - 1 : 1;
    });
  }
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
     });
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'The Current Dice count is:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: _decrementCounter,
                      child: Icon(Icons.remove),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                      onPressed: _incrementCounter,
                      child: Icon(Icons.add),
                  ),
                ],
              ),
              TextField(
                style: Theme.of(context).textTheme.headlineMedium,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Number of Dice (n)',
                ),
                onChanged: (value) {

                  setState(() {

                    _counter = int.parse(value);
                  });
                },
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 25,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index < _counter) {
                    return Dice(dice_no: _diceResults[index] ?? 1);
                  } else {
                    return Container(); // Empty container for unused cells
                  }
                },
              ),
            ],
          ),

        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _rollDice,
        tooltip: 'Roll the Dice!',
        child: const Icon(Icons.add),
      ),


      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
