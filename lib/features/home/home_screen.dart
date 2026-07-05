import 'dart:async';

import 'package:custom_bingo/app/view/app_route_paths.dart';
import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/premium_service.dart';
import 'package:custom_bingo/common/services/rating_prompt_service.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_card_static_preview.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_popup_menu.dart';
import 'package:custom_bingo/features/home/home_controller.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        actions: const [
          BingoPopupMenu(host: BingoPopupMenuHost.home),
          SizedBox(width: 16),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primary,
        foregroundColor: context.onPrimary,
        onPressed: () {
          context.go(AppRoutePaths.root);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: () async => controller.reloadBoards(),
          child: boards.isEmpty
              ? const _EmptyHomeGrid()
              : CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    const SliverToBoxAdapter(child: _SupportCarousel()),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                      sliver: SliverGrid.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                  ],
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
        content: Text(l10n.deleteCardConfirm),
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

    context.go(AppRoutePaths.bingoCard);
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

class _SupportCarousel extends StatefulWidget {
  const _SupportCarousel();

  @override
  State<_SupportCarousel> createState() => _SupportCarouselState();
}

class _SupportCarouselState extends State<_SupportCarousel> {
  late final PageController _pageController;
  Timer? _timer;
  var _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _nextPage());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (!mounted || !_pageController.hasClients) return;

    _page = (_page + 1) % 2;
    unawaited(
      _pageController.animateToPage(
        _page,
        duration: const Duration(milliseconds: 520),
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPremium = isPremiumUserBeacon.watch(context);
    if (isPremium) return const SizedBox.shrink();

    final items = [
      _SupportCarouselItem(
        icon: Icons.favorite_rounded,
        title: context.l10n.supportCarouselProTitle,
        subtitle: context.l10n.supportCarouselProSubtitle,
        color: context.primary,
        onTap: () => context.push(AppRoutePaths.paywall),
      ),
      _SupportCarouselItem(
        icon: Icons.star_rounded,
        title: context.l10n.supportCarouselRateTitle,
        subtitle: context.l10n.supportCarouselRateSubtitle,
        color: const Color(0xFFEA580C),
        onTap: () {
          unawaited(
            ratingPromptServiceBeacon.value.maybeRequestFromSupportPrompt(
              context,
            ),
          );
        },
      ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: SizedBox(
        height: 112,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (page) {
                setState(() => _page = page % items.length);
              },
              itemCount: items.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: items[index],
              ),
            ),
            Positioned(
              right: 14,
              top: 0,
              bottom: 0,
              child: _SupportCarouselIndicator(
                count: items.length,
                activeIndex: _page,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportCarouselItem extends StatelessWidget {
  const _SupportCarouselItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = color.computeLuminance() > 0.45
        ? kDarkBlack
        : kWhite;
    final gradientEndColor = Color.lerp(color, foregroundColor, 0.12) ?? color;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, gradientEndColor],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 42, 14),
            child: Row(
              children: [
                Icon(icon, color: foregroundColor, size: 38),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.p1.copyWith(
                          color: foregroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.p2.copyWith(
                          color: foregroundColor.withValues(alpha: 0.78),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.chevron_right_rounded, color: foregroundColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SupportCarouselIndicator extends StatelessWidget {
  const _SupportCarouselIndicator({
    required this.count,
    required this.activeIndex,
  });

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(count, (index) {
          final isActive = index == activeIndex;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            width: 6,
            height: isActive ? 18 : 6,
            margin: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              color: kWhite.withValues(alpha: isActive ? 0.95 : 0.45),
              borderRadius: BorderRadius.circular(999),
            ),
          );
        }),
      ),
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
        const _SupportCarousel(),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.16),
        Icon(Icons.grid_view_rounded, size: 40, color: context.weakTextColor),
        const SizedBox(height: 12),
        Text(
          context.l10n.noBoardsYet,
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
