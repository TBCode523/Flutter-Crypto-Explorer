import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_block_explorer/bloc/bloc.dart';
import 'package:mobile_block_explorer/bloc/transaction_bloc.dart';
import 'package:mobile_block_explorer/data_model/transaction_model.dart';
import 'package:mobile_block_explorer/data_model/address_container.dart';
import 'package:mobile_block_explorer/data_model/crypto.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transactionModel;
  final Crypto crypto;
  final BuildContext context;
  const TransactionCard({this.transactionModel, this.crypto,this.context});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => submitTxID(transactionModel.txID),
          child: Card(
        color: crypto.color,
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: <Widget>[
            addressContainerView(transactionModel.fromAddress),
            Container(
             
              child: Text(
                btcParse(transactionModel.ammount) + "\n ${crypto.title}",
                style: cryptoTextStyle(),
              ),
            ),
            addressContainerView(transactionModel.toAddress),
            Text(
                transactionModel.txID.substring(0, 6) + "....",overflow: TextOverflow.fade,
              ),
            
          ],
        ),
      ),
    );
  }

  Column addressContainerView(AddressContainer addressContainer) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: addressContainer.addresses.map((String str) {
        String strParsed = addressParse(str);

        return Container(
         
          child: Text(strParsed)
          );
      }).toList(),
    );
  }

  String addressParse(String str) {
    if (str.startsWith("[")) {
      str = str.substring(1, str.length - 1);
    }
    if (str.length > 8) {
      return str.substring(0, 8) + ".....";
    } else
      return str + ".....";
  }

  String btcParse(String str) {
    debugPrint(str + " ${crypto.title}");
    String temp = str;
    const int BTC_MAX_DIGITS = 9;
    if (str.length < BTC_MAX_DIGITS) {
      for (int i = str.length; i < BTC_MAX_DIGITS - 1; i++) {
        temp = "0" + temp;
      }
      temp = "0." + temp;
    } else if (str.length > BTC_MAX_DIGITS) {
      temp = str.substring(0, (str.length - (BTC_MAX_DIGITS - 1))) +
          "." +
          str.substring(str.length - BTC_MAX_DIGITS + 1);
    } else {
      temp = str.substring(0, 1) + "." + str.substring(1);
    }
    return temp;
  }

  TextStyle cryptoTextStyle() {
    return TextStyle(fontSize: 18);
  }
 
  void submitTxID(String txID){
      debugPrint("Submitting TxID!");
       final detailTransactionBloc = BlocProvider.of<TransactionBloc>(context);
    detailTransactionBloc.add(GetTransaction(crypto.url+"/"+txID));
}
}
