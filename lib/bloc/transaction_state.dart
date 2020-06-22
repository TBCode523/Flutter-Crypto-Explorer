import 'package:equatable/equatable.dart';
import 'package:mobile_block_explorer/data_model/transaction_model.dart';
import 'package:mobile_block_explorer/data_model/transaction_model_list.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();
}

class InitialTransaction extends TransactionState {
  @override
  List<Object> get props => [];
}

class LoadingTransaction extends TransactionState {
  @override
  List<Object> get props => [];
}

class LoadedTransactionList extends TransactionState {
  final TransactionModelList transactionList;
  const LoadedTransactionList(this.transactionList);
  @override
  List<Object> get props => [];
}
class LoadedDetailTransaction extends TransactionState{
  final TransactionModel transactionModel;
  const LoadedDetailTransaction(this.transactionModel);
  @override
  List<Object> get props => [];

}

class TransactionError extends TransactionState {
  final String errorMessage;
  const TransactionError(this.errorMessage);
  @override
  List<Object> get props => [];
}
