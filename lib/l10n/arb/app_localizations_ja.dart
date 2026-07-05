// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get newCardTitle => '新しいビンゴ表を作成';

  @override
  String get editCardTitle => 'ビンゴ表を編集';

  @override
  String get cardNameLabel => 'ビンゴ表の名前 *';

  @override
  String get cardNameHint => 'ビンゴ表の名前を入力';

  @override
  String get createCardButton => 'ビンゴ表を作成';

  @override
  String get updateCardButton => 'ビンゴ表を更新';

  @override
  String get newBoardPreMadeSectionTitle => '作成済み項目';

  @override
  String get newBoardPreMadeButton => '作成済み項目から始める';

  @override
  String get newBoardPreMadeChangeButton => '作成済み項目を変更';

  @override
  String get newBoardPreMadeClearButton => '作成済み項目をクリア';

  @override
  String newBoardPreMadeAppliedCount(int count) {
    return '$count 件の作成済み項目を適用しました';
  }

  @override
  String newBoardPreMadeFullSummary(int used) {
    return 'このボードには $used 件がランダムに選ばれます。';
  }

  @override
  String newBoardPreMadePartialSummary(int used, int blank) {
    return '$used マスが埋まります。$blank マスは空のままです。';
  }

  @override
  String get defaultCardName => 'ビンゴカード';

  @override
  String get toggleHint => '長押しでマスをチェック';

  @override
  String get editingHintBefore => 'ロックアイコンを押すと';

  @override
  String get editingHintAfter => '、マスを編集できないようにできます。';

  @override
  String get deleteCardTitle => 'カードを削除';

  @override
  String get deleteCardConfirm => 'このカードを削除してもよろしいですか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get shuffleCardTitle => 'カードをシャッフル';

  @override
  String get shuffleCardConfirm =>
      'このカードをシャッフルしてもよろしいですか？シャッフル後、すべてのマスのチェックが外れます。';

  @override
  String get shuffle => 'シャッフル';

  @override
  String get ratingPromptTitle => 'Custom Bingo は気に入りましたか？';

  @override
  String get ratingPromptBody => 'よろしければ、ストアでの短いレビューが他の人の発見につながります。';

  @override
  String get ratingPromptNo => 'あまり';

  @override
  String get ratingPromptYes => 'はい、気に入りました';

  @override
  String get boardActionShare => '共有';

  @override
  String get boardActionEditBoard => 'ボードを編集';

  @override
  String get boardActionAddPreMadeItems => '作成済み項目を追加';

  @override
  String get cellHint => 'テキストを入力…';

  @override
  String get edit => '編集';

  @override
  String get markDone => '完了にする';

  @override
  String get markNotDone => '未完了にする';

  @override
  String get newCardMenuItem => '新しいビンゴボード';

  @override
  String get allBoardsMenuItem => 'すべてのボード';

  @override
  String get yourCardsHeader => 'あなたのボード';

  @override
  String get noBoardsYet => 'ボードはまだありません';

  @override
  String get pageNotFoundTitle => 'ページが見つかりません';

  @override
  String get homeButton => 'ホーム';

  @override
  String revenueCatUserIdLabel(String userId) {
    return 'RevenueCat ユーザーID: $userId';
  }

  @override
  String get copyRevenueCatUserIdTooltip => 'RevenueCat ユーザーIDをコピー';

  @override
  String get revenueCatUserIdCopiedToast => 'RevenueCat ユーザーIDをコピーしました。';

  @override
  String get settingsHeader => '設定';

  @override
  String get clearSettingsMenuItem => '設定をクリア';

  @override
  String get appearanceMenuItem => '外観';

  @override
  String get settingsAppearanceSection => '外観';

  @override
  String get settingsPreferencesSection => '環境設定';

  @override
  String get settingsBoardsSection => 'ボード';

  @override
  String get settingsHelpSection => 'その他';

  @override
  String get settingsSupportSection => 'サポート';

  @override
  String get themeColorLabel => 'テーマカラー';

  @override
  String get themeColorSettingsDescription => 'アプリ全体で使う配色を選びます。';

  @override
  String get languageSettingsTitle => '言語';

  @override
  String get languageSettingsSelectorLabel => 'アプリの言語';

  @override
  String languageSettingsSystemOption(String language) {
    return 'システム標準（$language）';
  }

  @override
  String languageSettingsSystemDescription(String language) {
    return '端末の言語に合わせます：$language。';
  }

  @override
  String get languageSettingsOverrideDescription => '端末の言語ではなく、この言語を使います。';

  @override
  String get darkModeLabel => 'ダークモード';

  @override
  String get darkModeSettingsDescription => '暗めの画面表示を使います。';

  @override
  String get enableConfettiLabel => '紙吹雪';

  @override
  String get enableConfettiSettingsDescription => 'ビンゴ達成時にお祝いを表示します。';

  @override
  String get preMadeTilesTitle => '作成済みタイル';

  @override
  String get preMadeTilesSettingsDescription => '今後のボードで使えるタイル文を作成します。';

  @override
  String get preMadeTilesDescription =>
      '再利用できるビンゴ項目をここで作成します。新しいボードを作るとき、入力し直さずに追加できます。';

  @override
  String get preMadeTilesSelectMode => '選択';

  @override
  String get preMadeTilesEditMode => '編集';

  @override
  String get preMadeTileHint => 'タイルのテキスト';

  @override
  String get preMadeTilesAdd => 'タイルを追加';

  @override
  String get preMadeTilesDelete => 'タイルを削除';

  @override
  String get preMadeTilesSelectAll => 'すべて選択/解除';

  @override
  String get preMadeTilesSelectNone => '選択を解除';

  @override
  String get preMadeTilesApply => '適用';

  @override
  String get preMadeTilesReplaceItems => '項目を置き換え';

  @override
  String get preMadeTilesFillItems => '項目を埋める';

  @override
  String get preMadeTilesBoardActionHelp =>
      '置き換えは、選択内容からランダムに引いた項目でボードを入れ替えます。埋めるは空のタイルにだけ項目を追加します。奇数サイズのボードでは中央タイルはそのままです。';

  @override
  String preMadeTilesSelectedCount(int selected, int total) {
    return '$selected / $total 選択済み';
  }

  @override
  String get preMadeTilesEmptyTitle => 'タイルはまだありません';

  @override
  String get preMadeTilesEmptyBody => 'タイルを追加して、再利用できるリストを作り始めましょう。';

  @override
  String get proposeFeatures => '機能を提案';

  @override
  String get proposeFeaturesSettingsDescription => 'アイデアに投票して、次に作るものを提案します。';

  @override
  String get supportMeDirectly => '開発者を支援';

  @override
  String get supportMeDirectlySettingsDescription =>
      '開発資金を支援し、アプリの改善を続けられるようにします。';

  @override
  String get supportCarouselProTitle => 'Custom Bingo を支援';

  @override
  String get supportCarouselProSubtitle => '追加カラーを解除し、アプリの独立運営を支援します。';

  @override
  String get supportCarouselRateTitle => 'アプリを楽しんでいますか？';

  @override
  String get supportCarouselRateSubtitle =>
      '短いレビューが、より多くの人に Custom Bingo を見つけてもらう助けになります。';

  @override
  String get rateTheApp => 'アプリを評価';

  @override
  String get rateTheAppSettingsDescription => 'ストア評価の案内を開きます。';

  @override
  String get contactMe => '問い合わせる';

  @override
  String get contactMeSettingsDescription => '感想、質問、不具合報告をメールで送ります。';

  @override
  String get paywallTitle => 'Custom Bingo を支援';

  @override
  String get paywallThankYouTitle => 'ありがとうございます';

  @override
  String get paywallSupportTitle => 'Custom Bingo を支援';

  @override
  String get paywallSupportBody =>
      'この購入は開発者である私を直接支援します。感謝の気持ちと、ボード用の小さな追加要素を受け取れます。';

  @override
  String get paywallBonusGratitude => '心からの感謝。';

  @override
  String get paywallBonusColors => 'ボード用の追加カラー。';

  @override
  String get paywallBonusExtras => '支援者向けの小さな追加要素。';

  @override
  String get paywallFreeForever =>
      'このアプリに支払いは必須ではありません。Custom Bingo は誰でも使い続けられます。';

  @override
  String get paywallLoadingPrice => '価格を読み込み中';

  @override
  String get paywallUnavailable => '利用できません';

  @override
  String get paywallSupportOnce => '一度支援する';

  @override
  String get paywallRestorePurchase => '購入を復元';

  @override
  String get paywallProActiveToast => 'Custom Bingo Pro が有効です。';

  @override
  String get paywallPurchaseInactiveToast => '購入は完了しましたが、Pro は有効ではありません。';

  @override
  String get paywallProRestoredToast => 'Custom Bingo Pro を復元しました。';

  @override
  String get paywallNoPurchaseFoundToast => 'Pro の購入は見つかりませんでした。';

  @override
  String get paywallPurchasesUnavailable => '現在、購入は利用できません。';

  @override
  String get paywallPlatformUnavailable => 'このプラットフォームでは購入を利用できません。';

  @override
  String get paywallCouldNotLoad => '購入情報を読み込めませんでした。';

  @override
  String get shareTitle => 'ビンゴカードを共有';

  @override
  String get shareDialogPrompt => 'どのように共有しますか？';

  @override
  String get shareImageOptionTitle => '画像として共有';

  @override
  String get shareImageOptionHelper => 'カードの画像を送ります。アプリがなくても誰でも見られます。';

  @override
  String get shareImageOptionButton => '画像を共有';

  @override
  String get shareInviteOptionTitle => '友だちを招待して遊ぶ';

  @override
  String get shareInviteOptionHelper =>
      'このアプリをインストールしている友達にリンクを送ります。同じカードを受け取って一緒に遊べます。';

  @override
  String get shareInviteIncludeMarks => '自分のチェックを含める';

  @override
  String get shareInviteIncludeMarksHelper =>
      'オンにすると、友達はあなたがすでにチェックした項目を見られます。';

  @override
  String get shareInviteOptionButton => '招待を送信';

  @override
  String shareInviteText(String name, String link) {
    return '「$name」を一緒に遊ぼう！アプリで開いてください：\n$link';
  }

  @override
  String get close => '閉じる';

  @override
  String get shareSubject => 'ビンゴカード';

  @override
  String get importTitle => '友達がビンゴカードを共有しました';

  @override
  String get importBody => '一緒に遊ぶためにカードに追加しますか？';

  @override
  String get importConfirm => '自分のカードに追加';

  @override
  String get importCancel => '今はしない';

  @override
  String importCollisionToast(String newName) {
    return '同じ名前のカードが既にあったため、「$newName」として追加しました。';
  }

  @override
  String get importBadLinkToast => 'この招待を開けませんでした。友達にもう一度送ってもらってください。';

  @override
  String get importOutdatedAppToast => 'この招待を開くにはアプリを更新してください。';

  @override
  String get toastInfo => '情報';

  @override
  String get toastSuccess => '成功';

  @override
  String get toastError => 'エラー';

  @override
  String get lastChangeNever => '最終変更：なし';

  @override
  String lastChange(String date, String time) {
    return '最終変更：$date $time';
  }

  @override
  String get screenshotCaptionPlaying =>
      'ビンゴボードを作るためのシンプルなアプリ。\\n\\n登録なし、広告なし、完全無料。';

  @override
  String get screenshotCaptionCreate => 'ビンゴグリッド作成はたった2画面。';

  @override
  String get screenshotCaptionLocked => 'これだけです。';

  @override
  String get screenshotBoardName => 'デイビッドの結婚式';

  @override
  String get screenshotTilePhoneDuringVows => '誓いの最中に電話';

  @override
  String get screenshotTileChampagneSpilled => 'シャンパンがこぼれる';

  @override
  String get screenshotTileSpeechTears => 'スピーチで涙';

  @override
  String get screenshotTileDramaticEntrance => 'ドラマチックな入場';

  @override
  String get screenshotTileKidsDanceFloor => '子どもがダンスフロアへ';

  @override
  String get screenshotTileGuestToast => 'ゲストが乾杯';

  @override
  String get screenshotTileCrowdClapsEarly => '拍手が早すぎる';

  @override
  String get screenshotTileDjClassic => 'DJが定番曲を流す';

  @override
  String get screenshotTileGroupPhotoChaos => '集合写真が大混乱';
}
