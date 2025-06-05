import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/new_card_screen.dart';
import 'package:state_beacon/state_beacon.dart';
import 'package:flutter/material.dart';
import 'package:custom_bingo/common/widgets/popup_menu.dart';

class BingoPopupMenu extends StatelessWidget {
  const BingoPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final bingoCardNames = bingoGridNamesBeacon.watch(context);
    return PopupMenu(
      child: const Icon(Icons.more_vert),
      followerAnchor: Alignment.topRight,
      targetAnchor: Alignment.bottomRight,
      popupMenuBuilder: (BuildContext context, void Function() hideOverlay) {
        return SizedBox(
          width: 200,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    hideOverlay();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => NewCardScreen()),
                        (route) => false);
                    print('New bingo board selected');
                  },
                  child: const Text('New bingo board'),
                ),
                if (bingoCardNames.isNotEmpty) const Divider(),
                ...bingoCardNames.map((name) {
                  return TextButton(
                    onPressed: () async {
                      hideOverlay();
                      await setCurrentSelectedBingoCard(name);
                      bingoCardControllerRef.of(context).loadBoard(name);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => BingoCardScreen()),
                          (route) => false);
                    },
                    child: Text('- $name'),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
