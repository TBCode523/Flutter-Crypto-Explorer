import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_block_explorer/bloc/bloc.dart';
import 'package:mobile_block_explorer/custom_widgets/detailed_transaction.dart';
import 'package:mobile_block_explorer/custom_widgets/transaction_card.dart';
import 'package:mobile_block_explorer/custom_widgets/tx_input_field.dart';
import 'package:mobile_block_explorer/data_model/transaction_model.dart';
import 'package:mobile_block_explorer/data_model/transaction_model_list.dart';
import 'package:mobile_block_explorer/data_model/crypto.dart';

import 'package:mobile_block_explorer/data_model/cryptoList.dart';

class MyHomePage extends StatefulWidget {
  final String title = "Mobile Block Explorer";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
   
    return DefaultTabController(
      length: crypto.length,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            actions: <Widget>[
            
            ],
            title: Text(
              widget.title,
              style: TextStyle(color: Colors.white),
            )
            ,
            bottom: TabBar(
                labelPadding:
                    EdgeInsets.only(left: 20, right: 20, top: .1, bottom: .1),
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(color: Colors.white),
                tabs: crypto.map((Crypto crypto) {
                  return Container(
                    height: 35,
                    child: Tab(
                      child: Image.asset(crypto.imageUrl),
                    ),
                  );
                }).toList()),
          ),
          body: TabBarView(
              

              children: crypto.map((Crypto crypto) {
            return BlocListener<TransactionBloc, TransactionState>(
              listener: (context, state) {
                if (state is TransactionError)
                  return Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage),
                  ));
              },
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is InitialTransaction) {
                    return initialBuild(context, crypto);
                  } else if (state is LoadingTransaction) {
                    debugPrint("state is LoadingTransaction");
                    return buildLoading();
                  } else if (state is LoadedTransactionList) {
                    debugPrint("state is Loaded Transaction!");
                    return Container(
                        color: crypto.color,
                        child: buildLoaded(
                            context, state.transactionList, crypto));
                  }else if(state is LoadedDetailTransaction){
                    debugPrint("state is Loaded Detail Transaction");
                    return buildDetailed(context, state.transactionModel, crypto) ;
                  }
                  
                   else if (state is TransactionError) {
                    debugPrint("Transaction Error was called");
                    return initialBuild(context, crypto);
                  }
                },
              ),
            );
          }).toList())),
    );
    
  }

  Widget initialBuild(BuildContext context, Crypto crypto) {
    return Scaffold(
       backgroundColor: crypto.color,
        body: Center(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                TxInputField(crypto: crypto),
             Center(child: Text( "Press the button to surf the Blockchain!", style: TextStyle(fontSize: 22), textAlign: TextAlign.center,))
              
            ],
          ),
        ),
        
        floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: crypto.color,
        child: Icon(Icons.refresh),
        onPressed: (){
          submitCrypto(context, crypto.url);
        },
        tooltip: 'Refreshes Blockchain Data',
      ),);
        
  }

  Widget buildLoading() {
    debugPrint("buildLoading is called!");
    return Center(child: CircularProgressIndicator());
  }

  Widget buildLoaded(BuildContext context,
      TransactionModelList transactionModelList, Crypto crypto) {
    debugPrint("Build loaded is being called");
    return Scaffold(
         
          body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          header(crypto.color),
          TxInputField(crypto: crypto,),
          Expanded(
              child: ListView.builder(
            itemCount: transactionModelList.transActionModelList == null
                ? 0
                : transactionModelList.transActionModelList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TransactionCard(
                  transactionModel:
                      transactionModelList.transActionModelList[index],
                  crypto: crypto,
                  context: context,
                ),
              );
            },
          )),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: crypto.color,
        child: Icon(Icons.refresh),
        onPressed: (){
          submitCrypto(context, crypto.url);
        },
         tooltip: 'Refreshes Blockchain Data',
      ),
    );
  }
  Widget buildDetailed(BuildContext context, TransactionModel transactionModel, Crypto crypto){
    
        return Scaffold(
              resizeToAvoidBottomInset: false,
                  body: Container(
            color: crypto.color,
            child: Column(
              children: <Widget>[
                TxInputField(
                  crypto: crypto,
                ),
                DetailedTransaction(crypto, transactionModel),
              ],
            ),
          ),
          floatingActionButton:FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: crypto.color,
        child: Icon(Icons.refresh),
        onPressed: (){
          submitCrypto(context, crypto.url);
        },
        tooltip: 'Refreshes Blockchain Data',
      ),
      ); 
        
  }


  Widget headerText(String str) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(str,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              wordSpacing: 10,
              color: Colors.white)),
    );
  }

  Widget header(Color color) {
    const String INPUT_HEADER = "FROM";

    const String OUTPUT_HEADER = "TO";
    const String AMOUNT = "AMOUNT";
    const String TX_ID_HEADER = "TXID";

    return Container(
      color: color,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            headerText(INPUT_HEADER),
            headerText(AMOUNT),
            headerText(OUTPUT_HEADER),
            headerText(TX_ID_HEADER),
          ]),
    );
  }

  void submitCrypto(BuildContext context, String cryptoURL) {
    debugPrint("Submitting Crypto!");
    final transactionBloc = BlocProvider.of<TransactionBloc>(context);
    transactionBloc.add(GetBlockchain(cryptoURL));
    transactionBloc.drain();
  }
  void submitTxID(String txID){
      debugPrint("Submitting TxID!");
       final transactionBloc = BlocProvider.of<TransactionBloc>(context);
    transactionBloc.add(GetBlockchain(txID));
    transactionBloc.drain();
}
  
}
