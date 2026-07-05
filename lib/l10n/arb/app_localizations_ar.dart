// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get newCardTitle => 'إنشاء شبكة بنغو جديدة';

  @override
  String get editCardTitle => 'تعديل شبكة البنغو';

  @override
  String get cardNameLabel => 'اسم شبكة البنغو *';

  @override
  String get cardNameHint => 'أدخل اسمًا لشبكة البنغو';

  @override
  String get createCardButton => 'إنشاء شبكة البنغو';

  @override
  String get updateCardButton => 'تحديث شبكة البنغو';

  @override
  String get newBoardPreMadeSectionTitle => 'عناصرك الجاهزة';

  @override
  String get newBoardPreMadeButton => 'ابدأ بعناصر جاهزة';

  @override
  String get newBoardPreMadeChangeButton => 'تغيير العناصر الجاهزة';

  @override
  String get newBoardPreMadeClearButton => 'مسح العناصر الجاهزة';

  @override
  String newBoardPreMadeAppliedCount(int count) {
    return 'تم تطبيق $count إدخالات جاهزة';
  }

  @override
  String newBoardPreMadeFullSummary(int used) {
    return 'سيتم اختيار $used عشوائيًا لهذا اللوح.';
  }

  @override
  String newBoardPreMadePartialSummary(int used, int blank) {
    return 'سيتم ملء $used خانات. ستبقى $blank فارغة.';
  }

  @override
  String get defaultCardName => 'بطاقة بنغو';

  @override
  String get toggleHint => 'اضغط مطولًا لوضع علامة على خانة';

  @override
  String get editingHintBefore => 'اضغط على أيقونة القفل';

  @override
  String get editingHintAfter => ' لجعل الخانات غير قابلة للتحرير.';

  @override
  String get deleteCardTitle => 'حذف البطاقة';

  @override
  String get deleteCardConfirm => 'هل أنت متأكد أنك تريد حذف هذه البطاقة؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get shuffleCardTitle => 'خلط البطاقة';

  @override
  String get shuffleCardConfirm =>
      'هل أنت متأكد أنك تريد خلط هذه البطاقة؟ سيتم إلغاء تحديد كل الخانات بعد الخلط.';

  @override
  String get shuffle => 'خلط';

  @override
  String get ratingPromptTitle => 'هل يعجبك Custom Bingo؟';

  @override
  String get ratingPromptBody =>
      'إذا كان كذلك، فإن تقييمًا سريعًا في المتجر يساعد الآخرين على العثور عليه.';

  @override
  String get ratingPromptNo => 'ليس كثيرًا';

  @override
  String get ratingPromptYes => 'نعم، يعجبني';

  @override
  String get boardActionShare => 'مشاركة';

  @override
  String get boardActionEditBoard => 'تعديل اللوحة';

  @override
  String get boardActionAddPreMadeItems => 'إضافة عناصر جاهزة';

  @override
  String get cellHint => 'أدخل نصًا…';

  @override
  String get edit => 'تعديل';

  @override
  String get markDone => 'وضع علامة تم';

  @override
  String get markNotDone => 'إزالة علامة تم';

  @override
  String get newCardMenuItem => 'لوحة بنغو جديدة';

  @override
  String get allBoardsMenuItem => 'كل الألواح';

  @override
  String get yourCardsHeader => 'لوحاتك';

  @override
  String get noBoardsYet => 'لا توجد ألواح بعد';

  @override
  String get pageNotFoundTitle => 'الصفحة غير موجودة';

  @override
  String get homeButton => 'الرئيسية';

  @override
  String revenueCatUserIdLabel(String userId) {
    return 'معرّف مستخدم RevenueCat: $userId';
  }

  @override
  String get copyRevenueCatUserIdTooltip => 'نسخ معرّف مستخدم RevenueCat';

  @override
  String get revenueCatUserIdCopiedToast => 'تم نسخ معرّف مستخدم RevenueCat.';

  @override
  String get settingsHeader => 'الإعدادات';

  @override
  String get clearSettingsMenuItem => 'مسح الإعدادات';

  @override
  String get appearanceMenuItem => 'المظهر';

  @override
  String get settingsAppearanceSection => 'المظهر';

  @override
  String get settingsPreferencesSection => 'التفضيلات';

  @override
  String get settingsBoardsSection => 'اللوحات';

  @override
  String get settingsHelpSection => 'المزيد';

  @override
  String get settingsSupportSection => 'الدعم';

  @override
  String get themeColorLabel => 'لون السمة';

  @override
  String get themeColorSettingsDescription =>
      'اختر لوحة الألوان المستخدمة في التطبيق.';

  @override
  String get languageSettingsTitle => 'اللغة';

  @override
  String get languageSettingsSelectorLabel => 'لغة التطبيق';

  @override
  String languageSettingsSystemOption(String language) {
    return 'إعداد النظام الافتراضي ($language)';
  }

  @override
  String languageSettingsSystemDescription(String language) {
    return 'يتبع لغة الهاتف: $language.';
  }

  @override
  String get languageSettingsOverrideDescription =>
      'استخدم هذه اللغة بدلًا من لغة الهاتف.';

  @override
  String get darkModeLabel => 'الوضع الداكن';

  @override
  String get darkModeSettingsDescription => 'استخدم واجهة أغمق.';

  @override
  String get enableConfettiLabel => 'قصاصات الاحتفال';

  @override
  String get enableConfettiSettingsDescription =>
      'اعرض احتفالًا عند إكمال بنغو.';

  @override
  String get preMadeTilesTitle => 'خانات جاهزة';

  @override
  String get preMadeTilesSettingsDescription =>
      'أنشئ نصوص خانات قابلة لإعادة الاستخدام للألواح القادمة.';

  @override
  String get preMadeTilesDescription =>
      'أنشئ هنا إدخالات بينغو قابلة لإعادة الاستخدام. عند إنشاء لوح جديد، يمكنك إضافتها دون كتابة كل شيء مرة أخرى.';

  @override
  String get preMadeTilesSelectMode => 'تحديد';

  @override
  String get preMadeTilesEditMode => 'تحرير';

  @override
  String get preMadeTileHint => 'نص الخانة';

  @override
  String get preMadeTilesAdd => 'إضافة خانة';

  @override
  String get preMadeTilesDelete => 'حذف خانة';

  @override
  String get preMadeTilesSelectAll => 'تحديد/إلغاء تحديد الكل';

  @override
  String get preMadeTilesSelectNone => 'إلغاء التحديد';

  @override
  String get preMadeTilesApply => 'تطبيق';

  @override
  String get preMadeTilesReplaceItems => 'استبدال العناصر';

  @override
  String get preMadeTilesFillItems => 'ملء العناصر';

  @override
  String get preMadeTilesBoardActionHelp =>
      'الاستبدال يبدل إدخالات اللوح بسحب عشوائي من اختيارك. الملء يضيف العناصر إلى الخانات الفارغة فقط. في الألواح الفردية، تبقى الخانة الوسطى كما هي.';

  @override
  String preMadeTilesSelectedCount(int selected, int total) {
    return '$selected / $total محددة';
  }

  @override
  String get preMadeTilesEmptyTitle => 'لا توجد خانات بعد';

  @override
  String get preMadeTilesEmptyBody =>
      'أضف خانة لبدء إنشاء قائمة قابلة لإعادة الاستخدام.';

  @override
  String get proposeFeatures => 'اقتراح ميزات';

  @override
  String get proposeFeaturesSettingsDescription =>
      'صوّت على الأفكار واقترح ما يجب بناؤه لاحقًا.';

  @override
  String get supportMeDirectly => 'دعم المطور';

  @override
  String get supportMeDirectlySettingsDescription =>
      'ساعد في تمويل التطوير والحفاظ على تحسين التطبيق.';

  @override
  String get supportCarouselProTitle => 'ادعم Custom Bingo';

  @override
  String get supportCarouselProSubtitle =>
      'افتح ألوانًا إضافية وساعد في بقاء التطبيق مستقلًا.';

  @override
  String get supportCarouselRateTitle => 'هل تستمتع بالتطبيق؟';

  @override
  String get supportCarouselRateSubtitle =>
      'تقييم سريع يساعد المزيد من الناس على العثور على Custom Bingo.';

  @override
  String get rateTheApp => 'تقييم التطبيق';

  @override
  String get rateTheAppSettingsDescription => 'فتح طلب التقييم في المتجر.';

  @override
  String get contactMe => 'تواصل معي';

  @override
  String get contactMeSettingsDescription =>
      'أرسل ملاحظات أو أسئلة أو تقارير أخطاء عبر البريد الإلكتروني.';

  @override
  String get paywallTitle => 'ادعم Custom Bingo';

  @override
  String get paywallThankYouTitle => 'شكرًا لك';

  @override
  String get paywallSupportTitle => 'ادعم Custom Bingo';

  @override
  String get paywallSupportBody =>
      'هذا الشراء يدعمني مباشرة بصفتي المطور. تحصل على امتناني وبعض الإضافات الصغيرة لألواحك.';

  @override
  String get paywallBonusGratitude => 'امتناني الصادق.';

  @override
  String get paywallBonusColors => 'بعض ألوان الألواح الإضافية.';

  @override
  String get paywallBonusExtras => 'إضافات صغيرة للداعمين مع الوقت.';

  @override
  String get paywallFreeForever =>
      'لا يحتاج أحد أبدًا إلى الدفع لاستخدام هذا التطبيق. سيبقى Custom Bingo متاحًا للجميع.';

  @override
  String get paywallLoadingPrice => 'جارٍ تحميل السعر';

  @override
  String get paywallUnavailable => 'غير متاح';

  @override
  String get paywallSupportOnce => 'ادعم مرة واحدة';

  @override
  String get paywallRestorePurchase => 'استعادة الشراء';

  @override
  String get paywallProActiveToast => 'Custom Bingo Pro نشط.';

  @override
  String get paywallPurchaseInactiveToast => 'اكتمل الشراء، لكن Pro غير نشط.';

  @override
  String get paywallProRestoredToast => 'تمت استعادة Custom Bingo Pro.';

  @override
  String get paywallNoPurchaseFoundToast => 'لم يتم العثور على شراء Pro.';

  @override
  String get paywallPurchasesUnavailable => 'المشتريات غير متاحة الآن.';

  @override
  String get paywallPlatformUnavailable =>
      'المشتريات غير متاحة على هذا النظام.';

  @override
  String get paywallCouldNotLoad => 'تعذر تحميل معلومات الشراء.';

  @override
  String get shareTitle => 'مشاركة بطاقة البنغو';

  @override
  String get shareDialogPrompt => 'كيف تريد المشاركة؟';

  @override
  String get shareImageOptionTitle => 'مشاركة كصورة';

  @override
  String get shareImageOptionHelper =>
      'أرسل صورة لبطاقتك. يمكن لأي شخص رؤيتها حتى بدون التطبيق.';

  @override
  String get shareImageOptionButton => 'مشاركة الصورة';

  @override
  String get shareInviteOptionTitle => 'دعوة الأصدقاء للعب';

  @override
  String get shareInviteOptionHelper =>
      'أرسل هذا الرابط إلى أصدقائك الذين لديهم هذا التطبيق أيضًا. سيحصلون على نفس البطاقة ويمكنكم اللعب معًا.';

  @override
  String get shareInviteIncludeMarks => 'تضمين علاماتي';

  @override
  String get shareInviteIncludeMarksHelper =>
      'عند التفعيل، سيرى أصدقاؤك ما شطبته بالفعل.';

  @override
  String get shareInviteOptionButton => 'إرسال الدعوة';

  @override
  String shareInviteText(String name, String link) {
    return 'العب \"$name\" معي! افتحه في التطبيق:\n$link';
  }

  @override
  String get close => 'إغلاق';

  @override
  String get shareSubject => 'بطاقة بينغو';

  @override
  String get importTitle => 'شارك صديق بطاقة بينغو معك';

  @override
  String get importBody => 'هل تريد إضافتها إلى بطاقاتك لتلعب معه؟';

  @override
  String get importConfirm => 'إضافة إلى بطاقاتي';

  @override
  String get importCancel => 'ليس الآن';

  @override
  String importCollisionToast(String newName) {
    return 'كانت لديك بطاقة بهذا الاسم، لذلك أضفتها باسم \"$newName\".';
  }

  @override
  String get importBadLinkToast =>
      'عذرًا، تعذر فتح هذه الدعوة. اطلب من صديقك إرسالها مرة أخرى.';

  @override
  String get importOutdatedAppToast => 'حدّث التطبيق لفتح هذه الدعوة.';

  @override
  String get toastInfo => 'معلومة';

  @override
  String get toastSuccess => 'نجاح';

  @override
  String get toastError => 'خطأ';

  @override
  String get lastChangeNever => 'آخر تغيير: أبدًا';

  @override
  String lastChange(String date, String time) {
    return 'آخر تغيير: $date $time';
  }

  @override
  String get screenshotCaptionPlaying =>
      'تطبيق بسيط لإنشاء لوح بينغو.\\n\\nبدون تسجيل، بدون إعلانات، ومجاني بالكامل.';

  @override
  String get screenshotCaptionCreate => 'شاشتان فقط لإنشاء شبكة بينغو.';

  @override
  String get screenshotCaptionLocked => 'هذا كل شيء.';

  @override
  String get screenshotBoardName => 'زفاف ديفيد';

  @override
  String get screenshotTilePhoneDuringVows => 'هاتف أثناء الوعود';

  @override
  String get screenshotTileChampagneSpilled => 'انسكاب الشمبانيا';

  @override
  String get screenshotTileSpeechTears => 'دموع أثناء الخطاب';

  @override
  String get screenshotTileDramaticEntrance => 'دخول درامي';

  @override
  String get screenshotTileKidsDanceFloor => 'الأطفال على ساحة الرقص';

  @override
  String get screenshotTileGuestToast => 'ضيف يرفع نخبًا';

  @override
  String get screenshotTileCrowdClapsEarly => 'تصفيق مبكر';

  @override
  String get screenshotTileDjClassic => 'الدي جي يشغل أغنية كلاسيكية';

  @override
  String get screenshotTileGroupPhotoChaos => 'فوضى صورة جماعية';
}
