// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get newCardTitle => 'Crear nueva cuadrícula de bingo';

  @override
  String get editCardTitle => 'Editar cuadrícula de bingo';

  @override
  String get cardNameLabel => 'Nombre de la cuadrícula *';

  @override
  String get cardNameHint => 'Ponle nombre a tu cuadrícula de bingo';

  @override
  String get createCardButton => 'Crear cuadrícula';

  @override
  String get updateCardButton => 'Actualizar cuadrícula';

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
  String get defaultCardName => 'Tarjeta de bingo';

  @override
  String get toggleHint => 'Mantén pulsado para marcar una casilla';

  @override
  String get editingHintBefore => 'Press the lock icon';

  @override
  String get editingHintAfter => ' to make the fields not editable anymore.';

  @override
  String get deleteCardTitle => 'Delete Card';

  @override
  String get deleteCardConfirm => 'Are you sure you want to delete this card?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get shuffleCardTitle => 'Shuffle Card';

  @override
  String get shuffleCardConfirm =>
      'Are you sure you want to shuffle this card? All fields will be unchecked, after shuffling.';

  @override
  String get shuffle => 'Mezclar';

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
  String get boardActionShare => 'Compartir';

  @override
  String get boardActionEditBoard => 'Editar tablero';

  @override
  String get boardActionAddPreMadeItems => 'Add pre-made items';

  @override
  String get cellHint => 'Escribe texto…';

  @override
  String get edit => 'Editar';

  @override
  String get markDone => 'Mark Done';

  @override
  String get markNotDone => 'Mark Not Done';

  @override
  String get newCardMenuItem => 'Nuevo tablero de bingo';

  @override
  String get yourCardsHeader => 'Tus tableros';

  @override
  String get settingsHeader => 'Ajustes';

  @override
  String get appearanceMenuItem => 'Appearance';

  @override
  String get settingsAppearanceSection => 'Apariencia';

  @override
  String get settingsPreferencesSection => 'Preferencias';

  @override
  String get settingsBoardsSection => 'Tableros';

  @override
  String get settingsHelpSection => 'Más';

  @override
  String get settingsSupportSection => 'Apoyo';

  @override
  String get themeColorLabel => 'Color del tema';

  @override
  String get themeColorSettingsDescription =>
      'Elige la paleta usada en toda la app.';

  @override
  String get languageSettingsTitle => 'Idioma';

  @override
  String get languageSettingsSelectorLabel => 'Idioma de la app';

  @override
  String languageSettingsSystemOption(String language) {
    return 'Predeterminado del sistema ($language)';
  }

  @override
  String languageSettingsSystemDescription(String language) {
    return 'Sigue el idioma del teléfono: $language.';
  }

  @override
  String get languageSettingsOverrideDescription =>
      'Usar este idioma en lugar del idioma del teléfono.';

  @override
  String get darkModeLabel => 'Modo oscuro';

  @override
  String get darkModeSettingsDescription => 'Usar una interfaz más oscura.';

  @override
  String get enableConfettiLabel => 'Confeti';

  @override
  String get enableConfettiSettingsDescription =>
      'Mostrar una celebración al completar un bingo.';

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
  String get shareTitle => 'Compartir la tarjeta de bingo';

  @override
  String get shareDialogPrompt => 'How would you like to share?';

  @override
  String get shareImageOptionTitle => 'Compartir como imagen';

  @override
  String get shareImageOptionHelper =>
      'Send a picture of your card. Anyone can see it — even without the app.';

  @override
  String get shareImageOptionButton => 'Compartir imagen';

  @override
  String get shareInviteOptionTitle => 'Invitar amigos a jugar';

  @override
  String get shareInviteOptionHelper =>
      'Send this link to your friends who also have this app installed. They get the same card and you can play together.';

  @override
  String get shareInviteIncludeMarks => 'Include my checkmarks';

  @override
  String get shareInviteIncludeMarksHelper =>
      'When on, your friends will see what you\'ve already crossed off.';

  @override
  String get shareInviteOptionButton => 'Enviar invitación';

  @override
  String shareInviteText(String name, String link) {
    return '¡Juega “$name” conmigo! Ábrelo en la app:\n$link';
  }

  @override
  String get close => 'Cerrar';

  @override
  String get shareSubject => 'Bingo Card';

  @override
  String get importTitle => 'A friend shared a bingo card with you';

  @override
  String get importBody => 'Add it to your cards so you can play along?';

  @override
  String get importConfirm => 'Añadir a mis tarjetas';

  @override
  String get importCancel => 'Ahora no';

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
  String get toastInfo => 'Información';

  @override
  String get toastSuccess => 'Éxito';

  @override
  String get toastError => 'Error';

  @override
  String get lastChangeNever => 'Último cambio: nunca';

  @override
  String lastChange(String date, String time) {
    return 'Último cambio: $date $time';
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
