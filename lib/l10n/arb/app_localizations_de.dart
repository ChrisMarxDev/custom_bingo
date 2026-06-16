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
  String get editCardTitle => 'Bingo bearbeiten';

  @override
  String get cardNameLabel => 'Name des Bingos *';

  @override
  String get cardNameHint => 'Gib deinem Bingo einen Namen';

  @override
  String get createCardButton => 'Bingo erstellen';

  @override
  String get updateCardButton => 'Bingo aktualisieren';

  @override
  String get newBoardPreMadeSectionTitle => 'Deine vorbereiteten Einträge';

  @override
  String get newBoardPreMadeButton => 'Mit vorbereiteten Einträgen starten';

  @override
  String get newBoardPreMadeChangeButton => 'Vorbereitete Einträge ändern';

  @override
  String get newBoardPreMadeClearButton => 'Vorbereitete Einträge entfernen';

  @override
  String newBoardPreMadeAppliedCount(int count) {
    return '$count vorbereitete Einträge angewendet';
  }

  @override
  String newBoardPreMadeFullSummary(int used) {
    return '$used werden zufällig für dieses Board gezogen.';
  }

  @override
  String newBoardPreMadePartialSummary(int used, int blank) {
    return '$used Felder werden gefüllt. $blank bleiben leer.';
  }

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
  String get ratingPromptTitle => 'Gefällt dir Custom Bingo?';

  @override
  String get ratingPromptBody =>
      'Wenn ja, hilft eine kurze Bewertung im Store anderen, die App zu finden.';

  @override
  String get ratingPromptNo => 'Nicht wirklich';

  @override
  String get ratingPromptYes => 'Ja, gefällt mir';

  @override
  String get boardActionShare => 'Teilen';

  @override
  String get boardActionEditBoard => 'Board bearbeiten';

  @override
  String get boardActionAddPreMadeItems => 'Vorbereitete Einträge hinzufügen';

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
  String get appearanceMenuItem => 'Design';

  @override
  String get settingsAppearanceSection => 'Design';

  @override
  String get settingsPreferencesSection => 'Einstellungen';

  @override
  String get settingsBoardsSection => 'Boards';

  @override
  String get settingsHelpSection => 'Mehr';

  @override
  String get settingsSupportSection => 'Unterstützen';

  @override
  String get themeColorLabel => 'Themenfarbe';

  @override
  String get themeColorSettingsDescription =>
      'Wähle die Farbpalette für die App.';

  @override
  String get darkModeLabel => 'Dunkler Modus';

  @override
  String get darkModeSettingsDescription =>
      'Verwende eine dunklere Oberfläche.';

  @override
  String get enableConfettiLabel => 'Konfetti';

  @override
  String get enableConfettiSettingsDescription =>
      'Zeige eine Feier, wenn du ein Bingo abschließt.';

  @override
  String get preMadeTilesTitle => 'Vorbereitete Felder';

  @override
  String get preMadeTilesSettingsDescription =>
      'Lege wiederverwendbare Feldtexte für spätere Bingos an.';

  @override
  String get preMadeTilesDescription =>
      'Erstelle wiederverwendbare Bingo-Einträge. Wenn du ein neues Board erstellst, kannst du sie später hinzufügen, ohne alles erneut zu tippen.';

  @override
  String get preMadeTilesSelectMode => 'Auswählen';

  @override
  String get preMadeTilesEditMode => 'Bearbeiten';

  @override
  String get preMadeTileHint => 'Feldtext';

  @override
  String get preMadeTilesAdd => 'Feld hinzufügen';

  @override
  String get preMadeTilesDelete => 'Feld löschen';

  @override
  String get preMadeTilesSelectAll => 'Alle aus-/abwählen';

  @override
  String get preMadeTilesSelectNone => 'Keine auswählen';

  @override
  String get preMadeTilesApply => 'Anwenden';

  @override
  String get preMadeTilesReplaceItems => 'Einträge ersetzen';

  @override
  String get preMadeTilesFillItems => 'Einträge füllen';

  @override
  String get preMadeTilesBoardActionHelp =>
      'Ersetzen tauscht die Board-Einträge zufällig mit deiner Auswahl aus. Füllen ergänzt nur leere Felder. Bei ungeraden Boards bleibt das mittlere Feld an Ort und Stelle.';

  @override
  String preMadeTilesSelectedCount(int selected, int total) {
    return '$selected / $total ausgewählt';
  }

  @override
  String get preMadeTilesEmptyTitle => 'Noch keine Felder';

  @override
  String get preMadeTilesEmptyBody =>
      'Füge ein Feld hinzu, um eine wiederverwendbare Liste aufzubauen.';

  @override
  String get proposeFeatures => 'Funktion vorschlagen';

  @override
  String get proposeFeaturesSettingsDescription =>
      'Stimme über Ideen ab und schlage vor, was als Nächstes gebaut werden soll.';

  @override
  String get supportMeDirectly => 'Entwickler unterstützen';

  @override
  String get supportMeDirectlySettingsDescription =>
      'Hilf, die Entwicklung zu finanzieren und die App weiter zu verbessern.';

  @override
  String get rateTheApp => 'App bewerten';

  @override
  String get rateTheAppSettingsDescription => 'Öffne die Bewertung im Store.';

  @override
  String get contactMe => 'Kontakt';

  @override
  String get contactMeSettingsDescription =>
      'Sende Feedback, Fragen oder Fehlerberichte per E-Mail.';

  @override
  String get shareTitle => 'Bingo-Karte teilen';

  @override
  String get shareDialogPrompt => 'Wie möchtest du teilen?';

  @override
  String get shareImageOptionTitle => 'Als Bild teilen';

  @override
  String get shareImageOptionHelper =>
      'Schicke ein Bild deiner Karte. Jeder kann es sehen, auch ohne die App.';

  @override
  String get shareImageOptionButton => 'Bild teilen';

  @override
  String get shareInviteOptionTitle => 'Freunde zum Mitspielen einladen';

  @override
  String get shareInviteOptionHelper =>
      'Schicke diesen Link an deine Freunde, die diese App auch installiert haben. Sie bekommen die gleiche Karte und ihr könnt zusammen spielen.';

  @override
  String get shareInviteIncludeMarks => 'Meine Markierungen mitsenden';

  @override
  String get shareInviteIncludeMarksHelper =>
      'Wenn aktiv, sehen deine Freunde, was du schon abgehakt hast.';

  @override
  String get shareInviteOptionButton => 'Einladung senden';

  @override
  String shareInviteText(String name, String link) {
    return 'Spiel „$name\" mit mir! In der App öffnen:\n$link';
  }

  @override
  String get close => 'Schließen';

  @override
  String get shareSubject => 'Bingo-Karte';

  @override
  String get importTitle => 'Ein Freund hat dir eine Bingo-Karte geschickt';

  @override
  String get importBody =>
      'Zu deinen Karten hinzufügen, damit ihr zusammen spielen könnt?';

  @override
  String get importConfirm => 'Zu meinen Karten hinzufügen';

  @override
  String get importCancel => 'Nicht jetzt';

  @override
  String importCollisionToast(String newName) {
    return 'Du hattest schon eine Karte mit diesem Namen — ich habe sie als „$newName\" hinzugefügt.';
  }

  @override
  String get importBadLinkToast =>
      'Diese Einladung konnte nicht geöffnet werden. Bitte deinen Freund, sie noch einmal zu schicken.';

  @override
  String get importOutdatedAppToast =>
      'Aktualisiere die App, um diese Einladung zu öffnen.';

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
