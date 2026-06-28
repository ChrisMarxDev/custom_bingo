// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get newCardTitle => '创建新的宾果表';

  @override
  String get editCardTitle => '编辑宾果表';

  @override
  String get cardNameLabel => '宾果表名称 *';

  @override
  String get cardNameHint => '输入宾果表名称';

  @override
  String get createCardButton => '创建宾果表';

  @override
  String get updateCardButton => '更新宾果表';

  @override
  String get newBoardPreMadeSectionTitle => 'Your pre-made items';

  @override
  String get newBoardPreMadeButton => 'Start with pre-made items';

  @override
  String get newBoardPreMadeChangeButton => 'Change pre-made items';

  @override
  String get newBoardPreMadeClearButton => 'Clear pre-made items';

  @override
  String newBoardPreMadeAppliedCount(int count) {
    return '$count pre-made entries applied';
  }

  @override
  String newBoardPreMadeFullSummary(int used) {
    return '$used will be drawn at random for this board.';
  }

  @override
  String newBoardPreMadePartialSummary(int used, int blank) {
    return '$used cells will be filled. $blank will stay blank.';
  }

  @override
  String get defaultCardName => '宾果卡';

  @override
  String get toggleHint => '长按可勾选格子';

  @override
  String get editingHintBefore => 'Press the lock icon';

  @override
  String get editingHintAfter => ' to make the fields not editable anymore.';

  @override
  String get deleteCardTitle => 'Delete Card';

  @override
  String get deleteCardConfirm => 'Are you sure you want to delete this card?';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get shuffleCardTitle => 'Shuffle Card';

  @override
  String get shuffleCardConfirm =>
      'Are you sure you want to shuffle this card? All fields will be unchecked, after shuffling.';

  @override
  String get shuffle => '随机排列';

  @override
  String get ratingPromptTitle => 'Do you like Custom Bingo?';

  @override
  String get ratingPromptBody =>
      'If so, a quick store review helps others find it.';

  @override
  String get ratingPromptNo => 'Not really';

  @override
  String get ratingPromptYes => 'Yes, I like it';

  @override
  String get boardActionShare => '分享';

  @override
  String get boardActionEditBoard => '编辑棋盘';

  @override
  String get boardActionAddPreMadeItems => 'Add pre-made items';

  @override
  String get cellHint => '输入文字…';

  @override
  String get edit => '编辑';

  @override
  String get markDone => 'Mark Done';

  @override
  String get markNotDone => 'Mark Not Done';

  @override
  String get newCardMenuItem => '新建宾果棋盘';

  @override
  String get yourCardsHeader => '你的棋盘';

  @override
  String get settingsHeader => '设置';

  @override
  String get appearanceMenuItem => 'Appearance';

  @override
  String get settingsAppearanceSection => '外观';

  @override
  String get settingsPreferencesSection => '偏好设置';

  @override
  String get settingsBoardsSection => '棋盘';

  @override
  String get settingsHelpSection => '更多';

  @override
  String get settingsSupportSection => '支持';

  @override
  String get themeColorLabel => '主题颜色';

  @override
  String get themeColorSettingsDescription => '选择整个应用使用的配色。';

  @override
  String get languageSettingsTitle => '语言';

  @override
  String get languageSettingsSelectorLabel => '应用语言';

  @override
  String languageSettingsSystemOption(String language) {
    return '系统默认（$language）';
  }

  @override
  String languageSettingsSystemDescription(String language) {
    return '跟随手机语言：$language。';
  }

  @override
  String get languageSettingsOverrideDescription => '使用此语言，而不是手机语言。';

  @override
  String get darkModeLabel => '深色模式';

  @override
  String get darkModeSettingsDescription => '使用更深色的界面。';

  @override
  String get enableConfettiLabel => '彩纸';

  @override
  String get enableConfettiSettingsDescription => '完成宾果时显示庆祝效果。';

  @override
  String get preMadeTilesTitle => 'Pre-made tiles';

  @override
  String get preMadeTilesSettingsDescription =>
      'Create reusable tile text for future boards.';

  @override
  String get preMadeTilesDescription =>
      'Create reusable bingo entries here. When you create a new board, you can add them without typing everything again.';

  @override
  String get preMadeTilesSelectMode => 'Select';

  @override
  String get preMadeTilesEditMode => 'Edit';

  @override
  String get preMadeTileHint => 'Tile text';

  @override
  String get preMadeTilesAdd => 'Add tile';

  @override
  String get preMadeTilesDelete => 'Delete tile';

  @override
  String get preMadeTilesSelectAll => 'Un/select all';

  @override
  String get preMadeTilesSelectNone => 'Select none';

  @override
  String get preMadeTilesApply => 'Apply';

  @override
  String get preMadeTilesReplaceItems => 'Replace items';

  @override
  String get preMadeTilesFillItems => 'Fill items';

  @override
  String get preMadeTilesBoardActionHelp =>
      'Replace swaps the board entries with a random draw from your selection. Fill only adds items to empty tiles. On odd boards, the center tile stays in place.';

  @override
  String preMadeTilesSelectedCount(int selected, int total) {
    return '$selected / $total selected';
  }

  @override
  String get preMadeTilesEmptyTitle => 'No tiles yet';

  @override
  String get preMadeTilesEmptyBody =>
      'Add a tile to start building a reusable list.';

  @override
  String get proposeFeatures => 'Propose Features';

  @override
  String get proposeFeaturesSettingsDescription =>
      'Vote on ideas and suggest what to build next.';

  @override
  String get supportMeDirectly => 'Support the developer';

  @override
  String get supportMeDirectlySettingsDescription =>
      'Help fund development and keep the app improving.';

  @override
  String get supportCarouselProTitle => 'Support Custom Bingo';

  @override
  String get supportCarouselProSubtitle =>
      'Unlock bonus colors and help keep the app independent.';

  @override
  String get supportCarouselRateTitle => 'Enjoying the app?';

  @override
  String get supportCarouselRateSubtitle =>
      'A quick review helps more people find Custom Bingo.';

  @override
  String get rateTheApp => 'Rate the app';

  @override
  String get rateTheAppSettingsDescription => 'Open the store rating prompt.';

  @override
  String get contactMe => 'Contact me';

  @override
  String get contactMeSettingsDescription =>
      'Send feedback, questions, or bug reports by email.';

  @override
  String get paywallTitle => 'Support Custom Bingo';

  @override
  String get paywallThankYouTitle => 'Thank you';

  @override
  String get paywallSupportTitle => 'Support Custom Bingo';

  @override
  String get paywallSupportBody =>
      'This purchase supports me, the developer, directly. You get my gratitude and a few small bonus things for your boards.';

  @override
  String get paywallBonusGratitude => 'My gratitude, sincerely.';

  @override
  String get paywallBonusColors => 'A few extra board colors.';

  @override
  String get paywallBonusExtras => 'Small supporter extras over time.';

  @override
  String get paywallFreeForever =>
      'No one ever needs to pay for this app. Custom Bingo stays usable for everyone.';

  @override
  String get paywallLoadingPrice => 'Loading price';

  @override
  String get paywallUnavailable => 'Unavailable';

  @override
  String get paywallSupportOnce => 'Support once';

  @override
  String get paywallRestorePurchase => 'Restore purchase';

  @override
  String get paywallProActiveToast => 'Custom Bingo Pro is active.';

  @override
  String get paywallPurchaseInactiveToast =>
      'Purchase finished, but Pro is not active.';

  @override
  String get paywallProRestoredToast => 'Custom Bingo Pro restored.';

  @override
  String get paywallNoPurchaseFoundToast => 'No Pro purchase found.';

  @override
  String get paywallPurchasesUnavailable =>
      'Purchases are unavailable right now.';

  @override
  String get paywallPlatformUnavailable =>
      'Purchases are unavailable on this platform.';

  @override
  String get paywallCouldNotLoad => 'Could not load purchase information.';

  @override
  String get shareTitle => '分享宾果卡';

  @override
  String get shareDialogPrompt => 'How would you like to share?';

  @override
  String get shareImageOptionTitle => '以图片分享';

  @override
  String get shareImageOptionHelper =>
      'Send a picture of your card. Anyone can see it — even without the app.';

  @override
  String get shareImageOptionButton => '分享图片';

  @override
  String get shareInviteOptionTitle => '邀请朋友一起玩';

  @override
  String get shareInviteOptionHelper =>
      'Send this link to your friends who also have this app installed. They get the same card and you can play together.';

  @override
  String get shareInviteIncludeMarks => 'Include my checkmarks';

  @override
  String get shareInviteIncludeMarksHelper =>
      'When on, your friends will see what you\'ve already crossed off.';

  @override
  String get shareInviteOptionButton => '发送邀请';

  @override
  String shareInviteText(String name, String link) {
    return '和我一起玩“$name”！在应用中打开：\n$link';
  }

  @override
  String get close => '关闭';

  @override
  String get shareSubject => 'Bingo Card';

  @override
  String get importTitle => 'A friend shared a bingo card with you';

  @override
  String get importBody => 'Add it to your cards so you can play along?';

  @override
  String get importConfirm => '添加到我的卡片';

  @override
  String get importCancel => '暂不';

  @override
  String importCollisionToast(String newName) {
    return 'You already had a card with this name, so I added it as \"$newName\".';
  }

  @override
  String get importBadLinkToast =>
      'Sorry, this invite couldn\'t be opened. Ask your friend to send it again.';

  @override
  String get importOutdatedAppToast => 'Update the app to open this invite.';

  @override
  String get toastInfo => '信息';

  @override
  String get toastSuccess => '成功';

  @override
  String get toastError => '错误';

  @override
  String get lastChangeNever => '上次更改：从未';

  @override
  String lastChange(String date, String time) {
    return '上次更改：$date $time';
  }

  @override
  String get screenshotCaptionPlaying =>
      'Just a simple app to create bingo board.\n\nNo signup, no ads, fully free to use.';

  @override
  String get screenshotCaptionCreate =>
      'Literally just 2 screens to create a bingo grid.';

  @override
  String get screenshotCaptionLocked => 'That\'s it.';

  @override
  String get screenshotBoardName => 'David\'s Wedding';

  @override
  String get screenshotTilePhoneDuringVows => 'Phone during vows';

  @override
  String get screenshotTileChampagneSpilled => 'Champagne spilled';

  @override
  String get screenshotTileSpeechTears => 'Speech tears';

  @override
  String get screenshotTileDramaticEntrance => 'Dramatic entrance';

  @override
  String get screenshotTileKidsDanceFloor => 'Kids take the dance floor';

  @override
  String get screenshotTileGuestToast => 'Guest gives a toast';

  @override
  String get screenshotTileCrowdClapsEarly => 'Crowd claps early';

  @override
  String get screenshotTileDjClassic => 'DJ plays a classic';

  @override
  String get screenshotTileGroupPhotoChaos => 'Group photo chaos';
}
