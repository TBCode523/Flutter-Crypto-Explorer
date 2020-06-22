import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_block_explorer/data_model/address_container.dart';
import 'package:mobile_block_explorer/data_model/crypto.dart';
import 'package:mobile_block_explorer/data_model/transaction_model.dart';

class DetailedTransaction extends StatelessWidget{
final Crypto crypto;
final TransactionModel transactionModel;
 DetailedTransaction(this.crypto, this.transactionModel);
  @override
  Widget build(BuildContext context) {
   //TODO Always make it have a max height
    return Container(
         height:MediaQuery.of(context).size.height/1.42,
         
         width: MediaQuery.of(context).size.width,
          color: crypto.color,
         
            child: ListView(
             
             
              children: <Widget>[
                
                SelectableText("FINAL AMOUNT: "+btcParse(transactionModel.ammount) + " ${crypto.title}", style: cryptoTextStyle(),textAlign: TextAlign.right,),
                SelectableText(" FEE: " + btcParse(transactionModel.fees) + " ${crypto.title}", style: cryptoTextStyle(),textAlign: TextAlign.right,),
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children:<Widget>[
                    
                   addressContainerView(transactionModel.fromAddress),
                    
                    Padding(padding:EdgeInsets.all(10), child:Icon(Icons.arrow_forward),), 
                     addressContainerView(transactionModel.toAddress),
                ]),
                      
                
                
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: SelectableText("HASH: " + transactionModel.txID, style: cryptoTextStyle(),),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: SelectableText("CONFIRMATIONS: " + transactionModel.confirmations, style: cryptoTextStyle(),),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: SelectableText("DATE & TIME(UTC-1): " + timeParse(transactionModel.time), style: cryptoTextStyle(),),
               ),
               
              ]
            ),
          
        );
          
  }
 
  String timeParse(String str){
    //TRY TO HAVE DYNAMIC TIMING(IF POSSIBLE)
    
    String s1;
    for(int i =0; i < str.length; i++){
      if(String.fromCharCode(str.codeUnitAt(i))== "T") s1 = str.substring(0,i) +" "+ str.substring(i+1, str.length-1);
    }
    return s1;
  }
  Widget addressContainerView(AddressContainer addressContainer) {
    debugPrint(addressContainer.toString());
    
   return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
      children: addressContainer.addresses.map((String str) {
        String strParsed = addressParse(str);

        return Container(
          child: Padding(
          
          padding: const EdgeInsets.all(8.0),
          child: SelectableText(strParsed, style: cryptoTextStyle(),),
        ), width: 100,
        );
      }).toList(),
   );
    
  }

  String addressParse(String str) {
    if (str.startsWith("[")) {
      str = str.substring(1, str.length - 1);
    }
    
      return str;
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
 
  

}