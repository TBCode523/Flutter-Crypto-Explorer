import 'package:flutter/material.dart';

import 'crypto.dart';

const List<Crypto> crypto = const <Crypto>[
  const Crypto(
      title: "BTC",
      url: "https://api.blockcypher.com/v1/btc/main/txs",
      color: Colors.orange,
      imageUrl: "images/BTC.png"),
      
  // const Crypto(title: "ETH", url: "https://reqres.in/api/users?page=2", color: Colors.purple, imageUrl: "images/ETH.png"),
  const Crypto(
      title: "LTC",
      url: "https://api.blockcypher.com/v1/ltc/main/txs",
      color: Colors.grey,
      imageUrl: "images/LTC.png"),
  //const Crypto(title: "Dash", url: "https://reqres.in/api/users?page=2", color: Colors.blue, imageUrl: "images/Dash.png")
];
