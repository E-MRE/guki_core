import 'package:example/examples/results_example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ResultsExample _resultsExample = ResultsExample();

  String _oddNumberText = '';
  String _dataListText = '';
  int _counter = 0;

  void _onPressed() {
    var isNumberResult = _resultsExample.isOdd(_counter);
    var splitResult = _resultsExample.splitData(
        'A,B,C,D', isNumberResult.success ? ',' : '.');

    setState(() {
      _oddNumberText =
          '$_counter is ${isNumberResult.success ? 'odd' : 'even'}';

      _dataListText =
          '${splitResult.success ? 'Splitted Data: ' : ''} ${splitResult.data?.toString() ?? splitResult.message}';

      _counter++;
    });
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
            Text(
              _oddNumberText,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16),
            Text(
              _dataListText,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
