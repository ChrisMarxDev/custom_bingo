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
  String get ratingPromptTitle => 'Vous aimez Custom Bingo ?';

  @override
  String get ratingPromptBody =>
      'Si oui, un avis rapide sur le store aide d’autres personnes à le trouver.';

  @override
  String get ratingPromptNo => 'Pas vraiment';

  @override
  String get ratingPromptYes => 'Oui, j’aime';

  @override
  String get boardActionShare => 'Partager';

  @override
  String get boardActionEditBoard => 'Modifier la grille';

  @override
  String get boardActionAddPreMadeItems => 'Ajouter des éléments préparés';

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
  String get allBoardsMenuItem => 'Toutes les grilles';

  @override
  String get yourCardsHeader => 'Vos grilles';

  @override
  String get noBoardsYet => 'Aucune grille pour l’instant';

  @override
  String get pageNotFoundTitle => 'Page introuvable';

  @override
  String get homeButton => 'Accueil';

  @override
  String revenueCatUserIdLabel(String userId) {
    return 'ID utilisateur RevenueCat : $userId';
  }

  @override
  String get copyRevenueCatUserIdTooltip =>
      'Copier l’ID utilisateur RevenueCat';

  @override
  String get revenueCatUserIdCopiedToast => 'ID utilisateur RevenueCat copié.';

  @override
  String get settingsHeader => 'Réglages';

  @override
  String get clearSettingsMenuItem => 'Effacer les réglages';

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
      'Remplacer échange les entrées de la grille contre un tirage aléatoire de votre sélection. Remplir ajoute seulement des éléments aux cases vides. Sur les grilles impaires, la case centrale reste en place.';

  @override
  String preMadeTilesSelectedCount(int selected, int total) {
    return '$selected / $total sélectionnées';
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
  String get supportCarouselProTitle => 'Soutenir Custom Bingo';

  @override
  String get supportCarouselProSubtitle =>
      'Débloquez des couleurs bonus et aidez l’app à rester indépendante.';

  @override
  String get supportCarouselRateTitle => 'Vous aimez l’app ?';

  @override
  String get supportCarouselRateSubtitle =>
      'Un avis rapide aide plus de personnes à découvrir Custom Bingo.';

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
  String get paywallTitle => 'Soutenir Custom Bingo';

  @override
  String get paywallThankYouTitle => 'Merci';

  @override
  String get paywallSupportTitle => 'Soutenir Custom Bingo';

  @override
  String get paywallSupportBody =>
      'Cet achat me soutient directement, moi le développeur. Vous recevez ma gratitude et quelques petits bonus pour vos grilles.';

  @override
  String get paywallBonusGratitude => 'Ma gratitude, sincèrement.';

  @override
  String get paywallBonusColors => 'Quelques couleurs de grille en plus.';

  @override
  String get paywallBonusExtras =>
      'De petits bonus de soutien au fil du temps.';

  @override
  String get paywallFreeForever =>
      'Personne n’a jamais besoin de payer pour cette app. Custom Bingo reste utilisable par tout le monde.';

  @override
  String get paywallLoadingPrice => 'Chargement du prix';

  @override
  String get paywallUnavailable => 'Indisponible';

  @override
  String get paywallSupportOnce => 'Soutenir une fois';

  @override
  String get paywallRestorePurchase => 'Restaurer l’achat';

  @override
  String get paywallProActiveToast => 'Custom Bingo Pro est actif.';

  @override
  String get paywallPurchaseInactiveToast =>
      'L’achat est terminé, mais Pro n’est pas actif.';

  @override
  String get paywallProRestoredToast => 'Custom Bingo Pro restauré.';

  @override
  String get paywallNoPurchaseFoundToast => 'Aucun achat Pro trouvé.';

  @override
  String get paywallPurchasesUnavailable =>
      'Les achats sont indisponibles pour le moment.';

  @override
  String get paywallPlatformUnavailable =>
      'Les achats ne sont pas disponibles sur cette plateforme.';

  @override
  String get paywallCouldNotLoad =>
      'Impossible de charger les informations d’achat.';

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
      'Envoyez ce lien à vos amis qui ont aussi installé cette app. Ils recevront la même carte et vous pourrez jouer ensemble.';

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
    return 'Vous aviez déjà une carte avec ce nom, je l’ai donc ajoutée sous « $newName ».';
  }

  @override
  String get importBadLinkToast =>
      'Désolé, cette invitation n’a pas pu être ouverte. Demandez à votre ami de la renvoyer.';

  @override
  String get importOutdatedAppToast =>
      'Mettez l’app à jour pour ouvrir cette invitation.';

  @override
  String get toastInfo => 'Information';

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
