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
  String get proposeFeatures => 'Propose Features';

  @override
  String get supportKoFi => 'Support me on Ko-Fi';

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
