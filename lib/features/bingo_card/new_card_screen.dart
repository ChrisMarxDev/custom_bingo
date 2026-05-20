import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:custom_bingo/common/widgets/animated_number.dart';
import 'package:custom_bingo/common/widgets/async_elevated_button.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/bingo_item.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_popup_menu.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NewCardScreen extends StatefulWidget {
  const NewCardScreen({super.key});

  @override
  State<NewCardScreen> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
  static const int _maxGridSize = 24;
  final _nameController = TextEditingController();
  int _gridSize = 5;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasName = _nameController.text.isNotEmpty;
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.newCardTitle, style: context.h2),
        actions: [
          const BingoPopupMenu(host: BingoPopupMenuHost.newCard),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _nameController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: l10n.cardNameLabel,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: l10n.cardNameHint,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              AnimatedNumberSelector(
                value: _gridSize,
                minValue: 2, // Assuming a minimum grid size
                maxValue: _maxGridSize,
                onChanged: (newValue) {
                  setState(() {
                    _gridSize = newValue;
                  });
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: AsyncFilledButton(
                  onPressed: hasName
                      ? () async {
                          final name = _nameController.text;
                          final gridSize = _gridSize;
                          final sharedPrefs = sharedPrefsBeacon.value;
                          await saveBingoCard(
                            sharedPrefs,
                            BingoCardState(
                              name: name,
                              gridItems: List.generate(
                                gridSize,
                                (index) => List.generate(
                                  gridSize,
                                  (index) =>
                                      BingoItem(id: Uuid().v4(), text: ''),
                                ),
                              ),
                              lastChangeDateTime: DateTime.now(),
                            ),
                          );

                          await setCurrentSelectedBingoCard(name);
                          await addBingoCardName(name);

                          await bingoCardControllerRef.of(context).loadBoard();
                          // print('Bingo Grid Name: $name, Grid Size: $gridSize');
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => BingoCardScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      : null,
                  child: Text(l10n.createCardButton),
                ),
              ),
              const SizedBox(height: 24),
              AnimatedGridPreview(gridSize: _gridSize),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedGridPreview extends StatefulWidget {
  const AnimatedGridPreview({super.key, required this.gridSize});

  final int gridSize;

  @override
  State<AnimatedGridPreview> createState() => _AnimatedGridPreviewState();
}

class _AnimatedGridPreviewState extends State<AnimatedGridPreview> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 0.4;
    final hasCenter = widget.gridSize % 2 != 0;
    final totalItems = widget.gridSize * widget.gridSize;
    return Center(
      child: SizedBox(
        width: width,
        height: width,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: totalItems,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.gridSize,
          ),
          itemBuilder: (BuildContext context, int index) {
            final isMiddle = hasCenter && index == totalItems ~/ 2;
            final isTopRow = index < widget.gridSize;
            final isBottomRow = index >= totalItems - widget.gridSize;
            final isLeftColumn = index % widget.gridSize == 0;
            final isRightColumn = (index + 1) % widget.gridSize == 0;
            final borderRadius = BorderRadius.only(
              topLeft: isTopRow && isLeftColumn ? kRadiusCircular : Radius.zero,
              topRight: isTopRow && isRightColumn
                  ? kRadiusCircular
                  : Radius.zero,
              bottomLeft: isBottomRow && isLeftColumn
                  ? kRadiusCircular
                  : Radius.zero,
              bottomRight: isBottomRow && isRightColumn
                  ? kRadiusCircular
                  : Radius.zero,
            );

            return Container(
              margin: const EdgeInsets.all(0.5),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: isMiddle
                    ? context.primary.withValues(alpha: 0.12)
                    : context.surfaceContainerLowest,
                border: Border.all(
                  color: context.outlineColor,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
                borderRadius: borderRadius,
              ),
            );
          },
        ),
      ),
    );
  }
}
