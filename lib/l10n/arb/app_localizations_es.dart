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
  String get newBoardPreMadeSectionTitle => 'Tus elementos preparados';

  @override
  String get newBoardPreMadeButton => 'Empezar con elementos preparados';

  @override
  String get newBoardPreMadeChangeButton => 'Cambiar elementos preparados';

  @override
  String get newBoardPreMadeClearButton => 'Borrar elementos preparados';

  @override
  String newBoardPreMadeAppliedCount(int count) {
    return '$count entradas preparadas aplicadas';
  }

  @override
  String newBoardPreMadeFullSummary(int used) {
    return 'Se elegirán $used al azar para este tablero.';
  }

  @override
  String newBoardPreMadePartialSummary(int used, int blank) {
    return 'Se rellenarán $used casillas. $blank quedarán vacías.';
  }

  @override
  String get defaultCardName => 'Tarjeta de bingo';

  @override
  String get toggleHint => 'Mantén pulsado para marcar una casilla';

  @override
  String get editingHintBefore => 'Pulsa el icono de candado';

  @override
  String get editingHintAfter =>
      ' para que las casillas dejen de ser editables.';

  @override
  String get deleteCardTitle => 'Eliminar tarjeta';

  @override
  String get deleteCardConfirm => '¿Seguro que quieres eliminar esta tarjeta?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get shuffleCardTitle => 'Mezclar tarjeta';

  @override
  String get shuffleCardConfirm =>
      '¿Seguro que quieres mezclar esta tarjeta? Todas las casillas quedarán desmarcadas después.';

  @override
  String get shuffle => 'Mezclar';

  @override
  String get ratingPromptTitle => '¿Te gusta Custom Bingo?';

  @override
  String get ratingPromptBody =>
      'Si es así, una reseña rápida en la tienda ayuda a que más personas la encuentren.';

  @override
  String get ratingPromptNo => 'No mucho';

  @override
  String get ratingPromptYes => 'Sí, me gusta';

  @override
  String get boardActionShare => 'Compartir';

  @override
  String get boardActionEditBoard => 'Editar tablero';

  @override
  String get boardActionAddPreMadeItems => 'Añadir elementos preparados';

  @override
  String get cellHint => 'Escribe texto…';

  @override
  String get edit => 'Editar';

  @override
  String get markDone => 'Marcar como hecho';

  @override
  String get markNotDone => 'Marcar como no hecho';

  @override
  String get newCardMenuItem => 'Nuevo tablero de bingo';

  @override
  String get allBoardsMenuItem => 'Todos los tableros';

  @override
  String get yourCardsHeader => 'Tus tableros';

  @override
  String get noBoardsYet => 'Aún no hay tableros';

  @override
  String get pageNotFoundTitle => 'Página no encontrada';

  @override
  String get homeButton => 'Inicio';

  @override
  String revenueCatUserIdLabel(String userId) {
    return 'ID de usuario de RevenueCat: $userId';
  }

  @override
  String get copyRevenueCatUserIdTooltip =>
      'Copiar ID de usuario de RevenueCat';

  @override
  String get revenueCatUserIdCopiedToast =>
      'ID de usuario de RevenueCat copiado.';

  @override
  String get settingsHeader => 'Ajustes';

  @override
  String get clearSettingsMenuItem => 'Borrar ajustes';

  @override
  String get appearanceMenuItem => 'Apariencia';

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
  String get preMadeTilesTitle => 'Casillas preparadas';

  @override
  String get preMadeTilesSettingsDescription =>
      'Crea textos de casilla reutilizables para futuros tableros.';

  @override
  String get preMadeTilesDescription =>
      'Crea aquí entradas de bingo reutilizables. Cuando crees un tablero nuevo, podrás añadirlas sin volver a escribirlo todo.';

  @override
  String get preMadeTilesSelectMode => 'Seleccionar';

  @override
  String get preMadeTilesEditMode => 'Editar';

  @override
  String get preMadeTileHint => 'Texto de la casilla';

  @override
  String get preMadeTilesAdd => 'Añadir casilla';

  @override
  String get preMadeTilesDelete => 'Eliminar casilla';

  @override
  String get preMadeTilesSelectAll => 'Seleccionar/deseleccionar todo';

  @override
  String get preMadeTilesSelectNone => 'No seleccionar nada';

  @override
  String get preMadeTilesApply => 'Aplicar';

  @override
  String get preMadeTilesReplaceItems => 'Reemplazar elementos';

  @override
  String get preMadeTilesFillItems => 'Rellenar elementos';

  @override
  String get preMadeTilesBoardActionHelp =>
      'Reemplazar cambia las entradas del tablero por una selección aleatoria. Rellenar solo añade elementos a casillas vacías. En tableros impares, la casilla central se mantiene.';

  @override
  String preMadeTilesSelectedCount(int selected, int total) {
    return '$selected / $total seleccionadas';
  }

  @override
  String get preMadeTilesEmptyTitle => 'Aún no hay casillas';

  @override
  String get preMadeTilesEmptyBody =>
      'Añade una casilla para empezar una lista reutilizable.';

  @override
  String get proposeFeatures => 'Proponer funciones';

  @override
  String get proposeFeaturesSettingsDescription =>
      'Vota ideas y sugiere qué crear después.';

  @override
  String get supportMeDirectly => 'Apoyar al desarrollador';

  @override
  String get supportMeDirectlySettingsDescription =>
      'Ayuda a financiar el desarrollo y a seguir mejorando la app.';

  @override
  String get supportCarouselProTitle => 'Apoya Custom Bingo';

  @override
  String get supportCarouselProSubtitle =>
      'Desbloquea colores extra y ayuda a mantener la app independiente.';

  @override
  String get supportCarouselRateTitle => '¿Disfrutas la app?';

  @override
  String get supportCarouselRateSubtitle =>
      'Una reseña rápida ayuda a que más personas encuentren Custom Bingo.';

  @override
  String get rateTheApp => 'Valorar la app';

  @override
  String get rateTheAppSettingsDescription =>
      'Abrir la solicitud de valoración de la tienda.';

  @override
  String get contactMe => 'Contactarme';

  @override
  String get contactMeSettingsDescription =>
      'Envía comentarios, preguntas o informes de errores por email.';

  @override
  String get paywallTitle => 'Apoya Custom Bingo';

  @override
  String get paywallThankYouTitle => 'Gracias';

  @override
  String get paywallSupportTitle => 'Apoya Custom Bingo';

  @override
  String get paywallSupportBody =>
      'Esta compra me apoya directamente a mí, el desarrollador. Recibes mi agradecimiento y algunos pequeños extras para tus tableros.';

  @override
  String get paywallBonusGratitude => 'Mi agradecimiento, de verdad.';

  @override
  String get paywallBonusColors => 'Algunos colores extra para tableros.';

  @override
  String get paywallBonusExtras =>
      'Pequeños extras para seguidores con el tiempo.';

  @override
  String get paywallFreeForever =>
      'Nadie necesita pagar nunca por esta app. Custom Bingo seguirá siendo usable para todos.';

  @override
  String get paywallLoadingPrice => 'Cargando precio';

  @override
  String get paywallUnavailable => 'No disponible';

  @override
  String get paywallSupportOnce => 'Apoyar una vez';

  @override
  String get paywallRestorePurchase => 'Restaurar compra';

  @override
  String get paywallProActiveToast => 'Custom Bingo Pro está activo.';

  @override
  String get paywallPurchaseInactiveToast =>
      'La compra terminó, pero Pro no está activo.';

  @override
  String get paywallProRestoredToast => 'Custom Bingo Pro restaurado.';

  @override
  String get paywallNoPurchaseFoundToast =>
      'No se encontró ninguna compra Pro.';

  @override
  String get paywallPurchasesUnavailable =>
      'Las compras no están disponibles ahora mismo.';

  @override
  String get paywallPlatformUnavailable =>
      'Las compras no están disponibles en esta plataforma.';

  @override
  String get paywallCouldNotLoad =>
      'No se pudo cargar la información de compra.';

  @override
  String get shareTitle => 'Compartir la tarjeta de bingo';

  @override
  String get shareDialogPrompt => '¿Cómo quieres compartir?';

  @override
  String get shareImageOptionTitle => 'Compartir como imagen';

  @override
  String get shareImageOptionHelper =>
      'Envía una imagen de tu tarjeta. Cualquiera puede verla, incluso sin la app.';

  @override
  String get shareImageOptionButton => 'Compartir imagen';

  @override
  String get shareInviteOptionTitle => 'Invitar amigos a jugar';

  @override
  String get shareInviteOptionHelper =>
      'Envía este enlace a tus amigos que también tengan esta app instalada. Recibirán la misma tarjeta y podréis jugar juntos.';

  @override
  String get shareInviteIncludeMarks => 'Incluir mis marcas';

  @override
  String get shareInviteIncludeMarksHelper =>
      'Cuando esté activado, tus amigos verán lo que ya has tachado.';

  @override
  String get shareInviteOptionButton => 'Enviar invitación';

  @override
  String shareInviteText(String name, String link) {
    return '¡Juega “$name” conmigo! Ábrelo en la app:\n$link';
  }

  @override
  String get close => 'Cerrar';

  @override
  String get shareSubject => 'Tarjeta de bingo';

  @override
  String get importTitle => 'Un amigo compartió una tarjeta de bingo contigo';

  @override
  String get importBody => '¿Añadirla a tus tarjetas para jugar?';

  @override
  String get importConfirm => 'Añadir a mis tarjetas';

  @override
  String get importCancel => 'Ahora no';

  @override
  String importCollisionToast(String newName) {
    return 'Ya tenías una tarjeta con este nombre, así que la añadí como \"$newName\".';
  }

  @override
  String get importBadLinkToast =>
      'Lo siento, no se pudo abrir esta invitación. Pide a tu amigo que la envíe otra vez.';

  @override
  String get importOutdatedAppToast =>
      'Actualiza la app para abrir esta invitación.';

  @override
  String get toastInfo => 'Información';

  @override
  String get toastSuccess => 'Éxito';

  @override
  String get toastError => 'Fallo';

  @override
  String get lastChangeNever => 'Último cambio: nunca';

  @override
  String lastChange(String date, String time) {
    return 'Último cambio: $date $time';
  }

  @override
  String get screenshotCaptionPlaying =>
      'Una app sencilla para crear tableros de bingo.\\n\\nSin registro, sin anuncios y totalmente gratis.';

  @override
  String get screenshotCaptionCreate =>
      'Literalmente solo dos pantallas para crear una cuadrícula de bingo.';

  @override
  String get screenshotCaptionLocked => 'Eso es todo.';

  @override
  String get screenshotBoardName => 'La boda de David';

  @override
  String get screenshotTilePhoneDuringVows => 'Teléfono durante los votos';

  @override
  String get screenshotTileChampagneSpilled => 'Champán derramado';

  @override
  String get screenshotTileSpeechTears => 'Lágrimas en el discurso';

  @override
  String get screenshotTileDramaticEntrance => 'Entrada dramática';

  @override
  String get screenshotTileKidsDanceFloor => 'Niños en la pista';

  @override
  String get screenshotTileGuestToast => 'Un invitado brinda';

  @override
  String get screenshotTileCrowdClapsEarly => 'Aplausos antes de tiempo';

  @override
  String get screenshotTileDjClassic => 'El DJ pone un clásico';

  @override
  String get screenshotTileGroupPhotoChaos => 'Caos en la foto de grupo';
}
