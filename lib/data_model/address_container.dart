import 'package:flutter/widgets.dart';

class AddressContainer {
  final List<String> addresses;

  AddressContainer(this.addresses);

  factory AddressContainer.fromJson(jsonOutputInput) {
    /* debugPrint("In address container factory method!");
    debugPrint("Testing Condition");
    debugPrint("The json field is: \n" + jsonOutputInput.toString());*/

    List addressesTemp = jsonOutputInput as List;
    List<String> addresses = [];
    debugPrint("Address temp is: \n" + addressesTemp.toString());

    if (addressesTemp != null) {
      // debugPrint("Address Container Json is not null");

      for (int i = 0; i < addressesTemp.length; i++) {
        debugPrint(
            "At index $i \n" + jsonOutputInput[i]['addresses'].toString());
        addresses.add(jsonOutputInput[i]['addresses'].toString());
      }
      return AddressContainer(addresses);
    } else {
      debugPrint("AddressContainer json is null");
      addressesTemp = ["Empty"];
      return AddressContainer(addressesTemp);
    }
  }
  @override
  String toString() {
    return addresses.toString();
  }
}
