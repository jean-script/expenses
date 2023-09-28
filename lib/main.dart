import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  ExpensesApp({super.key});
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.purpleAccent,
        ),
        textTheme: tema.textTheme.copyWith(
          titleLarge: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.openSans(
            fontSize: 20 * MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transaction.where((element) {
      return element.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transaction.add(newTransaction);
    });
    _closeTransactionFormModal();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((element) => element.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  _closeTransactionFormModal() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        'Despesas Pessoais',
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      actions: [
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(
              _showChart ? Icons.list : Icons.pie_chart_rounded,
            ),
          ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: const Icon(
            Icons.add,
          ),
        )
      ],
    );
    final availabelHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
              SizedBox(
                height: availabelHeight * (isLandscape ? 0.7 : 0.25),
                child: Chart(
                  recentTransaction: _recentTransactions,
                ),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availabelHeight * 0.75,
                child: TransactionList(
                    transactions: _transaction,
                    removeTransaction: _deleteTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
