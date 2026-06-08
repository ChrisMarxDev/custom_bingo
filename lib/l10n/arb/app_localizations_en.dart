// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get newCardTitle => 'Create New Bingo Grid';

  @override
  String get cardNameLabel => 'Bingo Grid Name *';

  @override
  String get cardNameHint => 'Enter a name for your bingo grid';

  @override
  String get createCardButton => 'Create Bingo Grid';

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
  String get defaultCardName => 'Bingo Card';

  @override
  String get toggleHint => 'Press long to mark a field as checked';

  @override
  String get editingHintBefore => 'Press the lock icon';

  @override
  String get editingHintAfter => ' to make the fields not editable anymore.';

  @override
  String get deleteCardTitle => 'Delete Card';

  @override
  String get deleteCardConfirm => 'Are you sure you want to delete this card?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get shuffleCardTitle => 'Shuffle Card';

  @override
  String get shuffleCardConfirm =>
      'Are you sure you want to shuffle this card? All fields will be unchecked, after shuffling.';

  @override
  String get shuffle => 'Shuffle';

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
  String get boardActionShare => 'Share';

  @override
  String get boardActionAddPreMadeItems => 'Add pre-made items';

  @override
  String get cellHint => 'Enter text…';

  @override
  String get edit => 'Edit';

  @override
  String get markDone => 'Mark Done';

  @override
  String get markNotDone => 'Mark Not Done';

  @override
  String get newCardMenuItem => 'New bingo board';

  @override
  String get yourCardsHeader => 'Your Boards';

  @override
  String get settingsHeader => 'Settings';

  @override
  String get appearanceMenuItem => 'Appearance';

  @override
  String get themeColorLabel => 'Theme color';

  @override
  String get darkModeLabel => 'Dark mode';

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
  String get userEmailPromptTitle => 'Want us to follow up?';

  @override
  String get userEmailPromptBody =>
      'Add your email address if you\'d like us to reply about your feedback.';

  @override
  String get userEmailPromptFieldLabel => 'Email address';

  @override
  String get userEmailPromptFieldHint => 'you@example.com';

  @override
  String get userEmailPromptDontAskAgain => 'Don\'t ask me again';

  @override
  String get userEmailPromptSkip => 'Skip';

  @override
  String get userEmailPromptContinue => 'Continue';

  @override
  String get userEmailPromptInvalidEmail => 'Enter a valid email address.';

  @override
  String get supportMeDirectly => 'Support me directly';

  @override
  String get shareTitle => 'Share the bingo card';

  @override
  String get shareDialogPrompt => 'How would you like to share?';

  @override
  String get shareImageOptionTitle => 'Share as image';

  @override
  String get shareImageOptionHelper =>
      'Send a picture of your card. Anyone can see it — even without the app.';

  @override
  String get shareImageOptionButton => 'Share image';

  @override
  String get shareInviteOptionTitle => 'Invite friends to play';

  @override
  String get shareInviteOptionHelper =>
      'Send this link to your friends who also have this app installed. They get the same card and you can play together.';

  @override
  String get shareInviteIncludeMarks => 'Include my checkmarks';

  @override
  String get shareInviteIncludeMarksHelper =>
      'When on, your friends will see what you\'ve already crossed off.';

  @override
  String get shareInviteOptionButton => 'Send invite';

  @override
  String shareInviteText(String name, String link) {
    return 'Play \"$name\" with me! Open it in the app:\n$link';
  }

  @override
  String get close => 'Close';

  @override
  String get shareSubject => 'Bingo Card';

  @override
  String get importTitle => 'A friend shared a bingo card with you';

  @override
  String get importBody => 'Add it to your cards so you can play along?';

  @override
  String get importConfirm => 'Add to my cards';

  @override
  String get importCancel => 'Not now';

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
  String get toastInfo => 'Info';

  @override
  String get toastSuccess => 'Success';

  @override
  String get toastError => 'Error';

  @override
  String get lastChangeNever => 'Last change: Never';

  @override
  String lastChange(String date, String time) {
    return 'Last change: $date $time';
  }
}
