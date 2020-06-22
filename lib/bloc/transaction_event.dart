import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();
}

class GetBlockchain extends TransactionEvent {
  final String blockchain_url;
  GetBlockchain(this.blockchain_url);

  @override
  List<Object> get props => [blockchain_url];
}
class GetTransaction extends TransactionEvent {
  final String blockchain_url;
  GetTransaction(this.blockchain_url);

  @override
  List<Object> get props => [blockchain_url];
}

