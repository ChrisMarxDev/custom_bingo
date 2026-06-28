// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get newCardTitle => 'Créer une nouvelle grille de bingo';

  @override
  String get editCardTitle => 'Modifier la grille de bingo';

  @override
  String get cardNameLabel => 'Nom de la grille *';

  @override
  String get cardNameHint => 'Donnez un nom à votre grille de bingo';

  @override
  String get createCardButton => 'Créer la grille';

  @override
  String get updateCardButton => 'Mettre à jour la grille';

  @override
  String get newBoardPreMadeSectionTitle => 'Vos éléments préparés';

  @override
  String get newBoardPreMadeButton => 'Commencer avec des éléments préparés';

  @override
  String get newBoardPreMadeChangeButton => 'Modifier les éléments préparés';

  @override
  String get newBoardPreMadeClearButton => 'Effacer les éléments préparés';

  @override
  String newBoardPreMadeAppliedCount(int count) {
    return '$count entrées préparées appliquées';
  }

  @override
  String newBoardPreMadeFullSummary(int used) {
    return '$used seront tirées au hasard pour cette grille.';
  }

  @override
  String newBoardPreMadePartialSummary(int used, int blank) {
    return '$used cases seront remplies. $blank resteront vides.';
  }

  @override
  String get defaultCardName => 'Carte de bingo';

  @override
  String get toggleHint => 'Appuyez longuement pour cocher une case';

  @override
  String get editingHintBefore => 'Appuyez sur l’icône de cadenas';

  @override
  String get editingHintAfter => ' pour empêcher la modification des cases.';

  @override
  String get deleteCardTitle => 'Supprimer la carte';

  @override
  String get deleteCardConfirm =>
      'Voulez-vous vraiment supprimer cette carte ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get shuffleCardTitle => 'Mélanger la carte';

  @override
  String get shuffleCardConfirm =>
      'Voulez-vous vraiment mélanger cette carte ? Toutes les cases seront décochées après le mélange.';

  @override
  String get shuffle => 'Mélanger';

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
  String get boardActionShare => 'Partager';

  @override
  String get boardActionEditBoard => 'Modifier la grille';

  @override
  String get boardActionAddPreMadeItems => 'Add pre-made items';

  @override
  String get cellHint => 'Saisir du texte…';

  @override
  String get edit => 'Modifier';

  @override
  String get markDone => 'Marquer comme fait';

  @override
  String get markNotDone => 'Retirer la marque';

  @override
  String get newCardMenuItem => 'Nouvelle grille de bingo';

  @override
  String get yourCardsHeader => 'Vos grilles';

  @override
  String get settingsHeader => 'Réglages';

  @override
  String get appearanceMenuItem => 'Apparence';

  @override
  String get settingsAppearanceSection => 'Apparence';

  @override
  String get settingsPreferencesSection => 'Préférences';

  @override
  String get settingsBoardsSection => 'Grilles';

  @override
  String get settingsHelpSection => 'Plus';

  @override
  String get settingsSupportSection => 'Soutien';

  @override
  String get themeColorLabel => 'Couleur du thème';

  @override
  String get themeColorSettingsDescription =>
      'Choisissez la palette utilisée dans toute l’app.';

  @override
  String get languageSettingsTitle => 'Langue';

  @override
  String get languageSettingsSelectorLabel => 'Langue de l’app';

  @override
  String languageSettingsSystemOption(String language) {
    return 'Par défaut du système ($language)';
  }

  @override
  String languageSettingsSystemDescription(String language) {
    return 'Suit la langue de votre téléphone : $language.';
  }

  @override
  String get languageSettingsOverrideDescription =>
      'Utiliser cette langue au lieu de celle du téléphone.';

  @override
  String get darkModeLabel => 'Mode sombre';

  @override
  String get darkModeSettingsDescription =>
      'Utiliser une interface plus sombre.';

  @override
  String get enableConfettiLabel => 'Confettis';

  @override
  String get enableConfettiSettingsDescription =>
      'Afficher une célébration quand vous terminez un bingo.';

  @override
  String get preMadeTilesTitle => 'Cases préparées';

  @override
  String get preMadeTilesSettingsDescription =>
      'Créer des textes de case réutilisables pour de futures grilles.';

  @override
  String get preMadeTilesDescription =>
      'Créez ici des entrées de bingo réutilisables. Lors de la création d’une nouvelle grille, vous pourrez les ajouter sans tout retaper.';

  @override
  String get preMadeTilesSelectMode => 'Sélectionner';

  @override
  String get preMadeTilesEditMode => 'Modifier';

  @override
  String get preMadeTileHint => 'Texte de la case';

  @override
  String get preMadeTilesAdd => 'Ajouter une case';

  @override
  String get preMadeTilesDelete => 'Supprimer la case';

  @override
  String get preMadeTilesSelectAll => 'Tout sélectionner/désélectionner';

  @override
  String get preMadeTilesSelectNone => 'Ne rien sélectionner';

  @override
  String get preMadeTilesApply => 'Appliquer';

  @override
  String get preMadeTilesReplaceItems => 'Remplacer les éléments';

  @override
  String get preMadeTilesFillItems => 'Remplir les éléments';

  @override
  String get preMadeTilesBoardActionHelp =>
      'Replace swaps the board entries with a random draw from your selection. Fill only adds items to empty tiles. On odd boards, the center tile stays in place.';

  @override
  String preMadeTilesSelectedCount(int selected, int total) {
    return '$selected / $total selected';
  }

  @override
  String get preMadeTilesEmptyTitle => 'Aucune case pour l’instant';

  @override
  String get preMadeTilesEmptyBody =>
      'Ajoutez une case pour commencer une liste réutilisable.';

  @override
  String get proposeFeatures => 'Proposer des fonctionnalités';

  @override
  String get proposeFeaturesSettingsDescription =>
      'Votez pour des idées et suggérez la suite.';

  @override
  String get supportMeDirectly => 'Soutenir le développeur';

  @override
  String get supportMeDirectlySettingsDescription =>
      'Aidez à financer le développement et à améliorer l’app.';

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
  String get rateTheApp => 'Noter l’app';

  @override
  String get rateTheAppSettingsDescription =>
      'Ouvrir la demande de note du store.';

  @override
  String get contactMe => 'Me contacter';

  @override
  String get contactMeSettingsDescription =>
      'Envoyer des retours, questions ou bugs par e-mail.';

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
  String get shareTitle => 'Partager la carte de bingo';

  @override
  String get shareDialogPrompt => 'Comment voulez-vous partager ?';

  @override
  String get shareImageOptionTitle => 'Partager en image';

  @override
  String get shareImageOptionHelper =>
      'Envoyez une image de votre carte. Tout le monde peut la voir, même sans l’app.';

  @override
  String get shareImageOptionButton => 'Partager l’image';

  @override
  String get shareInviteOptionTitle => 'Inviter des amis à jouer';

  @override
  String get shareInviteOptionHelper =>
      'Send this link to your friends who also have this app installed. They get the same card and you can play together.';

  @override
  String get shareInviteIncludeMarks => 'Inclure mes coches';

  @override
  String get shareInviteIncludeMarksHelper =>
      'Activé, vos amis verront ce que vous avez déjà coché.';

  @override
  String get shareInviteOptionButton => 'Envoyer l’invitation';

  @override
  String shareInviteText(String name, String link) {
    return 'Joue à « $name » avec moi ! Ouvre-le dans l’app :\n$link';
  }

  @override
  String get close => 'Fermer';

  @override
  String get shareSubject => 'Carte de bingo';

  @override
  String get importTitle => 'Un ami vous a partagé une carte de bingo';

  @override
  String get importBody => 'L’ajouter à vos cartes pour jouer avec lui ?';

  @override
  String get importConfirm => 'Ajouter à mes cartes';

  @override
  String get importCancel => 'Pas maintenant';

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
  String get toastSuccess => 'Succès';

  @override
  String get toastError => 'Erreur';

  @override
  String get lastChangeNever => 'Dernière modification : jamais';

  @override
  String lastChange(String date, String time) {
    return 'Dernière modification : $date $time';
  }

  @override
  String get screenshotCaptionPlaying =>
      'Une app toute simple pour créer une grille de bingo.\n\nSans inscription, sans pub, entièrement gratuite.';

  @override
  String get screenshotCaptionCreate =>
      'Seulement deux écrans pour créer une grille de bingo.';

  @override
  String get screenshotCaptionLocked => 'C’est tout.';

  @override
  String get screenshotBoardName => 'Mariage de David';

  @override
  String get screenshotTilePhoneDuringVows => 'Téléphone pendant les vœux';

  @override
  String get screenshotTileChampagneSpilled => 'Champagne renversé';

  @override
  String get screenshotTileSpeechTears => 'Larmes pendant le discours';

  @override
  String get screenshotTileDramaticEntrance => 'Entrée théâtrale';

  @override
  String get screenshotTileKidsDanceFloor => 'Les enfants envahissent la piste';

  @override
  String get screenshotTileGuestToast => 'Un invité porte un toast';

  @override
  String get screenshotTileCrowdClapsEarly => 'Applaudissements trop tôt';

  @override
  String get screenshotTileDjClassic => 'Le DJ met un classique';

  @override
  String get screenshotTileGroupPhotoChaos => 'Chaos pour la photo de groupe';
}
