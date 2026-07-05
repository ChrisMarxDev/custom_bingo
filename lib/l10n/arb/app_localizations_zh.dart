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
  String get newBoardPreMadeSectionTitle => '你的预制项目';

  @override
  String get newBoardPreMadeButton => '从预制项目开始';

  @override
  String get newBoardPreMadeChangeButton => '更改预制项目';

  @override
  String get newBoardPreMadeClearButton => '清除预制项目';

  @override
  String newBoardPreMadeAppliedCount(int count) {
    return '已应用 $count 个预制条目';
  }

  @override
  String newBoardPreMadeFullSummary(int used) {
    return '将为此棋盘随机抽取 $used 个。';
  }

  @override
  String newBoardPreMadePartialSummary(int used, int blank) {
    return '将填充 $used 个格子，$blank 个保持空白。';
  }

  @override
  String get defaultCardName => '宾果卡';

  @override
  String get toggleHint => '长按可勾选格子';

  @override
  String get editingHintBefore => '按锁定图标';

  @override
  String get editingHintAfter => '，让格子不再可编辑。';

  @override
  String get deleteCardTitle => '删除卡片';

  @override
  String get deleteCardConfirm => '确定要删除这张卡片吗？';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get shuffleCardTitle => '打乱卡片';

  @override
  String get shuffleCardConfirm => '确定要打乱这张卡片吗？打乱后所有格子都会取消勾选。';

  @override
  String get shuffle => '随机排列';

  @override
  String get ratingPromptTitle => '你喜欢 Custom Bingo 吗？';

  @override
  String get ratingPromptBody => '如果喜欢，商店里的简短评价能帮助更多人发现它。';

  @override
  String get ratingPromptNo => '不太喜欢';

  @override
  String get ratingPromptYes => '是的，我喜欢';

  @override
  String get boardActionShare => '分享';

  @override
  String get boardActionEditBoard => '编辑棋盘';

  @override
  String get boardActionAddPreMadeItems => '添加预制项目';

  @override
  String get cellHint => '输入文字…';

  @override
  String get edit => '编辑';

  @override
  String get markDone => '标记完成';

  @override
  String get markNotDone => '标记未完成';

  @override
  String get newCardMenuItem => '新建宾果棋盘';

  @override
  String get allBoardsMenuItem => '所有棋盘';

  @override
  String get yourCardsHeader => '你的棋盘';

  @override
  String get noBoardsYet => '还没有棋盘';

  @override
  String get pageNotFoundTitle => '找不到页面';

  @override
  String get homeButton => '首页';

  @override
  String revenueCatUserIdLabel(String userId) {
    return 'RevenueCat 用户 ID：$userId';
  }

  @override
  String get copyRevenueCatUserIdTooltip => '复制 RevenueCat 用户 ID';

  @override
  String get revenueCatUserIdCopiedToast => '已复制 RevenueCat 用户 ID。';

  @override
  String get settingsHeader => '设置';

  @override
  String get clearSettingsMenuItem => '清除设置';

  @override
  String get appearanceMenuItem => '外观';

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
  String get preMadeTilesTitle => '预制格子';

  @override
  String get preMadeTilesSettingsDescription => '为未来的棋盘创建可复用的格子文字。';

  @override
  String get preMadeTilesDescription => '在这里创建可复用的宾果条目。创建新棋盘时，无需重新输入即可添加。';

  @override
  String get preMadeTilesSelectMode => '选择';

  @override
  String get preMadeTilesEditMode => '编辑';

  @override
  String get preMadeTileHint => '格子文字';

  @override
  String get preMadeTilesAdd => '添加格子';

  @override
  String get preMadeTilesDelete => '删除格子';

  @override
  String get preMadeTilesSelectAll => '全选/取消全选';

  @override
  String get preMadeTilesSelectNone => '全部不选';

  @override
  String get preMadeTilesApply => '应用';

  @override
  String get preMadeTilesReplaceItems => '替换项目';

  @override
  String get preMadeTilesFillItems => '填充项目';

  @override
  String get preMadeTilesBoardActionHelp =>
      '替换会从你的选择中随机抽取并替换棋盘条目。填充只会把项目添加到空格子。奇数棋盘中，中心格保持不变。';

  @override
  String preMadeTilesSelectedCount(int selected, int total) {
    return '已选择 $selected / $total';
  }

  @override
  String get preMadeTilesEmptyTitle => '还没有格子';

  @override
  String get preMadeTilesEmptyBody => '添加一个格子，开始建立可复用列表。';

  @override
  String get proposeFeatures => '提议功能';

  @override
  String get proposeFeaturesSettingsDescription => '为想法投票，并建议下一步要构建什么。';

  @override
  String get supportMeDirectly => '支持开发者';

  @override
  String get supportMeDirectlySettingsDescription => '帮助资助开发，让应用持续改进。';

  @override
  String get supportCarouselProTitle => '支持 Custom Bingo';

  @override
  String get supportCarouselProSubtitle => '解锁额外颜色，并帮助应用保持独立。';

  @override
  String get supportCarouselRateTitle => '喜欢这个应用吗？';

  @override
  String get supportCarouselRateSubtitle => '简短评价能帮助更多人发现 Custom Bingo。';

  @override
  String get rateTheApp => '评价应用';

  @override
  String get rateTheAppSettingsDescription => '打开商店评分提示。';

  @override
  String get contactMe => '联系我';

  @override
  String get contactMeSettingsDescription => '通过电子邮件发送反馈、问题或错误报告。';

  @override
  String get paywallTitle => '支持 Custom Bingo';

  @override
  String get paywallThankYouTitle => '谢谢';

  @override
  String get paywallSupportTitle => '支持 Custom Bingo';

  @override
  String get paywallSupportBody => '这笔购买会直接支持我，也就是开发者。你会得到我的感谢，以及一些用于棋盘的小奖励。';

  @override
  String get paywallBonusGratitude => '真诚感谢。';

  @override
  String get paywallBonusColors => '一些额外棋盘颜色。';

  @override
  String get paywallBonusExtras => '未来的小支持者奖励。';

  @override
  String get paywallFreeForever => '没有人必须为这个应用付费。Custom Bingo 会继续对所有人可用。';

  @override
  String get paywallLoadingPrice => '正在加载价格';

  @override
  String get paywallUnavailable => '不可用';

  @override
  String get paywallSupportOnce => '支持一次';

  @override
  String get paywallRestorePurchase => '恢复购买';

  @override
  String get paywallProActiveToast => 'Custom Bingo Pro 已启用。';

  @override
  String get paywallPurchaseInactiveToast => '购买已完成，但 Pro 未启用。';

  @override
  String get paywallProRestoredToast => 'Custom Bingo Pro 已恢复。';

  @override
  String get paywallNoPurchaseFoundToast => '未找到 Pro 购买记录。';

  @override
  String get paywallPurchasesUnavailable => '目前无法购买。';

  @override
  String get paywallPlatformUnavailable => '此平台不支持购买。';

  @override
  String get paywallCouldNotLoad => '无法加载购买信息。';

  @override
  String get shareTitle => '分享宾果卡';

  @override
  String get shareDialogPrompt => '你想如何分享？';

  @override
  String get shareImageOptionTitle => '以图片分享';

  @override
  String get shareImageOptionHelper => '发送你的卡片图片。即使没有应用，任何人也能查看。';

  @override
  String get shareImageOptionButton => '分享图片';

  @override
  String get shareInviteOptionTitle => '邀请朋友一起玩';

  @override
  String get shareInviteOptionHelper =>
      '把这个链接发送给同样安装了此应用的朋友。他们会得到同一张卡片，你们可以一起玩。';

  @override
  String get shareInviteIncludeMarks => '包含我的勾选';

  @override
  String get shareInviteIncludeMarksHelper => '开启后，朋友会看到你已经划掉的内容。';

  @override
  String get shareInviteOptionButton => '发送邀请';

  @override
  String shareInviteText(String name, String link) {
    return '和我一起玩“$name”！在应用中打开：\n$link';
  }

  @override
  String get close => '关闭';

  @override
  String get shareSubject => '宾果卡片';

  @override
  String get importTitle => '朋友与你分享了一张宾果卡片';

  @override
  String get importBody => '要添加到你的卡片中一起玩吗？';

  @override
  String get importConfirm => '添加到我的卡片';

  @override
  String get importCancel => '暂不';

  @override
  String importCollisionToast(String newName) {
    return '你已经有同名卡片，所以我将它添加为“$newName”。';
  }

  @override
  String get importBadLinkToast => '抱歉，无法打开此邀请。请让朋友重新发送。';

  @override
  String get importOutdatedAppToast => '请更新应用以打开此邀请。';

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
  String get screenshotCaptionPlaying => '一个用于创建宾果棋盘的简单应用。\\n\\n无需注册、无广告、完全免费。';

  @override
  String get screenshotCaptionCreate => '只需两个屏幕即可创建宾果网格。';

  @override
  String get screenshotCaptionLocked => '就这样。';

  @override
  String get screenshotBoardName => 'David 的婚礼';

  @override
  String get screenshotTilePhoneDuringVows => '宣誓时手机响';

  @override
  String get screenshotTileChampagneSpilled => '香槟洒了';

  @override
  String get screenshotTileSpeechTears => '致辞落泪';

  @override
  String get screenshotTileDramaticEntrance => '戏剧性入场';

  @override
  String get screenshotTileKidsDanceFloor => '孩子们冲上舞池';

  @override
  String get screenshotTileGuestToast => '宾客敬酒';

  @override
  String get screenshotTileCrowdClapsEarly => '人群提前鼓掌';

  @override
  String get screenshotTileDjClassic => 'DJ 播放经典曲目';

  @override
  String get screenshotTileGroupPhotoChaos => '合影现场混乱';
}
