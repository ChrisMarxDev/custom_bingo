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
  String get shareDescription =>
      'Share the whole bingo card above as image. You can also directly print the image.';

  @override
  String get close => 'Close';

  @override
  String get share => 'Share';

  @override
  String get shareSubject => 'Bingo Card';

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
