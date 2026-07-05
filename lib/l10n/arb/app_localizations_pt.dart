// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get newCardTitle => 'Criar nova cartela de bingo';

  @override
  String get editCardTitle => 'Editar cartela de bingo';

  @override
  String get cardNameLabel => 'Nome da cartela *';

  @override
  String get cardNameHint => 'Dê um nome à sua cartela de bingo';

  @override
  String get createCardButton => 'Criar cartela';

  @override
  String get updateCardButton => 'Atualizar cartela';

  @override
  String get newBoardPreMadeSectionTitle => 'Seus itens prontos';

  @override
  String get newBoardPreMadeButton => 'Começar com itens prontos';

  @override
  String get newBoardPreMadeChangeButton => 'Alterar itens prontos';

  @override
  String get newBoardPreMadeClearButton => 'Limpar itens prontos';

  @override
  String newBoardPreMadeAppliedCount(int count) {
    return '$count entradas prontas aplicadas';
  }

  @override
  String newBoardPreMadeFullSummary(int used) {
    return '$used serão sorteadas aleatoriamente para este tabuleiro.';
  }

  @override
  String newBoardPreMadePartialSummary(int used, int blank) {
    return '$used células serão preenchidas. $blank ficarão em branco.';
  }

  @override
  String get defaultCardName => 'Cartela de bingo';

  @override
  String get toggleHint => 'Prima sem soltar para marcar uma casa';

  @override
  String get editingHintBefore => 'Toque no ícone de cadeado';

  @override
  String get editingHintAfter => ' para impedir a edição dos campos.';

  @override
  String get deleteCardTitle => 'Excluir cartela';

  @override
  String get deleteCardConfirm =>
      'Tem certeza de que deseja excluir esta cartela?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get shuffleCardTitle => 'Embaralhar cartela';

  @override
  String get shuffleCardConfirm =>
      'Tem certeza de que deseja embaralhar esta cartela? Todos os campos serão desmarcados depois.';

  @override
  String get shuffle => 'Baralhar';

  @override
  String get ratingPromptTitle => 'Você gosta do Custom Bingo?';

  @override
  String get ratingPromptBody =>
      'Se sim, uma avaliação rápida na loja ajuda outras pessoas a encontrá-lo.';

  @override
  String get ratingPromptNo => 'Não muito';

  @override
  String get ratingPromptYes => 'Sim, gosto';

  @override
  String get boardActionShare => 'Partilhar';

  @override
  String get boardActionEditBoard => 'Editar cartela';

  @override
  String get boardActionAddPreMadeItems => 'Adicionar itens prontos';

  @override
  String get cellHint => 'Introduzir texto…';

  @override
  String get edit => 'Editar';

  @override
  String get markDone => 'Marcar como feito';

  @override
  String get markNotDone => 'Marcar como não feito';

  @override
  String get newCardMenuItem => 'Nova cartela de bingo';

  @override
  String get allBoardsMenuItem => 'Todas as cartelas';

  @override
  String get yourCardsHeader => 'As suas cartelas';

  @override
  String get noBoardsYet => 'Ainda não há cartelas';

  @override
  String get pageNotFoundTitle => 'Página não encontrada';

  @override
  String get homeButton => 'Início';

  @override
  String revenueCatUserIdLabel(String userId) {
    return 'ID de usuário do RevenueCat: $userId';
  }

  @override
  String get copyRevenueCatUserIdTooltip =>
      'Copiar ID de usuário do RevenueCat';

  @override
  String get revenueCatUserIdCopiedToast =>
      'ID de usuário do RevenueCat copiado.';

  @override
  String get settingsHeader => 'Definições';

  @override
  String get clearSettingsMenuItem => 'Limpar definições';

  @override
  String get appearanceMenuItem => 'Aparência';

  @override
  String get settingsAppearanceSection => 'Aparência';

  @override
  String get settingsPreferencesSection => 'Preferências';

  @override
  String get settingsBoardsSection => 'Cartelas';

  @override
  String get settingsHelpSection => 'Mais';

  @override
  String get settingsSupportSection => 'Apoio';

  @override
  String get themeColorLabel => 'Cor do tema';

  @override
  String get themeColorSettingsDescription =>
      'Escolha a paleta usada em toda a app.';

  @override
  String get languageSettingsTitle => 'Idioma';

  @override
  String get languageSettingsSelectorLabel => 'Idioma da app';

  @override
  String languageSettingsSystemOption(String language) {
    return 'Padrão do sistema ($language)';
  }

  @override
  String languageSettingsSystemDescription(String language) {
    return 'Segue o idioma do telefone: $language.';
  }

  @override
  String get languageSettingsOverrideDescription =>
      'Usar este idioma em vez do idioma do telefone.';

  @override
  String get darkModeLabel => 'Modo escuro';

  @override
  String get darkModeSettingsDescription => 'Usar uma interface mais escura.';

  @override
  String get enableConfettiLabel => 'Confete';

  @override
  String get enableConfettiSettingsDescription =>
      'Mostrar uma celebração ao completar um bingo.';

  @override
  String get preMadeTilesTitle => 'Casas prontas';

  @override
  String get preMadeTilesSettingsDescription =>
      'Crie textos reutilizáveis para futuros tabuleiros.';

  @override
  String get preMadeTilesDescription =>
      'Crie entradas de bingo reutilizáveis aqui. Ao criar um novo tabuleiro, você pode adicioná-las sem digitar tudo de novo.';

  @override
  String get preMadeTilesSelectMode => 'Selecionar';

  @override
  String get preMadeTilesEditMode => 'Editar';

  @override
  String get preMadeTileHint => 'Texto da casa';

  @override
  String get preMadeTilesAdd => 'Adicionar casa';

  @override
  String get preMadeTilesDelete => 'Excluir casa';

  @override
  String get preMadeTilesSelectAll => 'Selecionar/desmarcar tudo';

  @override
  String get preMadeTilesSelectNone => 'Não selecionar nada';

  @override
  String get preMadeTilesApply => 'Aplicar';

  @override
  String get preMadeTilesReplaceItems => 'Substituir itens';

  @override
  String get preMadeTilesFillItems => 'Preencher itens';

  @override
  String get preMadeTilesBoardActionHelp =>
      'Substituir troca as entradas do tabuleiro por um sorteio da sua seleção. Preencher só adiciona itens às casas vazias. Em tabuleiros ímpares, a casa central permanece.';

  @override
  String preMadeTilesSelectedCount(int selected, int total) {
    return '$selected / $total selecionadas';
  }

  @override
  String get preMadeTilesEmptyTitle => 'Ainda não há casas';

  @override
  String get preMadeTilesEmptyBody =>
      'Adicione uma casa para começar uma lista reutilizável.';

  @override
  String get proposeFeatures => 'Propor recursos';

  @override
  String get proposeFeaturesSettingsDescription =>
      'Vote em ideias e sugira o que criar a seguir.';

  @override
  String get supportMeDirectly => 'Apoiar o desenvolvedor';

  @override
  String get supportMeDirectlySettingsDescription =>
      'Ajude a financiar o desenvolvimento e manter o app melhorando.';

  @override
  String get supportCarouselProTitle => 'Apoie o Custom Bingo';

  @override
  String get supportCarouselProSubtitle =>
      'Desbloqueie cores extras e ajude a manter o app independente.';

  @override
  String get supportCarouselRateTitle => 'Está gostando do app?';

  @override
  String get supportCarouselRateSubtitle =>
      'Uma avaliação rápida ajuda mais pessoas a encontrarem o Custom Bingo.';

  @override
  String get rateTheApp => 'Avaliar o app';

  @override
  String get rateTheAppSettingsDescription =>
      'Abrir o pedido de avaliação na loja.';

  @override
  String get contactMe => 'Entrar em contato';

  @override
  String get contactMeSettingsDescription =>
      'Envie comentários, perguntas ou relatos de bugs por email.';

  @override
  String get paywallTitle => 'Apoie o Custom Bingo';

  @override
  String get paywallThankYouTitle => 'Obrigado';

  @override
  String get paywallSupportTitle => 'Apoie o Custom Bingo';

  @override
  String get paywallSupportBody =>
      'Esta compra me apoia diretamente, o desenvolvedor. Você recebe minha gratidão e alguns pequenos extras para seus tabuleiros.';

  @override
  String get paywallBonusGratitude => 'Minha gratidão, de verdade.';

  @override
  String get paywallBonusColors => 'Algumas cores extras para tabuleiros.';

  @override
  String get paywallBonusExtras =>
      'Pequenos extras de apoiador ao longo do tempo.';

  @override
  String get paywallFreeForever =>
      'Ninguém precisa pagar por este app. O Custom Bingo continua utilizável para todos.';

  @override
  String get paywallLoadingPrice => 'Carregando preço';

  @override
  String get paywallUnavailable => 'Indisponível';

  @override
  String get paywallSupportOnce => 'Apoiar uma vez';

  @override
  String get paywallRestorePurchase => 'Restaurar compra';

  @override
  String get paywallProActiveToast => 'Custom Bingo Pro está ativo.';

  @override
  String get paywallPurchaseInactiveToast =>
      'A compra terminou, mas o Pro não está ativo.';

  @override
  String get paywallProRestoredToast => 'Custom Bingo Pro restaurado.';

  @override
  String get paywallNoPurchaseFoundToast => 'Nenhuma compra Pro encontrada.';

  @override
  String get paywallPurchasesUnavailable =>
      'As compras estão indisponíveis no momento.';

  @override
  String get paywallPlatformUnavailable =>
      'As compras não estão disponíveis nesta plataforma.';

  @override
  String get paywallCouldNotLoad =>
      'Não foi possível carregar as informações de compra.';

  @override
  String get shareTitle => 'Partilhar a cartela de bingo';

  @override
  String get shareDialogPrompt => 'Como você gostaria de compartilhar?';

  @override
  String get shareImageOptionTitle => 'Partilhar como imagem';

  @override
  String get shareImageOptionHelper =>
      'Envie uma imagem da sua cartela. Qualquer pessoa pode ver, mesmo sem o app.';

  @override
  String get shareImageOptionButton => 'Partilhar imagem';

  @override
  String get shareInviteOptionTitle => 'Convidar amigos para jogar';

  @override
  String get shareInviteOptionHelper =>
      'Envie este link para amigos que também têm este app instalado. Eles recebem a mesma cartela e vocês podem jogar juntos.';

  @override
  String get shareInviteIncludeMarks => 'Incluir minhas marcações';

  @override
  String get shareInviteIncludeMarksHelper =>
      'Quando ativado, seus amigos verão o que você já marcou.';

  @override
  String get shareInviteOptionButton => 'Enviar convite';

  @override
  String shareInviteText(String name, String link) {
    return 'Joga “$name” comigo! Abre na app:\n$link';
  }

  @override
  String get close => 'Fechar';

  @override
  String get shareSubject => 'Cartela de bingo';

  @override
  String get importTitle =>
      'Um amigo compartilhou uma cartela de bingo com você';

  @override
  String get importBody => 'Adicionar às suas cartelas para jogar junto?';

  @override
  String get importConfirm => 'Adicionar às minhas cartelas';

  @override
  String get importCancel => 'Agora não';

  @override
  String importCollisionToast(String newName) {
    return 'Você já tinha uma cartela com este nome, então eu a adicionei como \"$newName\".';
  }

  @override
  String get importBadLinkToast =>
      'Desculpe, este convite não pôde ser aberto. Peça ao seu amigo para enviá-lo novamente.';

  @override
  String get importOutdatedAppToast =>
      'Atualize o app para abrir este convite.';

  @override
  String get toastInfo => 'Informação';

  @override
  String get toastSuccess => 'Sucesso';

  @override
  String get toastError => 'Erro';

  @override
  String get lastChangeNever => 'Última alteração: nunca';

  @override
  String lastChange(String date, String time) {
    return 'Última alteração: $date $time';
  }

  @override
  String get screenshotCaptionPlaying =>
      'Um app simples para criar tabuleiros de bingo.\\n\\nSem cadastro, sem anúncios e totalmente grátis.';

  @override
  String get screenshotCaptionCreate =>
      'Literalmente só duas telas para criar uma grade de bingo.';

  @override
  String get screenshotCaptionLocked => 'É isso.';

  @override
  String get screenshotBoardName => 'Casamento do David';

  @override
  String get screenshotTilePhoneDuringVows => 'Celular durante os votos';

  @override
  String get screenshotTileChampagneSpilled => 'Champanhe derramado';

  @override
  String get screenshotTileSpeechTears => 'Lágrimas no discurso';

  @override
  String get screenshotTileDramaticEntrance => 'Entrada dramática';

  @override
  String get screenshotTileKidsDanceFloor => 'Crianças na pista';

  @override
  String get screenshotTileGuestToast => 'Convidado faz um brinde';

  @override
  String get screenshotTileCrowdClapsEarly => 'Aplausos cedo demais';

  @override
  String get screenshotTileDjClassic => 'DJ toca um clássico';

  @override
  String get screenshotTileGroupPhotoChaos => 'Caos na foto de grupo';
}
