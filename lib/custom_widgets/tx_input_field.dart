import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_block_explorer/bloc/bloc.dart';
import 'package:mobile_block_explorer/bloc/transaction_bloc.dart';
import 'package:mobile_block_explorer/data_model/crypto.dart';


class TxInputField extends StatefulWidget{
 Crypto crypto;
 TxInputField({Key key, this.crypto }): super(key:key);

  @override
  _TxInputFieldState createState() => _TxInputFieldState( crypto);
  
   
}
class _TxInputFieldState extends State<TxInputField>{
  final Crypto crypto;
  _TxInputFieldState(this.crypto);
  @override
  Widget build(BuildContext context) {
   
    
     return  Container(
        color: crypto.color,
        child: TextField(
          
          onSubmitted:(value) => submitDetailTransaction(context, value),
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: "Enter a ${crypto.title} transaction ID",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: Icon(Icons.search),
            
          ),
        ),
      );
    

  }
 void submitDetailTransaction(BuildContext context, String txID){
      debugPrint("Submitting Detail Transaction!");
       final detailTransactionBloc = BlocProvider.of<TransactionBloc>(context);
    detailTransactionBloc.add(GetTransaction(crypto.url+"/"+txID));
   
}
  
}