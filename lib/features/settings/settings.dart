import 'package:custom_bingo/common/services/user_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userorient_flutter/userorient_flutter.dart';

void openBoard(BuildContext context) {
  UserOrient.setUser(
    uniqueIdentifier: userIdBeacon.value,
    fullName: 'Anonymous',
  );

  UserOrient.openBoard(context);
}

class KoFiButton extends StatelessWidget {
  const KoFiButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        launchUrl(Uri.parse('https://ko-fi.com/chrismarx'));
      },
      style: FilledButton.styleFrom(
        backgroundColor: Color(0xffFF6433),
        foregroundColor: Colors.white,
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/images/ko-fi.svg', height: 24),
          const SizedBox(width: 8),
          const Text('Support me on Ko-Fi'),
        ],
      ),
    );
  }
}
