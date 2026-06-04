import 'package:custom_bingo/app/view/app_route_paths.dart';
import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/settings/settings.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:custom_bingo/util/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:state_beacon/state_beacon.dart';
import 'package:flutter/material.dart';
import 'package:custom_bingo/common/widgets/popup_menu.dart';

enum BingoPopupMenuHost { board, newCard, home }

class BingoPopupMenu extends StatelessWidget {
  const BingoPopupMenu({required this.host, super.key});

  final BingoPopupMenuHost host;

  @override
  Widget build(BuildContext context) {
    final bingoCardNames = bingoGridNamesBeacon.watch(context);
    final l10n = context.l10n;
    return PopupMenu(
      child: Container(
        decoration: BoxDecoration(
          color: context.cardColor,
          shape: BoxShape.circle,
          border: Border.all(color: context.outlineColor),
          boxShadow: [
            BoxShadow(
              color: context.shadowColor.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(PhosphorIcons.gearSix(), color: context.textColor),
      ),
      followerAnchor: Alignment.topRight,
      targetAnchor: Alignment.bottomRight,
      popupMenuBuilder:
          (BuildContext menuContext, void Function() hideOverlay) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 260, maxHeight: 600),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () async {
                        hideOverlay();
                        await setCurrentSelectedBingoCard(null);
                        if (!context.mounted) return;
                        context.go(AppRoutePaths.root);
                        logI('Selected "new bingo board" from the popup menu');
                      },
                      child: Row(
                        children: [
                          Icon(PhosphorIcons.plus()),
                          const SizedBox(width: 8),
                          Text(l10n.newCardMenuItem),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 12.0),
                      child: Text(l10n.yourCardsHeader),
                    ),
                    const Divider(),
                    TextButton(
                      onPressed: () {
                        hideOverlay();
                        context.go(AppRoutePaths.home);
                      },
                      child: Row(
                        children: [
                          Icon(PhosphorIcons.squaresFour()),
                          const SizedBox(width: 8),
                          const Text('All boards'),
                        ],
                      ),
                    ),
                    ...bingoCardNames.map((name) {
                      return TextButton(
                        onPressed: () async {
                          hideOverlay();
                          await setCurrentSelectedBingoCard(name);
                          await bingoCardControllerRef
                              .of(context)
                              .loadBoard(name);
                          if (!context.mounted) return;

                          if (host == BingoPopupMenuHost.board) {
                            return;
                          }

                          context.go(AppRoutePaths.bingoCard);
                        },
                        child: Text('- $name'),
                      );
                    }).toList(),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 12.0),
                      child: Text(l10n.settingsHeader),
                    ),
                    Divider(),
                    TextButton(
                      onPressed: () {
                        hideOverlay();
                        context.push(AppRoutePaths.settings);
                      },
                      child: Row(
                        children: [
                          Icon(PhosphorIcons.palette()),
                          const SizedBox(width: 8),
                          Text(l10n.appearanceMenuItem),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        hideOverlay();
                        context.push(AppRoutePaths.preMadeTilesEdit);
                      },
                      child: Row(
                        children: [
                          Icon(PhosphorIcons.squaresFour()),
                          const SizedBox(width: 8),
                          Text(l10n.preMadeTilesTitle),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        hideOverlay();
                        await openUserOrient(context);
                      },
                      child: Row(
                        children: [
                          Icon(PhosphorIcons.chat()),
                          const SizedBox(width: 8),
                          Text(l10n.proposeFeatures),
                        ],
                      ),
                    ),
                    KoFiButton(),
                    if (kDebugMode)
                      TextButton(
                        onPressed: () {
                          sharedPrefsBeacon.value.clear();
                          hideOverlay();
                          context.go(AppRoutePaths.root);
                        },
                        child: const Text('Clear Settings'),
                      ),
                  ],
                ),
              ),
            );
          },
    );
  }
}
