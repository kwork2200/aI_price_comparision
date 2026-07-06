class AppString {
  static const String comparisonApp = "Comparison App";

  // AdMob Status Strings
  static const String adMobAdsConfigChanged = 'AdMob: Ads config changed - Enabled: ';
  static const String adMobAdsDisabledDispose = 'AdMob: Disposing all ads due to config change';
  static const String adMobAreAdsEnabled = '📱 AdMob: areAdsEnabled = ';

  // Banner Ad
  static const String bannerAdCreateCalled = '🎯 createBannerAd() called';
  static const String bannerAdAreAdsEnabled = '📱 areAdsEnabled: ';
  static const String bannerAdDisabled = '🚫 Ads are disabled, skipping banner ad creation';
  static const String bannerAdCreating = '🎯 Creating banner ad with unit ID: ';
  static const String bannerAdLoaded = '✅ Banner ad loaded successfully!';
  static const String bannerAdFailedToLoad = '❌ Banner ad failed to load: ';
  static const String bannerAdErrorCode = '❌ Error code: ';
  static const String bannerAdErrorDomain = '❌ Error domain: ';
  static const String bannerAdOpened = '📱 Banner ad opened';
  static const String bannerAdClosed = '📱 Banner ad closed';
  static const String bannerAdLoading = '🔄 Banner ad loading...';
  static const String bannerAdGetWidgetCalled = '📱 getBannerAdWidget() called';
  static const String bannerAdIsNull = '📱 bannerAd is null: ';
  static const String bannerAdIsLoaded = '📱 _isBannerAdLoaded: ';
  static const String bannerAdReturning = '✅ Returning banner ad widget';
  static const String bannerAdNoAvailable = '❌ No banner ad available, returning empty widget';

  // App Open Ad
  static const String appOpenAdDisabled = '🚫 Ads are disabled, skipping app open ad loading';
  static const String appOpenAdAlreadyLoading = '📱 App open ad already loading or loaded';
  static const String appOpenAdLoading = '🎯 Loading app open ad with unit ID: ';
  static const String appOpenAdLoaded = '✅ App open ad loaded successfully!';
  static const String appOpenAdFailedToLoad = '❌ App open ad failed to load: ';
  static const String appOpenAdShowDisabled = '🚫 Ads are disabled, skipping app open ad show';
  static const String appOpenAdNoAvailable = '⚠️ No app open ad available or already showing';
  static const String appOpenAdShowing = '📱 Showing app open ad';
  static const String appOpenAdShowed = '✅ App open ad showed';
  static const String appOpenAdDismissed = '📱 App open ad dismissed';
  static const String appOpenAdFailedToShow = '❌ App open ad failed to show: ';

  // Interstitial Ad
  static const String interstitialAdDisabled = '🚫 Ads are disabled, skipping interstitial ad loading';
  static const String interstitialAdLoading = '🎯 Loading interstitial ad with unit ID: ';
  static const String interstitialAdLoaded = '✅ Interstitial ad loaded successfully!';
  static const String interstitialAdFailedToLoad = '❌ Interstitial ad failed to load: ';
  static const String interstitialAdShowDisabled = '🚫 Ads are disabled, skipping interstitial ad show';
  static const String interstitialAdNoAvailable = '⚠️ No interstitial ad available, loading new one...';
  static const String interstitialAdShowing = '📱 Showing interstitial ad';
  static const String interstitialAdShowed = '✅ Interstitial ad showed';
  static const String interstitialAdDismissed = '📱 Interstitial ad dismissed';
  static const String interstitialAdFailedToShow = '❌ Interstitial ad failed to show: ';

  // Native Ad
  static const String nativeAdDisabled = '🚫 Ads are disabled, skipping native ad loading';
  static const String nativeAdLoading = '🎯 Loading native ad with unit ID: ';
  static const String nativeAdLoaded = '✅ Native ad loaded successfully!';
  static const String nativeAdFailedToLoad = '❌ Native ad failed to load: ';
  static const String nativeAdOpened = '📱 Native ad opened';
  static const String nativeAdClosed = '📱 Native ad closed';
  static const String nativeAdLoadingProgress = '🔄 Native ad loading...';

  static const String firebaseFetchingAdsConfig = '🔥 Firebase: Fetching ads config from reminders_app_config/reminders_ads_config';
  static const String firebaseDocumentExists = '🔥 Firebase: Document exists: ';
  static const String firebaseAvailableKeys = 'Firebase: Available keys: ';
  static const String firebaseAdsEnabledFound = 'Firebase: isAdsEnabled field found: ';
  static const String firebaseAdsEnabledNotFound = 'Firebase: isAdsEnabled field not found, defaulting to true';
  static const String firebaseDataIsNull = 'Firebase: Data is null, defaulting to true';
  static const String firebaseAdsFetched = 'Firebase: Ads config fetched - isAdsEnabled: ';
  static const String firebaseDocNotExist = 'Firebase: Document does not exist, creating default';
  static const String firebaseCreatedDefault = 'Firebase: Created default ads config - isAdsEnabled: true';
  static const String firebaseErrorFetching = 'Firebase: Error fetching ads config: ';
  static const String firebaseStartingListener = 'Firebase: Starting real-time ads config listener';
  static const String firebaseRealTimeUpdate = 'Firebase: Real-time update received';
  static const String firebaseRealTimeData = 'Firebase: Real-time data: ';
  static const String firebaseConfigUnchanged = 'Firebase: Ads config unchanged, no update needed';
  static const String firebaseRealTimeDataNull = 'Firebase: Real-time data is null';
  static const String firebaseRealTimeDocNotExist = 'Firebase: Real-time update: document does not exist';
  static const String firebaseListenerError = 'Firebase: Error in ads config listener: ';
  static const String firebaseStoppedListener = 'Firebase: Stopped ads config listener';


  static const String loadingExistingData = 'Loading existing data: name=';
  static const String loadedExistingImage = 'Loaded existing image: ';
  static const String imageFileNotExist = 'Image file does not exist: ';
  static const String errorLoadingImage = 'Error loading image: ';
  static const String audioFileNotExist = 'Audio file does not exist: ';
  static const String errorCheckingAudio = 'Error checking audio file: ';
  static const String errorPickPhoto = 'Failed to pick photo: ';
  static const String errorPickAudio = 'Failed to pick audio file: ';
  static const String errorNoAudio = 'Please import audio first';
  static const String errorNoImage = 'Please add image to save';
  static const String errorNoAudioName = 'Please enter audio name';
  static const String errorRecordNotFound = 'Record not found';
  static const String errorMetadataNotFound = 'Metadata file not found';
  static const String updatedImageFile = 'Updated image file: ';
  static const String updatedAudioFile = 'Updated audio file: ';
  static const String updatedMetadata = 'Updated metadata: ';
  static const String successRecordUpdated = 'Record updated successfully!';
  static const String errorUpdateRecord = 'Failed to update record: ';
  static const String errorUpdateRecordLog = 'Error updating record: ';
  static const String savingToDirectory = 'Saving to directory: ';
  static const String createdCustomSoundsDir = 'Created custom_sounds directory';
  static const String createdRecordDir = 'Created record directory: ';
  static const String savedAudioFile = 'Saved audio file: ';
  static const String savedImageFile = 'Saved image file: ';
  static const String savedMetadataFile = 'Saved metadata file: ';
  static const String metadataContent = 'Metadata content: ';
  static const String successRecordSaved = 'Record saved successfully!';
  static const String errorSaveRecord = 'Failed to save record: ';
  static const String labelError = 'Error';
  static const String labelSuccess = 'Success';

  // ─── Add Custom View ──────────────────────────────────────────────────────────
  static const String editSound = 'Edit Sound';
  static const String addCustomSound = 'Add Custom Sound';
  static const String clickToAddPhoto = 'Click to add photo';
  static const String importAudio = 'Import Audio';
  static const String playSound = 'Play Sound';
  static const String saveRecord = 'Save Record';

// ─── Category View ────────────────────────────────────────────────────────────
  static const String selectCategories = 'Select Categories';
  static const String selected = 'Selected';
  static const String tapToStart = 'Tap to Start';

  // ─── Category Controller ──────────────────────────────────────────────────────
  static const String errorLoadingSavedCategories = 'Error loading saved categories: ';
  static const String errorStartingApp = 'Error starting app: ';
  static const String prefKeySelectedCategories = 'selected_categories';

  // ─── Category Names ───────────────────────────────────────────────────────────
  static const String categoryFunny = 'Funny';
  static const String categoryScary = 'Scary';
  static const String categoryAnimal = 'Animal';
  static const String categoryMusic = 'Music';
  static const String categoryVoice = 'Voice';
  static const String categorySiren = 'Siren';
  static const String categoryFart = 'Fart';
  static const String categoryBurp = 'Burp';
  static const String categoryAlarm = 'Alarm';
  static const String categoryDoorbell = 'Doorbell';
  static const String categoryPhone = 'Phone';
  static const String categoryCar = 'Car';

  // ─── Collections View ─────────────────────────────────────────────────────────
  static const String collectionsAppTitle = 'Funny Prank Sounds';
  static const String collectionsAppSubtitle = 'Joke Goes BOOM!';
  static const String collectionsNoSoundsTitle = 'No custom sounds yet';
  static const String collectionsNoSoundsSubtitle = 'Create your first custom sound!';
  static const String collectionsCreateSound = 'Create Sound';
  static const String collectionsUnknownSound = 'Unknown Sound';
  static const String collectionsUnknownDate = 'Unknown date';
  static const String collectionsToday = 'Today';
  static const String collectionsYesterday = 'Yesterday';
  static const String collectionsDaysAgo = 'days ago';
  static const String collectionsMenuPlaySound = 'Play Sound';
  static const String collectionsMenuEdit = 'Edit';
  static const String collectionsMenuDelete = 'Delete';
  static const String collectionsDeleteTitle = 'Delete Custom Sound';
  static const String collectionsDeleteCancel = 'Cancel';
  static const String collectionsDeleteConfirm = 'Delete';

  // ─── Collections Controller ───────────────────────────────────────────────────
  static const String errorLoadCustomSounds = 'Failed to load custom sounds: ';
  static const String successSoundDeleted = 'Custom sound deleted successfully';
  static const String errorDeleteCustomSound = 'Failed to delete custom sound: ';
  static const String playingCustomSound = 'Playing custom sound';
  static const String labelPlaying = 'Playing';

  // ─── Favorite Controller ──────────────────────────────────────────────────────
  static const String prefKeyFavoriteSounds = 'favorite_sounds';
  static const String favoriteInterstitialLoaded = 'Favorite Interstitial ad loaded successfully';
  static const String favoriteInterstitialShowed = 'Interstitial ad showed full screen content';
  static const String favoriteInterstitialDismissed = 'Interstitial ad dismissed';
  static const String favoriteInterstitialFailedToShow = 'Interstitial ad failed to show: ';
  static const String favoriteInterstitialImpression = 'Interstitial ad impression recorded';
  static const String favoriteInterstitialFailedToLoad = 'Interstitial ad failed to load: ';
  static const String favoriteRemovedTitle = 'Removed from Favorites';
  static const String favoriteRemovedBody = 'Sound has been removed from your favorites';
  static const String favoriteAddedTitle = 'Added to Favorites';
  static const String favoriteAddedBodySuffix = ' has been added to your favorites';
  static const String favoriteAlreadyTitle = 'Already in Favorites';
  static const String favoriteAlreadyBodySuffix = ' is already in your favorites';

  // ─── Favorite View ────────────────────────────────────────────────────────────
  static const String favoritesTitle = 'Favorites';
  static const String favoritesEmptyTitle = 'No favorite sounds yet';
  static const String favoritesEmptySubtitle = 'Tap the heart icon to add sounds';


  // ─── Feedback View ────────────────────────────────────────────────────────────
  static const String feedbackTitle = 'Feedback';
  static const String feedbackValueTitle = 'We Value Your Feedback';
  static const String feedbackSubtitle = 'Help us improve the app by sharing your thoughts';
  static const String feedbackCategoryLabel = 'Category';
  static const String feedbackYourFeedbackLabel = 'Your Feedback';
  static const String feedbackHintText = 'Tell us what you think...';
  static const String feedbackSubmitting = 'Submitting...';
  static const String feedbackSubmitButton = 'Submit Feedback';
  static const String feedbackThankYouTitle = 'Thank You!';
  static const String feedbackThankYouBody =
      'Your feedback has been submitted successfully!\n'
      'We appreciate your time and will use your feedback to improve the app.';
  static const String feedbackCloseButton = 'Close';

  // ─── Feedback Controller ──────────────────────────────────────────────────────
  static const String feedbackCategoryGeneral = 'General';
  static const String feedbackCategoryBugReport = 'Bug Report';
  static const String feedbackCategoryFeatureRequest = 'Feature Request';
  static const String feedbackCategorySoundQuality = 'Sound Quality';
  static const String feedbackCategoryUserInterface = 'User Interface';
  static const String feedbackCategoryOther = 'Other';
  static const String feedbackErrorEmpty = 'Please enter your feedback';
  static const String feedbackErrorEmailApp = 'Could not open email app';
  static const String feedbackErrorSubmit = 'Failed to submit feedback: ';
  static const String feedbackEmailPath = 'support@pranksoundapp.com';
  static const String feedbackEmailSubjectPrefix = 'Feedback - ';
  static const String feedbackDeviceAndroid = 'Android';
  static const String feedbackDeviceIos = 'iOS';

  // ─── Home View ────────────────────────────────────────────────────────────────
  static const String homeAppTitle = 'Funny Prank Sounds';
  static const String homeAppSubtitle = 'Joke Goes BOOM!';
  static const String homeSearchHint = 'Search sounds...';
  static const String homeLoadingAd = 'Loading ad...';
  static const String homeNoResults = 'No results found';
  static const String homeAddCustom = 'Add Custom';
  static const String homeSectionSounds = 'Sounds';
  static const String homeSectionCategories = 'Categories';
  static const String homeSoundsCount = 'sounds';

  // ─── Home Controller ──────────────────────────────────────────────────────────
  static const String homeBannerAdLoaded = 'Banner ad loaded successfully';
  static const String homeBannerAdFailed = 'Banner ad failed to load: ';
  static const String homeBannerAdOpened = 'Banner ad opened';
  static const String homeBannerAdClosed = 'Banner ad closed';
  static const String homeBannerAdImpression = 'Banner ad impression';
  static const String homeInterstitialLoaded = 'Interstitial ad loaded successfully';
  static const String homeInterstitialShowed = 'Interstitial ad showed full screen content';
  static const String homeInterstitialDismissed = 'Interstitial ad dismissed';
  static const String homeInterstitialFailedToShow = 'Interstitial ad failed to show: ';
  static const String homeInterstitialImpression = 'Interstitial ad impression recorded';
  static const String homeInterstitialFailedToLoad = 'Interstitial ad failed to load: ';
  static const String homeErrorLoadingCategories = 'Error loading selected categories: ';

  // ─── Home Sound / Category Names ─────────────────────────────────────────────
  static const String soundFart = 'Fart Sound';
  static const String soundDogBark = 'Dog Bark';
  static const String soundPoliceSiren = 'Police Siren';
  static const String soundGhost = 'Ghost Sound';
  static const String soundCategoryFunny = 'funny';
  static const String soundCategoryAnimal = 'animal';
  static const String soundCategorySiren = 'siren';
  static const String soundCategoryScary = 'scary';

  // ─── Language View ─────────────────────────────────────────────────────────────
  static const String languageSelectAppLanguage = 'Select App Language';

  // ─── Onboarding Controller ─────────────────────────────────────────────────────
  static const String onboardingCompleted = '✅ Onboarding completed - First time flag set to false';

  // ─── Onboarding View ───────────────────────────────────────────────────────────
  static const String onboardingSkip = 'Skip';
  static const String onboardingNext = 'Next';
  static const String onboardingSelectCategory = 'Select Category';
  static const String onboardingWelcomeTitle = 'Welcome to the Fun Side!';
  static const String onboardingWelcomeSubtitle = 'Get ready to prank, laugh, and surprise your friends!';
  static const String onboardingBoredTitle = 'Are you Feeling Bored?';
  static const String onboardingBoredSubtitle = 'Be honest. If your life needs more chaos, we\'ve got your back.';
  static const String onboardingPrankTitle = 'Time to Prank!';
  static const String onboardingPrankSubtitle = 'Choose from hundreds of hilarious sounds and prank your friends. Laughter guaranteed!';


  // ─── Trending View ────────────────────────────────────────────────────────────
  static const String trendingTitle = 'Trending Sounds';
  static const String trendingSearchHint = 'Search trending sounds...';
  static const String trendingNoResults = 'No results found';

  // ─── Trending Category Names ──────────────────────────────────────────────────
  static const String trendingCategoryFunny = 'Trending Funny';
  static const String trendingCategoryScary = 'Trending Scary';
  static const String trendingCategorySiren = 'Trending Siren';
  static const String trendingCategoryMusic = 'Trending Music';
  static const String trendingCategoryAnimal = 'Trending Animal';

  // ─── Trending Sound Names ─────────────────────────────────────────────────────
  static const String trendingSoundViralLaugh = 'Viral Laugh';
  static const String trendingSoundPopularDogBark = 'Popular Dog Bark';
  static const String trendingSoundTrendingSiren = 'Trending Siren';
  static const String trendingSoundHotScarySound = 'Hot Scary Sound';
  static const String trendingSoundHairClipper = 'Hair Clipper 5';
  static const String trendingSoundScary1 = 'Scary 1';
  static const String trendingSoundScary6 = 'Scary 6';
  static const String trendingSoundScary7 = 'Scary 7';
  static const String trendingSoundPoliceSiren7 = 'Police Siren 7';
  static const String trendingSoundGun6 = 'Gun 6';
  static const String trendingSoundHalloween1 = 'Halloween 1';

  // ─── Trending Sound Categories ────────────────────────────────────────────────
  static const String trendingCatFunny = 'funny';
  static const String trendingCatAnimal = 'animal';
  static const String trendingCatSiren = 'siren';
  static const String trendingCatScary = 'scary';
  static const String trendingCatTools = 'tools';
  static const String trendingCatAction = 'action';
  static const String trendingCatHalloween = 'halloween';

  // ─── Trending Controller Logs ─────────────────────────────────────────────────
  static const String trendingInterstitialLoaded = 'Trending Interstitial ad loaded successfully';
  static const String trendingInterstitialShowed = 'Interstitial ad showed full screen content';
  static const String trendingInterstitialDismissed = 'Interstitial ad dismissed';
  static const String trendingInterstitialFailedToShow = 'Interstitial ad failed to show: ';
  static const String trendingInterstitialImpression = 'Interstitial ad impression recorded';
  static const String trendingInterstitialFailedToLoad = 'Interstitial ad failed to load: ';

  // ─── Routes ───────────────────────────────────────────────────────────────────
  static const String routeSettings = '/settings';
  static const String routeVip = '/vip';
  static const String routeSoundPlayer = '/sound_player';

  // ─── Sound Durations ──────────────────────────────────────────────────────────
  static const String duration2s = '0:02';
  static const String duration3s = '0:03';
  static const String duration4s = '0:04';
  static const String duration5s = '0:05';
  static const String duration6s = '0:06';
  static const String duration8s = '0:08';

  // ─── Trending Category IDs ────────────────────────────────────────────────────
  static const String trendingIdFunny = 'trending_funny';
  static const String trendingIdScary = 'trending_scary';
  static const String trendingIdSiren = 'trending_siren';
  static const String trendingIdMusic = 'trending_music';
  static const String trendingIdAnimal = 'trending_animal';

  // ─── Map Keys ─────────────────────────────────────────────────────────────────
  static const String mapKeyName = 'name';
  static const String mapKeyIcon = 'icon';
  static const String mapKeyCategory = 'category';

// ─── Theme ─────────────────────────────────────────────────────────────────
  static const String theme = 'Theme';
  static const String chooseTheme = 'Choose Theme';
  static const String selectyourpreferredthemeappearance = 'Select your preferred theme appearance';

  // ─── Sound Player View ────────────────────────────────────────────────────────
  static const String soundPlayerPlayInBackground = 'Play In Background';
  static const String soundPlayerLoop = 'Loop';
  static const String soundPlayerMoreSounds = 'More Sounds';
  static const String soundPlayerVolume = 'Volume';
  static const String soundPlayerDefaultImage = 'assets/images/default_sound.jpg';

  // ─── Settings View ────────────────────────────────────────────────────────────
  static const String settingsTitle = 'Settings';
  static const String settingsSectionGeneral = 'General';
  static const String settingsSectionMode = 'Mode';
  static const String settingsSectionOthers = 'Others';
  static const String settingsAppLanguage = 'App Language';
  static const String settingsAppLanguageSubtitle = '(English)';
  static const String settingsDarkMode = 'Dark Mode';
  static const String settingsDarkModeSubtitle = 'Let the night inspire your screen';
  static const String settingsRateUs = 'Rate Us';
  static const String settingsRateUsSubtitle = 'Share your experience';
  static const String settingsShare = 'Share';
  static const String settingsShareSubtitle = 'Share app with your friends';
  static const String settingsFeedback = 'Feedback';
  static const String settingsFeedbackSubtitle = 'Add your suggestions';
  static const String settingsPrivacyPolicy = 'Privacy Policy';
  static const String settingsPrivacyPolicySubtitle = 'Read how we protect you';
  static const String settingsVersion = 'Version';
  static const String settingsVersionNumber = '1.0.14';
  static const String settingsShareMessage =
      'Check out this amazing prank sound app! 🎵\n\n'
      'Download now and enjoy tons of hilarious sound effects for your pranks!\n\n'
      '🔥 Features:\n'
      '• Hundreds of prank sounds\n'
      '• Custom sound recording\n'
      '• High-quality audio\n'
      '• Easy to use interface\n\n'
      'Get it now and start pranking your friends! 😂\n\n'
      '#PrankSounds #SoundEffects #Fun';
  static const String settingsShareSubject = 'Amazing Prank Sound App';
  static const String settingsShareError = 'Error';
  static const String settingsShareErrorMsg = 'Failed to share app: ';

  // ─── Splash View ─────────────────────────────────────────────────────────────
  static const String splashAppName = 'Laugh';
  static const String splashAppSubtitle = 'Prank Sound';
  static const String splashLogoPath = 'assets/images/pranks_logo.png';

  // ─── Rate Us View ─────────────────────────────────────────────────────────────
  static const String rateUsTitle = 'Rate Us';
  static const String rateUsEnjoyingTitle = 'Enjoying the App?';
  static const String rateUsSubtitle = 'Your feedback helps us improve the app';
  static const String rateUsSubmitButton = 'Submit';
  static const String rateUsMaybeLater = 'Maybe Later';
  static const String rateUsThankYouTitle = 'Thank You!';
  static const String rateUsThankYouHigh =
      'We\'re glad you\'re enjoying the app!\nYour rating means a lot to us.';
  static const String rateUsThankYouLow =
      'Thank you for your feedback!\nWe\'ll work on improving the app.';
  static const String rateUsCloseButton = 'Close';
  static const String rateUsPoor = 'Poor';
  static const String rateUsFair = 'Fair';
  static const String rateUsGood = 'Good';
  static const String rateUsVeryGood = 'Very Good';
  static const String rateUsExcellent = 'Excellent';
  static const String rateUsTapToRate = 'Tap to rate';

  // ─── Privacy Policy View ──────────────────────────────────────────────────────
  static const String privacyPolicyTitle = 'Privacy Policy';
  static const String privacyPolicyLastUpdated = 'Last Updated: April 30, 2026';
  static const String privacyPolicyIntroTitle = 'Introduction';
  static const String privacyPolicyIntroBody =
      'Welcome to Prank Sound App! We respect your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and protect your information when you use our app.';
  static const String privacyPolicyInfoTitle = 'Information We Collect';
  static const String privacyPolicyInfoBody =
      '• **Audio Files**: When you create custom sounds, we store them locally on your device\n'
      '• **Images**: When you add images to sounds, we store them locally on your device\n'
      '• **App Usage**: Basic usage data to improve the app experience\n'
      '• **Device Information**: OS version, device model for compatibility purposes';
  static const String privacyPolicyUseTitle = 'How We Use Your Information';
  static const String privacyPolicyUseBody =
      '• **To Provide Services**: Store and manage your custom sounds\n'
      '• **To Improve the App**: Analyze usage patterns to enhance features\n'
      '• **To Ensure Compatibility**: Device info for optimal performance\n'
      '• **To Fix Bugs**: Error reports to improve app stability';
  static const String privacyPolicyStorageTitle = 'Data Storage & Security';
  static const String privacyPolicyStorageBody =
      '• **Local Storage**: All your custom sounds and images are stored locally on your device\n'
      '• **No Cloud Upload**: We do not upload your personal content to our servers\n'
      '• **Secure Storage**: Data is encrypted and protected by device security\n'
      '• **No Third-Party Sharing**: We never share your personal content with third parties';
  static const String privacyPolicyPermissionsTitle = 'Permissions We Request';
  static const String privacyPolicyPermissionsBody =
      '• **Microphone**: For recording custom sounds (optional)\n'
      '• **Storage**: To save and access your custom sounds and images\n'
      '• **Internet**: For ads and app updates (optional)\n'
      '• **Vibration**: For enhanced sound effects (optional)';
  static const String privacyPolicyAdsTitle = 'Analytics & Advertising';
  static const String privacyPolicyAdsBody =
      '• **Anonymous Analytics**: We collect anonymous usage data to improve the app\n'
      '• **Personalized Ads**: Ads may be personalized based on your interests\n'
      '• **No Personal Data**: We never use your personal content for advertising\n'
      '• **Opt-Out**: You can opt out of personalized ads in device settings';
  static const String privacyPolicyRightsTitle = 'Your Rights';
  static const String privacyPolicyRightsBody =
      '• **Access**: You can access all your custom sounds anytime\n'
      '• **Delete**: You can delete any custom sound you created\n'
      '• **Export**: You can export your custom sounds\n'
      '• **Opt-Out**: You can opt out of analytics and personalized ads';
  static const String privacyPolicyChildrenTitle = 'Children\'s Privacy';
  static const String privacyPolicyChildrenBody =
      'Our app is suitable for users of all ages. We do not knowingly collect personal information from children under 13. If you believe we have collected such information, please contact us immediately.';
  static const String privacyPolicyChangesTitle = 'Changes to This Policy';
  static const String privacyPolicyChangesBody =
      'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new policy in the app and updating the "Last Updated" date.';
  static const String privacyPolicyContactTitle = 'Contact Us';
  static const String privacyPolicyContactBody =
      'If you have any questions about this Privacy Policy or our data practices, please contact us:\n\n'
      '📧 Email: privacy@pranksoundapp.com\n'
      '🌐 Website: www.pranksoundapp.com/privacy\n\n'
      'We will respond to your inquiry within 30 days.';

  // ─── Snackbar / Dialog Common ─────────────────────────────────────────────────
  static const String snackbarAlreadyInFavTitle = 'Already in Favorites';
  static const String snackbarAlreadyInFavBody = 'This sound is already in your favorites';

  // ─── Premium View ────────────────────────────────────────────────────────────
  static const String premiumTitle = 'Premium';
  static const String premiumGoPremium = 'Go Premium';
  static const String premiumSubtitle = 'Unlock all features and remove ads';
  static const String premiumFeatureAdFree = '✨ Ad-Free';
  static const String premiumFeatureHdAudio = '🎵 HD Audio';
  static const String premiumFeaturePremium = '⭐ Premium';
  static const String premiumBenefits = 'Premium Benefits';
  static const String premiumRemoveAllAds = 'Remove All Ads';
  static const String premiumRemoveAllAdsDesc = 'Enjoy ad-free experience';
  static const String premiumUnlimitedFavorites = 'Unlimited Favorites';
  static const String premiumUnlimitedFavoritesDesc = 'Save unlimited favorite sounds';
  static const String premiumHdSoundQuality = 'HD Sound Quality';
  static const String premiumHdSoundQualityDesc = 'Access high-quality audio';
  static const String premiumExclusiveSounds = 'Exclusive Sounds';
  static const String premiumExclusiveSoundsDesc = 'Get premium-only sounds';
  static const String premiumPrioritySupport = 'Priority Support';
  static const String premiumPrioritySupportDesc = 'Get faster customer support';
  static const String premiumChooseYourPlan = 'Choose Your Plan';
  static const String premiumPopular = 'POPULAR';
  static const String premiumProcessing = 'Processing...';
  static const String premiumPurchasePremium = 'Purchase Premium';
  static const String premiumRestorePurchase = 'Restore Purchase';

  // ─── Prank Call View ──────────────────────────────────────────────────────────
  static const String prankCallTitle = 'Prank Call';
  static const String prankCallAdLabel = 'Ad';
  static const String prankCallAdTitle = 'REAL CRICK...';
  static const String prankCallAdSubtitle = 'LOOKS REAL...';
  static const String prankCallAdCta = 'DOWNLOAD NOW';

  // ─── Incoming Call View ────────────────────────────────────────────────────────
  static const String incomingCallTitle = 'Incoming Call';
  static const String incomingCallDecline = 'Decline';
  static const String incomingCallAccept = 'Accept';
  static const String incomingCallUnknown = 'Unknown';


}