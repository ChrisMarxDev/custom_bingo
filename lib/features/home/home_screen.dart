import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/new_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_card_static_preview.dart';
import 'package:custom_bingo/features/home/home_controller.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:state_beacon/state_beacon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = homeScreenControllerRef.of(context);
    final boards = controller.boards.watch(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.yourCardsHeader, style: context.h2),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primary,
        foregroundColor: context.onPrimary,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NewCardScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: () async => controller.reloadBoards(),
          child: boards.isEmpty
              ? const _EmptyHomeGrid()
              : GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.76,
                  ),
                  itemCount: boards.length,
                  itemBuilder: (context, index) {
                    final board = boards[index];
                    return _HomeBoardTile(
                      board: board,
                      onOpen: () => _openBoard(context, board),
                      onDelete: () =>
                          _confirmDeleteBoard(context, controller, board),
                    );
                  },
                ),
        ),
      ),
    );
  }

  Future<void> _confirmDeleteBoard(
    BuildContext context,
    HomeScreenController controller,
    HomeBoardPreview board,
  ) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteCardTitle),
        content: const Text('Do you want to delete this'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    await controller.deleteBoard(board.name);
  }

  Future<void> _openBoard(BuildContext context, HomeBoardPreview board) async {
    await setCurrentSelectedBingoCard(board.name);
    await bingoCardControllerRef.of(context).loadBoard(board.name);
    if (!context.mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const BingoCardScreen()),
      (route) => false,
    );
  }
}

class _HomeBoardTile extends StatelessWidget {
  const _HomeBoardTile({
    required this.board,
    required this.onOpen,
    required this.onDelete,
  });

  final HomeBoardPreview board;
  final VoidCallback onOpen;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Material(
          color: context.cardColor,
          borderRadius: kBorderRadius,
          child: InkWell(
            onTap: onOpen,
            borderRadius: kBorderRadius,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: kBorderRadius,
                border: Border.all(color: context.outlineColor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: _BoardPreviewFrame(board: board)),
                    const SizedBox(height: 10),
                    Text(
                      board.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.p1.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: _DeleteBoardButton(onPressed: onDelete),
        ),
      ],
    );
  }
}

class _DeleteBoardButton extends StatelessWidget {
  const _DeleteBoardButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: context.l10n.delete,
      child: IconButton.filledTonal(
        onPressed: onPressed,
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints.tightFor(width: 48, height: 48),
        iconSize: 20,
        color: context.error,
        icon: const Icon(Icons.delete_outline_rounded),
      ),
    );
  }
}

class _BoardPreviewFrame extends StatelessWidget {
  const _BoardPreviewFrame({required this.board});

  final HomeBoardPreview board;

  @override
  Widget build(BuildContext context) {
    final hasPreview = board.gridItems.isNotEmpty;

    return ClipRRect(
      borderRadius: kBorderradiusSmall,
      child: ColoredBox(
        color: context.surfaceContainerLow,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: hasPreview
                ? FittedBox(
                    fit: BoxFit.contain,
                    child: BingoCardStaticPreview(
                      gridItems: board.gridItems,
                      cellSize: 36,
                    ),
                  )
                : Icon(
                    Icons.grid_view_rounded,
                    size: 32,
                    color: context.weakTextColor,
                  ),
          ),
        ),
      ),
    );
  }
}

class _EmptyHomeGrid extends StatelessWidget {
  const _EmptyHomeGrid();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.24),
        Icon(Icons.grid_view_rounded, size: 40, color: context.weakTextColor),
        const SizedBox(height: 12),
        Text(
          'No boards yet',
          textAlign: TextAlign.center,
          style: context.p1.copyWith(
            color: context.weakTextColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
