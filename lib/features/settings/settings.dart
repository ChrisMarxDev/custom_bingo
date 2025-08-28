import 'package:flutter/material.dart';
import 'package:userorient_flutter/userorient_flutter.dart';

void openBoard(BuildContext context) {
  UserOrient.setUser(
    uniqueIdentifier: 'ce-a45-678-901',
    fullName: 'Anonymous',
    email: 'anonymous@anonymous.com',
  );

  UserOrient.openBoard(context);
}
