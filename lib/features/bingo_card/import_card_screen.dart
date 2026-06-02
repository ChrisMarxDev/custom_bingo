import 'package:custom_bingo/app/view/app_route_paths.dart';
import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/app/view/root_navigation.dart';
import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/bingo_item.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_card_static_preview.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:custom_bingo/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> importIncomingBingoCard(
  BuildContext context,
  BingoCardState incoming, {
  bool closeCurrentRoute = false,
  String source = 'unknown',
}) async {
  final traceId = _newImportTraceId();
  logI(
    'Import[$traceId] started source=$source closeCurrentRoute=$closeCurrentRoute '
    'incoming=${_describeCardForLog(incoming)}',
  );

  try {
    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    final router = GoRouter.maybeOf(context);
    final hadSelectedBoard = currentSelectedBingoCardName.value != null;

    final existing = getBingoCardNames();
    final originalName = incoming.name.isEmpty
        ? l10n.defaultCardName
        : incoming.name;
    final finalName = _resolveImportedCardCollision(originalName, existing);
    final renamed = finalName != originalName;
    final renameToast = renamed ? l10n.importCollisionToast(finalName) : null;

    logI(
      'Import[$traceId] resolved target hadSelectedBoard=$hadSelectedBoard '
      'existingCount=${existing.length} renamed=$renamed '
      'originalName=${_describeNameForLog(originalName)} '
      'finalName=${_describeNameForLog(finalName)} '
      'navigatorCanPopAtStart=${navigator.canPop()} '
      'goRouterCanPopAtStart=${router?.canPop()}',
    );

    final toSave = BingoCardState(
      name: finalName,
      gridItems: incoming.gridItems,
      lastChangeDateTime: DateTime.now(),
      isEditing: false,
    );

    await saveBingoCard(sharedPrefsBeacon.value, toSave);
    await addBingoCardName(finalName);
    await setCurrentSelectedBingoCard(finalName);

    if (!context.mounted) {
      logW(
        'Import[$traceId] context unmounted after persistence; '
        'navigation skipped',
      );
      return;
    }

    await bingoCardControllerRef.of(context).loadBoard(finalName);

    final canPopNavigator = navigator.canPop();
    final canPopRouter = router?.canPop();
    logI(
      'Import[$traceId] navigation decision hadSelectedBoard=$hadSelectedBoard '
      'closeCurrentRoute=$closeCurrentRoute '
      'navigatorCanPop=$canPopNavigator goRouterCanPop=$canPopRouter',
    );

    if (hadSelectedBoard) {
      if (closeCurrentRoute && canPopNavigator) {
        navigator.pop();
      } else if (closeCurrentRoute && router != null) {
        logW(
          'Import[$traceId] cannot pop Navigator after import; '
          'going home with GoRouter instead',
        );
        router.go(AppRoutePaths.home);
      }
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

    logI('Import[$traceId] finished');
  } catch (error, stackTrace) {
    logError('Import[$traceId] failed source=$source', error, stackTrace);
    rethrow;
  }
}

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
                style: context.p2.copyWith(color: context.weakTextColor),
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
                    onPressed: _busy
                        ? null
                        : () => Navigator.of(context).maybePop(),
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
    try {
      await importIncomingBingoCard(
        context,
        widget.incoming,
        closeCurrentRoute: true,
        source: 'import_screen_confirm',
      );
    } catch (error, stackTrace) {
      logError('Import screen confirmation failed', error, stackTrace);
      if (!mounted) return;
      setState(() => _busy = false);
      showRootErrorToast(context.l10n.importBadLinkToast);
      return;
    }

    if (!mounted) return;
    setState(() => _busy = false);
  }
}

String _resolveImportedCardCollision(String name, List<String> existing) {
  if (!existing.contains(name)) return name;
  var n = 2;
  while (existing.contains('$name ($n)')) {
    n++;
  }
  return '$name ($n)';
}

String _newImportTraceId() {
  return DateTime.now().microsecondsSinceEpoch.toRadixString(36);
}

String _describeCardForLog(BingoCardState state) {
  final rows = state.gridItems.length;
  final columns = rows == 0 ? 0 : state.gridItems.first.length;
  final cells = state.gridItems.expand((row) => row).toList(growable: false);
  final markedCount = cells.where((cell) => cell.isDone).length;
  final emptyCount = cells.where((cell) => cell.text.trim().isEmpty).length;
  return [
    'name=${_describeNameForLog(state.name)}',
    'rows=$rows',
    'columns=$columns',
    'cells=${cells.length}',
    'marked=$markedCount',
    'empty=$emptyCount',
  ].join(' ');
}

String _describeNameForLog(String name) {
  return 'chars=${name.length} empty=${name.isEmpty} hash=${name.hashCode}';
}
