import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// AppBar title of the new-card screen
  ///
  /// In en, this message translates to:
  /// **'Create New Bingo Grid'**
  String get newCardTitle;

  /// Label of the card-name text field
  ///
  /// In en, this message translates to:
  /// **'Bingo Grid Name *'**
  String get cardNameLabel;

  /// Placeholder hint for the card-name text field
  ///
  /// In en, this message translates to:
  /// **'Enter a name for your bingo grid'**
  String get cardNameHint;

  /// Confirm button on the new-card screen
  ///
  /// In en, this message translates to:
  /// **'Create Bingo Grid'**
  String get createCardButton;

  /// Expandable section title for pre-made items on the new-board screen
  ///
  /// In en, this message translates to:
  /// **'Your pre-made items'**
  String get newBoardPreMadeSectionTitle;

  /// Button that opens pre-made item selection from the new-board screen
  ///
  /// In en, this message translates to:
  /// **'Start with pre-made items'**
  String get newBoardPreMadeButton;

  /// Button that reopens pre-made item selection after items have been applied
  ///
  /// In en, this message translates to:
  /// **'Change pre-made items'**
  String get newBoardPreMadeChangeButton;

  /// Button that clears applied pre-made entries from the new-board form
  ///
  /// In en, this message translates to:
  /// **'Clear pre-made items'**
  String get newBoardPreMadeClearButton;

  /// Summary of how many pre-made entries are applied to the new-board form
  ///
  /// In en, this message translates to:
  /// **'{count} pre-made entries applied'**
  String newBoardPreMadeAppliedCount(int count);

  /// Summary when applied pre-made entries can fill the new board
  ///
  /// In en, this message translates to:
  /// **'{used} will be drawn at random for this board.'**
  String newBoardPreMadeFullSummary(int used);

  /// Summary when applied pre-made entries are fewer than the board cells
  ///
  /// In en, this message translates to:
  /// **'{used} cells will be filled. {blank} will stay blank.'**
  String newBoardPreMadePartialSummary(int used, int blank);

  /// Fallback title shown when a card has no name
  ///
  /// In en, this message translates to:
  /// **'Bingo Card'**
  String get defaultCardName;

  /// Hint banner above the bingo grid
  ///
  /// In en, this message translates to:
  /// **'Press long to mark a field as checked'**
  String get toggleHint;

  /// First half of the hint that explains the lock toggle. The lock icon is rendered between the two halves.
  ///
  /// In en, this message translates to:
  /// **'Press the lock icon'**
  String get editingHintBefore;

  /// Second half of the lock-toggle hint, rendered after the lock icon.
  ///
  /// In en, this message translates to:
  /// **' to make the fields not editable anymore.'**
  String get editingHintAfter;

  /// Title of the delete-card confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Card'**
  String get deleteCardTitle;

  /// Body of the delete-card confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this card?'**
  String get deleteCardConfirm;

  /// Generic cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Generic delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Title of the shuffle confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Shuffle Card'**
  String get shuffleCardTitle;

  /// Body of the shuffle confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to shuffle this card? All fields will be unchecked, after shuffling.'**
  String get shuffleCardConfirm;

  /// Confirm button to shuffle the card
  ///
  /// In en, this message translates to:
  /// **'Shuffle'**
  String get shuffle;

  /// Title of the dialog shown before asking for an app store review
  ///
  /// In en, this message translates to:
  /// **'Do you like Custom Bingo?'**
  String get ratingPromptTitle;

  /// Body of the dialog shown before asking for an app store review
  ///
  /// In en, this message translates to:
  /// **'If so, a quick store review helps others find it.'**
  String get ratingPromptBody;

  /// Dismiss button for the rating prompt dialog
  ///
  /// In en, this message translates to:
  /// **'Not really'**
  String get ratingPromptNo;

  /// Confirm button that continues to the native app store review flow
  ///
  /// In en, this message translates to:
  /// **'Yes, I like it'**
  String get ratingPromptYes;

  /// Menu item that opens the share dialog from the board action bar
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get boardActionShare;

  /// Debug menu item placeholder for filling a board with pre-made items
  ///
  /// In en, this message translates to:
  /// **'Add pre-made items'**
  String get boardActionAddPreMadeItems;

  /// Placeholder for an empty bingo cell
  ///
  /// In en, this message translates to:
  /// **'Enter text…'**
  String get cellHint;

  /// Edit menu item in a cell's context menu
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Cell context menu item: mark this cell as done
  ///
  /// In en, this message translates to:
  /// **'Mark Done'**
  String get markDone;

  /// Cell context menu item: clear the done state
  ///
  /// In en, this message translates to:
  /// **'Mark Not Done'**
  String get markNotDone;

  /// Menu item that opens the new-card screen
  ///
  /// In en, this message translates to:
  /// **'New bingo board'**
  String get newCardMenuItem;

  /// Section header in the popup menu listing saved cards
  ///
  /// In en, this message translates to:
  /// **'Your Boards'**
  String get yourCardsHeader;

  /// Section header in the popup menu
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsHeader;

  /// Menu item that opens the appearance settings screen
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceMenuItem;

  /// Label above the theme color selector in settings
  ///
  /// In en, this message translates to:
  /// **'Theme color'**
  String get themeColorLabel;

  /// Label for the dark mode switch in settings
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkModeLabel;

  /// Title of the pre-made tiles settings screen and menu entry
  ///
  /// In en, this message translates to:
  /// **'Pre-made tiles'**
  String get preMadeTilesTitle;

  /// Settings entry helper text for pre-made tiles
  ///
  /// In en, this message translates to:
  /// **'Create reusable tile text for future boards.'**
  String get preMadeTilesSettingsDescription;

  /// Description shown below the pre-made tiles screen title
  ///
  /// In en, this message translates to:
  /// **'Create reusable bingo entries here. When you create a new board, you can add them without typing everything again.'**
  String get preMadeTilesDescription;

  /// Segmented control label for selecting pre-made tiles
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get preMadeTilesSelectMode;

  /// Segmented control label for editing pre-made tiles
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get preMadeTilesEditMode;

  /// Placeholder for a pre-made tile text field
  ///
  /// In en, this message translates to:
  /// **'Tile text'**
  String get preMadeTileHint;

  /// Accessible label and tooltip for adding a pre-made tile
  ///
  /// In en, this message translates to:
  /// **'Add tile'**
  String get preMadeTilesAdd;

  /// Accessible label and tooltip for deleting a pre-made tile
  ///
  /// In en, this message translates to:
  /// **'Delete tile'**
  String get preMadeTilesDelete;

  /// Checkbox label for toggling all pre-made tile selections
  ///
  /// In en, this message translates to:
  /// **'Un/select all'**
  String get preMadeTilesSelectAll;

  /// Button label for clearing all selected pre-made tiles
  ///
  /// In en, this message translates to:
  /// **'Select none'**
  String get preMadeTilesSelectNone;

  /// Button label for applying selected pre-made tiles to a board
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get preMadeTilesApply;

  /// Button label for replacing current board items with selected pre-made items
  ///
  /// In en, this message translates to:
  /// **'Replace items'**
  String get preMadeTilesReplaceItems;

  /// Button label for filling empty board items with selected pre-made items
  ///
  /// In en, this message translates to:
  /// **'Fill items'**
  String get preMadeTilesFillItems;

  /// Helper text explaining replace and fill actions for pre-made items on an existing board
  ///
  /// In en, this message translates to:
  /// **'Replace swaps the board entries with a random draw from your selection. Fill only adds items to empty tiles. On odd boards, the center tile stays in place.'**
  String get preMadeTilesBoardActionHelp;

  /// Count of selected pre-made tiles
  ///
  /// In en, this message translates to:
  /// **'{selected} / {total} selected'**
  String preMadeTilesSelectedCount(int selected, int total);

  /// Empty-state title for the pre-made tiles screen
  ///
  /// In en, this message translates to:
  /// **'No tiles yet'**
  String get preMadeTilesEmptyTitle;

  /// Empty-state helper text for the pre-made tiles screen
  ///
  /// In en, this message translates to:
  /// **'Add a tile to start building a reusable list.'**
  String get preMadeTilesEmptyBody;

  /// Menu item that opens the UserOrient feedback board
  ///
  /// In en, this message translates to:
  /// **'Propose Features'**
  String get proposeFeatures;

  /// Title of the optional email prompt before opening UserOrient
  ///
  /// In en, this message translates to:
  /// **'Want us to follow up?'**
  String get userEmailPromptTitle;

  /// Body copy explaining the optional email prompt before opening UserOrient
  ///
  /// In en, this message translates to:
  /// **'Add your email address if you\'d like us to reply about your feedback.'**
  String get userEmailPromptBody;

  /// Label for the optional email field before opening UserOrient
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get userEmailPromptFieldLabel;

  /// Hint text for the optional email field before opening UserOrient
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get userEmailPromptFieldHint;

  /// Checkbox label for opting out of future optional email prompts
  ///
  /// In en, this message translates to:
  /// **'Don\'t ask me again'**
  String get userEmailPromptDontAskAgain;

  /// Button label to skip the optional email prompt
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get userEmailPromptSkip;

  /// Button label to continue after optionally entering an email
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get userEmailPromptContinue;

  /// Validation error shown when the optional email field has an invalid email address
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get userEmailPromptInvalidEmail;

  /// Menu item that opens the direct-support paywall
  ///
  /// In en, this message translates to:
  /// **'Support me directly'**
  String get supportMeDirectly;

  /// Title of the share dialog
  ///
  /// In en, this message translates to:
  /// **'Share the bingo card'**
  String get shareTitle;

  /// Section header above the two share options
  ///
  /// In en, this message translates to:
  /// **'How would you like to share?'**
  String get shareDialogPrompt;

  /// Title of the image-share option in the share dialog
  ///
  /// In en, this message translates to:
  /// **'Share as image'**
  String get shareImageOptionTitle;

  /// Helper text explaining what 'Share as image' does
  ///
  /// In en, this message translates to:
  /// **'Send a picture of your card. Anyone can see it — even without the app.'**
  String get shareImageOptionHelper;

  /// Confirm button on the image-share option
  ///
  /// In en, this message translates to:
  /// **'Share image'**
  String get shareImageOptionButton;

  /// Title of the play-together invite option
  ///
  /// In en, this message translates to:
  /// **'Invite friends to play'**
  String get shareInviteOptionTitle;

  /// Helper text explaining what the invite link does
  ///
  /// In en, this message translates to:
  /// **'Send this link to your friends who also have this app installed. They get the same card and you can play together.'**
  String get shareInviteOptionHelper;

  /// Toggle label: include the sender's marks in the invite
  ///
  /// In en, this message translates to:
  /// **'Include my checkmarks'**
  String get shareInviteIncludeMarks;

  /// Helper text under the include-checkmarks toggle
  ///
  /// In en, this message translates to:
  /// **'When on, your friends will see what you\'ve already crossed off.'**
  String get shareInviteIncludeMarksHelper;

  /// Confirm button on the invite-link option
  ///
  /// In en, this message translates to:
  /// **'Send invite'**
  String get shareInviteOptionButton;

  /// Body text passed to the system share sheet alongside the invite link
  ///
  /// In en, this message translates to:
  /// **'Play \"{name}\" with me! Open it in the app:\n{link}'**
  String shareInviteText(String name, String link);

  /// Generic close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Subject/title used by the system share sheet
  ///
  /// In en, this message translates to:
  /// **'Bingo Card'**
  String get shareSubject;

  /// Title of the import-card screen shown to the receiver
  ///
  /// In en, this message translates to:
  /// **'A friend shared a bingo card with you'**
  String get importTitle;

  /// Body of the import-card screen
  ///
  /// In en, this message translates to:
  /// **'Add it to your cards so you can play along?'**
  String get importBody;

  /// Confirm button on the import-card screen
  ///
  /// In en, this message translates to:
  /// **'Add to my cards'**
  String get importConfirm;

  /// Cancel button on the import-card screen
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get importCancel;

  /// Toast shown after silently renaming an imported card to avoid a collision
  ///
  /// In en, this message translates to:
  /// **'You already had a card with this name, so I added it as \"{newName}\".'**
  String importCollisionToast(String newName);

  /// Toast shown when an invite link is malformed
  ///
  /// In en, this message translates to:
  /// **'Sorry, this invite couldn\'t be opened. Ask your friend to send it again.'**
  String get importBadLinkToast;

  /// Toast shown when an invite payload uses a newer schema
  ///
  /// In en, this message translates to:
  /// **'Update the app to open this invite.'**
  String get importOutdatedAppToast;

  /// Title of an informational toast
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get toastInfo;

  /// Title of a success toast
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get toastSuccess;

  /// Title of an error toast
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get toastError;

  /// Footer line shown when a card has never been edited
  ///
  /// In en, this message translates to:
  /// **'Last change: Never'**
  String get lastChangeNever;

  /// Footer line showing when the card was last edited
  ///
  /// In en, this message translates to:
  /// **'Last change: {date} {time}'**
  String lastChange(String date, String time);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
