import 'package:flutter/material.dart';
import 'package:lesson4/sceen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  static const counterKey = 'counter';

  @override
  void initState() {
    _initCounter();
    super.initState();
  }

  Future _initCounter() async {
    _counter = await _getCounter();
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });

    await _setCounter();
  }

  Future _setCounter() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(counterKey, _counter);
  }

  Future<int> _getCounter() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {});
    return prefs.getInt(counterKey) ?? 0;
  }

  Future _clearCounter() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {});
    return prefs.remove(counterKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 5),
            ElevatedButton(
                onPressed: () {
                  if (_counter != 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Screen(count: _counter),
                        ));
                  } else {
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Внимание!'),
                            content: const Text(
                                'Нажмите на кнопку + хотя бы 1 раз!'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'))
                            ],
                          );
                        });
                  }
                },
                child: Text('Перейти на новое окно')),
            SizedBox(height: 5),
            SizedBox(height: 5),
            ElevatedButton(
                onPressed: () {
                  _clearCounter();
                },
                child: Text('Удалить сохраненный счетчик')),
            SizedBox(height: 5),
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
