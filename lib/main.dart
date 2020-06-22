import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_block_explorer/bloc/bloc.dart';
import 'pages/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: BlocProvider(
        builder: (context) => TransactionBloc(),
        child: Container(
          child: MyHomePage(),
        ),
      ),
    );
  }
}
