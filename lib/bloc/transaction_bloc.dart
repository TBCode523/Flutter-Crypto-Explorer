import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_block_explorer/repos/transaction_repo.dart';
import './bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  
  TransactionBloc();
  @override
  TransactionState get initialState => InitialTransaction();

  @override
  Stream<TransactionState> mapEventToState(
    TransactionEvent event,
  ) async* {
    yield LoadingTransaction();
    if (event is GetBlockchain) {
      try {
        debugPrint("Deploying TransactionBloc");
        final transactionList = await TransactionRepo().getTransactions(event.blockchain_url);
        debugPrint("TransactionList is Initialized!");
        yield LoadedTransactionList(transactionList);
      } on NetworkError {
        yield TransactionError(NetworkError.message);
      }
    }
    else if (event is GetTransaction) {
      try {
        debugPrint("Deploying TransactionBloc");
        final transaction = await TransactionRepo().getDetailedTransaction(event.blockchain_url);
        debugPrint("Transaction Data retrieval is complete!");
        yield LoadedDetailTransaction(transaction);
      } on NetworkError {
        yield TransactionError(NetworkError.message);
      }
    }
  }
}
