import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


import 'package:mobile_block_explorer/data_model/transaction_model.dart';
import 'package:mobile_block_explorer/data_model/transaction_model_list.dart';

class TransactionRepo{
  Future<TransactionModel> getDetailedTransaction(String crypto) async {

    //TODO Make it return an error if there is no internet or takes too long!
    int timeout = 5;
    try{
     http.Response response = await http.get(crypto).timeout(Duration(seconds: timeout));
    
    
    if(response.statusCode == 200) return parsedJson(response);
     else{ 
       NetworkError.message = "NETWORK ERROR!";
       throw NetworkError();
       }
    } on TimeoutException catch (e) {
   NetworkError.message = "CONNECTION TIMED OUT!";
  throw NetworkError();
} on SocketException catch (e) {
  NetworkError.message = "NO INTERNET CONNECTION! ";
  throw NetworkError();
} 
    
  }
 
Future<TransactionModelList> getTransactions(String crypto) async{
  debugPrint("Getting unconfirmed transaction from " + crypto);
  int timeout = 5;
    try{
     http.Response response = await http.get(crypto).timeout(Duration(seconds: timeout));
    
  
     
   if(response.statusCode == 200)  return parsedJsonList(response);
     else{ 
       NetworkError.message = "NETWORK ERROR!";
       throw NetworkError();
       }
    } on TimeoutException catch (e) {
      NetworkError.message = "CONNECTION TIMED OUT!";
  throw NetworkError();
} on SocketException catch (e) {
  NetworkError.message = "NO INTERNET CONNECTION! ";
  throw NetworkError();
} 
}

  TransactionModel parsedJson(final response){
     debugPrint("Executing Parsed Json function");
    
      final jsonDecoded = json.decode(response.body);
     return TransactionModel.fromJson(jsonDecoded);
  }

  TransactionModelList parsedJsonList(final response){
    
    final jsonDecoded = jsonDecode(response.body);
    return TransactionModelList.fromJson(jsonDecoded);
  }
}

class NetworkError extends Error{
static String message = "Error";



}