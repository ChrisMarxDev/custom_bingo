import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/app/view/root_navigation.dart';
import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/bingo_item.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_card_static_preview.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ImportCardScreen extends StatefulWidget {
  const ImportCardScreen({super.key, required this.incoming});

  final BingoCardState incoming;

  @override
  State<ImportCardScreen> createState() => _ImportCardScreenState();
}

class _ImportCardScreenState extends State<ImportCardScreen> {
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final size = widget.incoming.gridItems.length;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _busy ? null : () => Navigator.of(context).maybePop(),
        ),
        title: Text(l10n.importTitle, style: context.h5),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.incoming.name.isEmpty
                    ? l10n.defaultCardName
                    : widget.incoming.name,
                textAlign: TextAlign.center,
                style: context.h3,
              ),
              const SizedBox(height: 4),
              Text(
                '$size × $size',
                style: context.p2.copyWith(color: kGrey3),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: BingoCardStaticPreview(
                      gridItems: widget.incoming.gridItems,
                      cellSize: _previewCellSize(context, size),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.importBody,
                textAlign: TextAlign.center,
                style: context.p1,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed:
                        _busy ? null : () => Navigator.of(context).maybePop(),
                    child: Text(l10n.importCancel),
                  ),
                  const SizedBox(width: 16),
                  FilledButton(
                    onPressed: _busy ? null : _onConfirm,
                    child: _busy
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.importConfirm),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _previewCellSize(BuildContext context, int size) {
    final width = MediaQuery.sizeOf(context).width - 64;
    final raw = width / size;
    return raw.clamp(36, 80).toDouble();
  }

  Future<void> _onConfirm() async {
    if (_busy) return;
    setState(() => _busy = true);

    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    final hadSelectedBoard = currentSelectedBingoCardName.value != null;

    final existing = getBingoCardNames();
    final originalName = widget.incoming.name.isEmpty
        ? l10n.defaultCardName
        : widget.incoming.name;
    final finalName = _resolveCollision(originalName, existing);
    final renamed = finalName != originalName;
    final renameToast = renamed ? l10n.importCollisionToast(finalName) : null;

    final toSave = BingoCardState(
      name: finalName,
      gridItems: widget.incoming.gridItems,
      lastChangeDateTime: DateTime.now(),
      isEditing: false,
    );
    await saveBingoCard(sharedPrefsBeacon.value, toSave);
    await addBingoCardName(finalName);
    await setCurrentSelectedBingoCard(finalName);

    if (!mounted) return;
    bingoCardControllerRef.of(context).loadBoard(finalName);

    if (hadSelectedBoard) {
      navigator.pop();
    } else {
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const BingoCardScreen()),
        (_) => false,
      );
    }

    if (renameToast != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showRootNeutralToast(renameToast);
      });
    }
  }

  String _resolveCollision(String name, List<String> existing) {
    if (!existing.contains(name)) return name;
    var n = 2;
    while (existing.contains('$name ($n)')) {
      n++;
    }
    return '$name ($n)';
  }
}
