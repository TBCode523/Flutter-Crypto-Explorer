import 'dart:core';
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'address_container.dart';

class TransactionModel {
  final AddressContainer toAddress;
  final AddressContainer fromAddress;
  final String txID;
  final String time;
  final String ammount;
  final String confirmations;
  final String fees;
  TransactionModel(
      {this.toAddress, this.fromAddress, this.txID, this.time, this.ammount, this.confirmations, this.fees});

  factory TransactionModel.fromJson(/*Map<String, dynamic>*/ json) {
    debugPrint("Retreving the TransactionModel");
    if (json != null) {
      /*  debugPrint("json is not null for TransactionModel");
    debugPrint("The total " + json['total'].toString());
     debugPrint("The txID " + json['hash'].toString());
    debugPrint("The time " + json['size'].toString());
     debugPrint("The inputs "+  AddressContainer.fromJson(json['inputs']).toString());
    debugPrint("The outputs " +  AddressContainer.fromJson(json['outputs']).toString());
   */

      return TransactionModel(
          confirmations: json['confirmations'].toString(),
          ammount: json['total'].toString(),
          toAddress: AddressContainer.fromJson(json['outputs']),
          fromAddress: AddressContainer.fromJson(json['inputs']),
          txID: json['hash'].toString(),
          time: json['received'].toString(),
          fees: json['fees'].toString()
          );
          
    } else {
      debugPrint("json is null for TransactionModel");
      return TransactionModel();
    }
  }
}




