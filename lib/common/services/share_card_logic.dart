import 'dart:io';

import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_card_content.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareCardPopup(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (context) => RecipeSharingDialog(),
  );
}

class RecipeSharingDialog extends StatefulWidget {
  const RecipeSharingDialog({super.key});

  @override
  State<RecipeSharingDialog> createState() => _RecipeSharingDialogState();
}

class _RecipeSharingDialogState extends State<RecipeSharingDialog> {
  late final ScreenshotController screenshotController;

  @override
  void initState() {
    super.initState();
    screenshotController = ScreenshotController();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: context.background,
                  border: Border.all(color: context.primary, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Screenshot(
                        controller: screenshotController,
                        child: ColoredBox(
                          color: context.background,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BingoCardContentWrapper(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
                const SizedBox(width: 16),
                FilledButton(
                  onPressed: () async {
                    final imageData = await screenshotController.capture();

                    if (imageData != null) {
                      final tempDir = await getTemporaryDirectory();
                      final tempPath =
                          '${tempDir.path}/recipe_share_${DateTime.now().millisecondsSinceEpoch}.png';
                      await File(tempPath).writeAsBytes(imageData);
                      await Share.shareXFiles(
                        [XFile(tempPath)],
                        subject: 'Bingo Card',
                        text: 'Bingo Card',
                      );
                    }
                  },
                  child: const Text('Share'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// class RecipeSharingWidget extends StatelessWidget {
//   const RecipeSharingWidget({required this.recipe, super.key});

//   final Recipe recipe;

//   @override
//   Widget build(BuildContext context) {
//     return IgnorePointer(
//       child: ColoredBox(
//         color: context.background,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Stack(
//                   children: [
//                     const SizedBox(width: double.infinity, height: 1),
//                     RecipePathImage(imagePath: recipe.imagePath),
//                     Positioned.fill(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             stops: const [0, 0.7, 1],
//                             colors: [
//                               context.background.withValues(alpha: 0),
//                               context.background.withValues(alpha: 0.2),
//                               context.background,
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Positioned(
//                   top: 12,
//                   right: 12,
//                   child: Transform.scale(
//                     scale: 0.5,
//                     alignment: Alignment.topRight,
//                     child: const LogoWithText(),
//                   ),
//                 ),
//                 Positioned(
//                   top: 264,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           context.background.withValues(alpha: 0),
//                           context.background.withValues(alpha: 0.5),
//                           context.background,
//                         ],
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             recipe.name ?? '',
//                             style: context.h6.copyWith(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           LayoutBuilder(
//                             builder: (context, constraints) {
//                               final maxWidth = constraints.maxWidth;
//                               final totalWidth = maxWidth * 2;
//                               const spacing = 16.0;
//                               final elementWidth = maxWidth - spacing;
//                               return Stack(
//                                 clipBehavior: Clip.none,
//                                 children: [
//                                   SingleChildScrollView(
//                                     physics:
//                                         const NeverScrollableScrollPhysics(),
//                                     scrollDirection: Axis.horizontal,
//                                     child: Transform.scale(
//                                       alignment: Alignment.topLeft,
//                                       scale: 0.5,
//                                       child: SizedBox(
//                                         width: totalWidth,
//                                         child: Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             SizedBox(
//                                               width: elementWidth,
//                                               child: Column(
//                                                 children: [
//                                                   if (recipe.ingredients !=
//                                                           null &&
//                                                       recipe.ingredients!
//                                                           .isNotEmpty)
//                                                     IngredientsWidget(
//                                                       ingredients:
//                                                           recipe.ingredients,
//                                                       showPantryIngredients:
//                                                           false,
//                                                       showServingsSelector:
//                                                           false,
//                                                     ),
//                                                   if (recipe.nutritionInfo !=
//                                                       null)
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                         top: 16,
//                                                       ),
//                                                       child:
//                                                           NutritionInfoWidget(
//                                                         cardAlignment:
//                                                             Alignment.topLeft,
//                                                         nutritionInfo: recipe
//                                                             .nutritionInfo,
//                                                       ),
//                                                     ),
//                                                 ],
//                                               ),
//                                             ),
//                                             const SizedBox(width: spacing),
//                                             if (recipe.steps != null &&
//                                                 recipe.steps!.isNotEmpty)
//                                               SizedBox(
//                                                 width: elementWidth,
//                                                 child: RecipeStepsWidget(
//                                                   steps: recipe.steps,
//                                                 ),
//                                               ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
