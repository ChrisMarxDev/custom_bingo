// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get newCardTitle => 'Neues Bingo erstellen';

  @override
  String get cardNameLabel => 'Name des Bingos *';

  @override
  String get cardNameHint => 'Gib deinem Bingo einen Namen';

  @override
  String get createCardButton => 'Bingo erstellen';

  @override
  String get defaultCardName => 'Bingo-Karte';

  @override
  String get toggleHint => 'Lange drücken, um ein Feld zu markieren';

  @override
  String get editingHintBefore => 'Drücke auf das Schloss-Symbol';

  @override
  String get editingHintAfter =>
      ', damit die Felder nicht mehr bearbeitbar sind.';

  @override
  String get deleteCardTitle => 'Karte löschen';

  @override
  String get deleteCardConfirm => 'Möchtest du diese Karte wirklich löschen?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get shuffleCardTitle => 'Karte mischen';

  @override
  String get shuffleCardConfirm =>
      'Möchtest du die Karte wirklich mischen? Alle Markierungen werden danach zurückgesetzt.';

  @override
  String get shuffle => 'Mischen';

  @override
  String get cellHint => 'Text eingeben…';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get markDone => 'Als erledigt markieren';

  @override
  String get markNotDone => 'Markierung entfernen';

  @override
  String get newCardMenuItem => 'Neues Bingo';

  @override
  String get yourCardsHeader => 'Deine Bingos';

  @override
  String get settingsHeader => 'Einstellungen';

  @override
  String get proposeFeatures => 'Funktion vorschlagen';

  @override
  String get supportKoFi => 'Auf Ko-Fi unterstützen';

  @override
  String get shareTitle => 'Bingo-Karte teilen';

  @override
  String get shareDescription =>
      'Teile die Bingo-Karte oben als Bild. Du kannst das Bild auch direkt drucken.';

  @override
  String get close => 'Schließen';

  @override
  String get share => 'Teilen';

  @override
  String get shareSubject => 'Bingo-Karte';

  @override
  String get toastInfo => 'Info';

  @override
  String get toastSuccess => 'Erfolg';

  @override
  String get toastError => 'Fehler';

  @override
  String get lastChangeNever => 'Letzte Änderung: Nie';

  @override
  String lastChange(String date, String time) {
    return 'Letzte Änderung: $date $time';
  }
}
