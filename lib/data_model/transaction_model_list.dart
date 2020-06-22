import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:mobile_block_explorer/data_model/transaction_model.dart';

import 'address_container.dart';

class TransactionModelList {
  List<TransactionModel> transActionModelList;

  TransactionModelList(this.transActionModelList);

  factory TransactionModelList.fromJson(jsonDecoded) {
    List<TransactionModel> transactionModels = [];
    debugPrint("Retrieving TransactionLists");
    if (jsonDecoded != null) {
      List transactions = jsonDecoded as List;

      for (int i = 0; i < transactions.length; i++) {
        debugPrint("Adding a TransactionModel at index $i!");
//  debugPrint(transactions[i].toString());
        transactionModels.add(TransactionModel.fromJson(transactions[i]));
        debugPrint("Added a TransactionModel at index $i!");
      }
      return TransactionModelList(transactionModels);
    } else {
      debugPrint("Json was null!");
      transactionModels.add(TransactionModel(
          ammount: "NOT FOUND",
          toAddress: AddressContainer.fromJson(json),
          fromAddress: AddressContainer.fromJson(json),
          txID: "NOT FOUND",
          time: "NOT FOUND"));
      return TransactionModelList(transactionModels);
    }
  }
}