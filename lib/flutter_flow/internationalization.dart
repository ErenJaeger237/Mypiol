import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'fr'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? frText = '',
  }) =>
      [enText, frText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // login
  {
    'rqgzrtvc': {
      'en': 'Welcome Back,',
      'fr': '',
    },
    'bfanwv6c': {
      'en': 'Email Address',
      'fr': '',
    },
    'es8h8sf8': {
      'en': 'Enter your email here...',
      'fr': '',
    },
    'chqsoxkc': {
      'en': 'Password',
      'fr': '',
    },
    'liaewqaa': {
      'en': 'Enter your email here...',
      'fr': '',
    },
    'o3764vra': {
      'en': 'Forgot Password?',
      'fr': '',
    },
    'ggovovrq': {
      'en': 'Login',
      'fr': '',
    },
    '601gklwh': {
      'en': 'Don\'t have an account?',
      'fr': '',
    },
    '6lfl0mp1': {
      'en': 'Create Account',
      'fr': '',
    },
    'ytv9sl16': {
      'en': 'Home',
      'fr': '',
    },
  },
  // createAccount
  {
    '0v8ts5ti': {
      'en': 'Get Started Below,',
      'fr': '',
    },
    '2524gaeh': {
      'en': 'Email Address',
      'fr': '',
    },
    'gwv4rr5q': {
      'en': 'Enter your email here...',
      'fr': '',
    },
    '81fazdey': {
      'en': 'Password',
      'fr': '',
    },
    '16ajs3s3': {
      'en': 'Enter your email here...',
      'fr': '',
    },
    '4ijhzkv6': {
      'en': 'Create Account',
      'fr': '',
    },
    'xh4ondm7': {
      'en': 'Already have an account?',
      'fr': '',
    },
    'gtd52sxd': {
      'en': 'Login',
      'fr': '',
    },
    'vn2634pk': {
      'en': 'Home',
      'fr': '',
    },
  },
  // homePage_MAIN
  {
    '0toiv0pc': {
      'en': 'Welcome!',
      'fr': '',
    },
    'ebk1muka': {
      'en': 'Address, city...',
      'fr': '',
    },
    'inkn7niw': {
      'en': 'Search',
      'fr': '',
    },
    'yro2dsw0': {
      'en': 'Rating',
      'fr': '',
    },
    'q1x85q9v': {
      'en': 'Home',
      'fr': '',
    },
  },
  // propertyDetails
  {
    'gr7xndyl': {
      'en': 'Reviews',
      'fr': '',
    },
    'be24z8vp': {
      'en': 'DESCRIPTION',
      'fr': '',
    },
    'd0ba4984': {
      'en': 'Amenities',
      'fr': '',
    },
    'o0j3nxvn': {
      'en': 'What people are saying',
      'fr': '',
    },
    '8qhl60gr': {
      'en': 'Josh Richardson',
      'fr': '',
    },
    'r5gbphwl': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
      'fr': '',
    },
    'no615fks': {
      'en': 'Josh Richardson',
      'fr': '',
    },
    'unbwb5ja': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
      'fr': '',
    },
    'vg9kzkzf': {
      'en': '\$156',
      'fr': '',
    },
    'tg8lj6js': {
      'en': '+ taxes/fees',
      'fr': '',
    },
    'w7754s79': {
      'en': 'per night',
      'fr': '',
    },
    'e1lg573k': {
      'en': 'Book Now',
      'fr': '',
    },
    'm0re4g6t': {
      'en': 'Home',
      'fr': '',
    },
  },
  // searchProperties
  {
    'ah7gfjf4': {
      'en': 'Search',
      'fr': '',
    },
    '73kmvngk': {
      'en': 'Address, city, state...',
      'fr': '',
    },
    'vc7i48no': {
      'en': 'Search',
      'fr': '',
    },
    'elp54pet': {
      'en': 'Rating',
      'fr': '',
    },
    'kln4qn8m': {
      'en': 'Home',
      'fr': '',
    },
  },
  // myTrips
  {
    '3k22oum6': {
      'en': 'Upcoming',
      'fr': '',
    },
    '6bj0w1t1': {
      'en': ' - ',
      'fr': '',
    },
    'mi90gg1h': {
      'en': 'Total',
      'fr': '',
    },
    '7zypxfbu': {
      'en': 'Completed',
      'fr': '',
    },
    'bbbpfqeo': {
      'en': 'Cancelled',
      'fr': '',
    },
    'jx9trb2l': {
      'en': ' - ',
      'fr': '',
    },
    '0ko8tduh': {
      'en': 'Rate Trip',
      'fr': '',
    },
    'b2qhbidd': {
      'en': 'My Trips',
      'fr': '',
    },
    'fblutesr': {
      'en': 'My Trips',
      'fr': '',
    },
  },
  // tripDetails
  {
    's3fytamy': {
      'en': 'Trip Details',
      'fr': '',
    },
    'xvwyci4r': {
      'en': 'Dates of trip',
      'fr': '',
    },
    'xr6z9f97': {
      'en': ' - ',
      'fr': '',
    },
    'zxjxmute': {
      'en': 'Destination',
      'fr': '',
    },
    'd1eczpf9': {
      'en': 'Price Breakdown',
      'fr': '',
    },
    '0v2zq3s8': {
      'en': 'Base Price',
      'fr': '',
    },
    'jv7miskq': {
      'en': 'Taxes',
      'fr': '',
    },
    'xgo7hfig': {
      'en': '\$24.20',
      'fr': '',
    },
    'w0khtgdw': {
      'en': 'Cleaning Fee',
      'fr': '',
    },
    'ezq1xrmj': {
      'en': '\$40.00',
      'fr': '',
    },
    'nzbxoitm': {
      'en': 'Total',
      'fr': '',
    },
    'qg9c6upo': {
      'en': 'Your trip has been completed!',
      'fr': '',
    },
    'mmdy2uvi': {
      'en': 'Review Trip',
      'fr': '',
    },
    'l17myrgh': {
      'en': 'Host Info',
      'fr': '',
    },
    'lmaap774': {
      'en': 'Home',
      'fr': '',
    },
  },
  // propertyReview
  {
    'nk2l4o2a': {
      'en': 'Reviews',
      'fr': '',
    },
    'sujfk63x': {
      'en': '# of Ratings',
      'fr': '',
    },
    'k11dt3gc': {
      'en': 'Avg. Rating',
      'fr': '',
    },
    'q14772fa': {
      'en': 'Home',
      'fr': '',
    },
  },
  // bookNow
  {
    'j9eh6hmj': {
      'en': 'Place an Offer',
      'fr': '',
    },
    'tgl78f8x': {
      'en': 'Choose Dates',
      'fr': '',
    },
    '7fl594xq': {
      'en': 'Number of Guests',
      'fr': '',
    },
    'i326wbhb': {
      'en': 'Choose an Option',
      'fr': '',
    },
    'aly2ltql': {
      'en': '12 months payment',
      'fr': '',
    },
    'ilvln635': {
      'en': '6 months payment',
      'fr': '',
    },
    '1p213o3g': {
      'en': '3 months payment',
      'fr': '',
    },
    'j5mwnyro': {
      'en': 'Payment Information',
      'fr': '',
    },
    'm6b2qa9l': {
      'en': 'Base Price',
      'fr': '',
    },
    'dwgwp504': {
      'en': '\$156.00',
      'fr': '',
    },
    'r4v5ir86': {
      'en': 'Cleaning Fee',
      'fr': '',
    },
    '9ndccrv5': {
      'en': '\$40.00',
      'fr': '',
    },
    'dp43qcvm': {
      'en': 'Total',
      'fr': '',
    },
    'e4r72kq1': {
      'en': '\$230.20',
      'fr': '',
    },
    '9vthnxbf': {
      'en': 'Book Now',
      'fr': '',
    },
    'zzgrk8tv': {
      'en': 'Home',
      'fr': '',
    },
  },
  // profilePage
  {
    'i9ka06lv': {
      'en': 'Switch to Dark Mode',
      'fr': '',
    },
    'c6v02eyp': {
      'en': 'Switch to Light Mode',
      'fr': '',
    },
    'wygkucd0': {
      'en': 'Account Details',
      'fr': '',
    },
    'un5y1dp8': {
      'en': 'Edit Profile',
      'fr': '',
    },
    '51m80789': {
      'en': 'Payment Information',
      'fr': '',
    },
    'lyku8zwl': {
      'en': 'Change Password',
      'fr': '',
    },
    'efm8i6di': {
      'en': 'My Properties',
      'fr': '',
    },
    'kpygc9x5': {
      'en': 'My Bookings',
      'fr': '',
    },
    'c8cxeh2c': {
      'en': 'Log Out',
      'fr': '',
    },
    'ghxcxx4i': {
      'en': 'Add Property',
      'fr': '',
    },
    'g6ez661l': {
      'en': 'Profile',
      'fr': '',
    },
  },
  // paymentInfo
  {
    'af5meie1': {
      'en': 'Save Changes',
      'fr': '',
    },
    'gp2swx3o': {
      'en': 'Payment Information',
      'fr': '',
    },
    'k0v560v7': {
      'en': 'Home',
      'fr': '',
    },
  },
  // editProfile
  {
    '3vj25wo1': {
      'en': 'Edit Profile',
      'fr': '',
    },
    '9kqci4wx': {
      'en': 'Change Photo',
      'fr': '',
    },
    '94azn6sx': {
      'en': 'Full Name',
      'fr': '',
    },
    '4486ru9i': {
      'en': 'Your full name...',
      'fr': '',
    },
    'no000d69': {
      'en': 'Email Address',
      'fr': '',
    },
    '8h509vw9': {
      'en': 'Your email..',
      'fr': '',
    },
    'h1pokjow': {
      'en': 'Bio',
      'fr': '',
    },
    '9kcab1a6': {
      'en': 'A little about you...',
      'fr': '',
    },
    'wdfyplaa': {
      'en': 'Save Changes',
      'fr': '',
    },
    'mm8x9dcj': {
      'en': 'Home',
      'fr': '',
    },
  },
  // changePassword
  {
    '9lzqnpfu': {
      'en': 'Email Address',
      'fr': '',
    },
    'fv637y90': {
      'en': 'Your email..',
      'fr': '',
    },
    'hl42jo2h': {
      'en':
          'We will send you an email with a link to reset your password, please enter the email associated with your account above.',
      'fr': '',
    },
    'z38414n4': {
      'en': 'Send Reset Link',
      'fr': '',
    },
    '5zt50yep': {
      'en': 'Change Password',
      'fr': '',
    },
    'u6wur71m': {
      'en': 'Home',
      'fr': '',
    },
  },
  // createProperty_1
  {
    '79s7ix20': {
      'en': 'PROPERTY NAME',
      'fr': '',
    },
    'tnbghi08': {
      'en': 'HOW IS IT CALLED',
      'fr': '',
    },
    'z6ad4548': {
      'en': 'Location',
      'fr': '',
    },
    'm5dcdwk4': {
      'en': 'Yaounde,douala...',
      'fr': '',
    },
    'mvn3xwi6': {
      'en': 'NEIGHBORHOOD',
      'fr': '',
    },
    'd2opyc4m': {
      'en': 'Messasi,Essos...',
      'fr': '',
    },
    '8ppkdet0': {
      'en': 'DESCRIPTION',
      'fr': '',
    },
    'epmbwn16': {
      'en': 'Neighborhood or city…',
      'fr': '',
    },
    'j8fal24m': {
      'en': 'STEP',
      'fr': '',
    },
    '91fjos6r': {
      'en': '1/3',
      'fr': '',
    },
    '65t7mdx6': {
      'en': 'NEXT',
      'fr': '',
    },
    '3xac5xvp': {
      'en': 'Create Property',
      'fr': '',
    },
    'zjlkw1j4': {
      'en': 'Home',
      'fr': '',
    },
  },
  // HomePage_ALT
  {
    '0jxfse5v': {
      'en': 'Welcome!',
      'fr': '',
    },
    'iddmidim': {
      'en': 'Find your Dream Space',
      'fr': '',
    },
    'afq57oza': {
      'en': 'Address, city, state...',
      'fr': '',
    },
    'g5ie4rs6': {
      'en': 'Search',
      'fr': '',
    },
    'teqdz7k8': {
      'en': '4/5 reviews',
      'fr': '',
    },
    'cet8j0jo': {
      'en': 'Home',
      'fr': '',
    },
  },
  // createProperty_2
  {
    'i41qcd4m': {
      'en': 'Create Property',
      'fr': '',
    },
    '32h9yt6l': {
      'en': 'CHOOSE YOUR AMENITIES',
      'fr': '',
    },
    '80li6cu2': {
      'en': 'Pool',
      'fr': '',
    },
    'f25tw8h2': {
      'en': 'EV Car Charging',
      'fr': '',
    },
    'v38ca1jp': {
      'en': 'Extra Outlets',
      'fr': '',
    },
    'ijjqcxc8': {
      'en': 'Air Conditioning (AC)',
      'fr': '',
    },
    'cyviu5y1': {
      'en': 'Heating',
      'fr': '',
    },
    'ilrryi2d': {
      'en': 'Washer',
      'fr': '',
    },
    'a8sit5rh': {
      'en': 'Dryer',
      'fr': '',
    },
    'ydqetfli': {
      'en': 'Pet Friendly',
      'fr': '',
    },
    'vfa2zhk8': {
      'en': 'Workout Facility',
      'fr': '',
    },
    'nma74i5x': {
      'en': 'STEP',
      'fr': '',
    },
    'ulgfo6iv': {
      'en': '2/3',
      'fr': '',
    },
    'ips69hrd': {
      'en': 'NEXT',
      'fr': '',
    },
    'sgultegm': {
      'en': 'Home',
      'fr': '',
    },
  },
  // createProperty_3
  {
    'bk1qfauj': {
      'en': 'Create Property',
      'fr': '',
    },
    'qmmrkd3i': {
      'en': 'PRICE PER MONTH',
      'fr': '',
    },
    'vrvepk0u': {
      'en': 'FCFA Price',
      'fr': '',
    },
    'dygcee9z': {
      'en': 'MINIMUM NIGHT STAY',
      'fr': '',
    },
    'quvcsxqn': {
      'en': 'CLEANING FEE',
      'fr': '',
    },
    'f3jl3hng': {
      'en': 'FCFA Price',
      'fr': '',
    },
    'ue249c3j': {
      'en': 'Additional Notes',
      'fr': '',
    },
    'y8b17i5p': {
      'en': 'Additional notes...',
      'fr': '',
    },
    'wsym9w4x': {
      'en': 'STEP',
      'fr': '',
    },
    '4rwbbsgc': {
      'en': '3/3',
      'fr': '',
    },
    'y44q8s0q': {
      'en': 'PUBLISH',
      'fr': '',
    },
    'hnm8odck': {
      'en': 'Home',
      'fr': '',
    },
  },
  // myProperties
  {
    '2qds3rtp': {
      'en': 'Published',
      'fr': '',
    },
    'dfqezngf': {
      'en': 'Price Per Night',
      'fr': '',
    },
    '9mp3cbfp': {
      'en': 'Drafts',
      'fr': '',
    },
    'q2uy6shl': {
      'en': 'Price Per Night',
      'fr': '',
    },
    'sqclhab6': {
      'en': 'My Properties',
      'fr': '',
    },
    'kwwihhm0': {
      'en': 'My Trips',
      'fr': '',
    },
  },
  // propertyDetails_Owner
  {
    'n60acd8z': {
      'en': 'Reviews',
      'fr': '',
    },
    'pushajnt': {
      'en': 'DESCRIPTION',
      'fr': '',
    },
    'l0l690dd': {
      'en': 'Amenities',
      'fr': '',
    },
    'k7yxgjey': {
      'en': 'What people are saying',
      'fr': '',
    },
    'h2l4z4il': {
      'en': 'Josh Richardson',
      'fr': '',
    },
    '88799tpq': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
      'fr': '',
    },
    'iu20dspe': {
      'en': 'Josh Richardson',
      'fr': '',
    },
    'lymvr1di': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
      'fr': '',
    },
    'kf7gmoqk': {
      'en': '\$156',
      'fr': '',
    },
    'kmdys6k3': {
      'en': '+ taxes/fees',
      'fr': '',
    },
    'engkyhqr': {
      'en': 'per night',
      'fr': '',
    },
    '8ifwhk9y': {
      'en': 'Edit Property',
      'fr': '',
    },
    'h9uxd4vu': {
      'en': 'Home',
      'fr': '',
    },
  },
  // myBookings
  {
    'rw0m85ya': {
      'en': 'Upcoming ',
      'fr': '',
    },
    'jabes6j7': {
      'en': ' - ',
      'fr': '',
    },
    '5n0ksnmo': {
      'en': 'Total',
      'fr': '',
    },
    '1cnyohdx': {
      'en': 'Completed',
      'fr': '',
    },
    '5kb6habt': {
      'en': ' - ',
      'fr': '',
    },
    'szqdc2au': {
      'en': 'Total',
      'fr': '',
    },
    'vdoocfo9': {
      'en': 'My Bookings',
      'fr': '',
    },
    'pwmqmr0h': {
      'en': 'My Trips',
      'fr': '',
    },
  },
  // tripDetailsHOST
  {
    '49mk481j': {
      'en': 'Trip Details',
      'fr': '',
    },
    'eanydtui': {
      'en': 'Dates of trip',
      'fr': '',
    },
    '7chxflrd': {
      'en': ' - ',
      'fr': '',
    },
    'aa3n3ddf': {
      'en': 'Destination',
      'fr': '',
    },
    'a3k3eawo': {
      'en': 'Price Breakdown',
      'fr': '',
    },
    'nhw0xocm': {
      'en': 'Base Price',
      'fr': '',
    },
    '8gomzytf': {
      'en': 'Taxes',
      'fr': '',
    },
    'xq1wp9gf': {
      'en': '\$24.20',
      'fr': '',
    },
    'nzxbc5zq': {
      'en': 'Cleaning Fee',
      'fr': '',
    },
    'dczh5drf': {
      'en': '\$40.00',
      'fr': '',
    },
    '3l0vaj49': {
      'en': 'Total',
      'fr': '',
    },
    'a8oo9jra': {
      'en': 'Mark this trip as complete below.',
      'fr': '',
    },
    '01ji9fj9': {
      'en': 'Mark as Complete',
      'fr': '',
    },
    'vewv441y': {
      'en': 'Guest Info',
      'fr': '',
    },
    '3uhu7fc7': {
      'en': 'Home',
      'fr': '',
    },
  },
  // editProperty_1
  {
    'y43q5n7p': {
      'en': 'Edit Property',
      'fr': '',
    },
    '2bkjca9f': {
      'en': 'PROPERTY NAME',
      'fr': '',
    },
    'ke73ujr5': {
      'en': 'Something Catchy...',
      'fr': '',
    },
    'de1cwufm': {
      'en': 'PROPERTY ADDRESS',
      'fr': '',
    },
    'iv840y68': {
      'en': '123 Disney way here…',
      'fr': '',
    },
    'k6r34ssn': {
      'en': 'NEIGHBORHOOD',
      'fr': '',
    },
    'ufaihoce': {
      'en': 'Neighborhood or city…',
      'fr': '',
    },
    '5u073heu': {
      'en': 'DESCRIPTION',
      'fr': '',
    },
    '5oogqx4w': {
      'en': 'Neighborhood or city…',
      'fr': '',
    },
    '1jjl18c5': {
      'en': 'STEP',
      'fr': '',
    },
    'h26oe4ov': {
      'en': '1/3',
      'fr': '',
    },
    'y83p4egt': {
      'en': 'NEXT',
      'fr': '',
    },
    'e34soop0': {
      'en': 'We need to know the name of the place...',
      'fr': '',
    },
    'xs49ahif': {
      'en': 'Home',
      'fr': '',
    },
  },
  // editProperty_2
  {
    'j49n3nla': {
      'en': 'Edit Property',
      'fr': '',
    },
    'b7dpthus': {
      'en': 'CHOOSE YOUR AMENITIES',
      'fr': '',
    },
    'fvfl5joa': {
      'en': 'Pool',
      'fr': '',
    },
    'jelhxnzw': {
      'en': 'Extra Outlets',
      'fr': '',
    },
    'ypnrfbno': {
      'en': 'Air Conditioning (AC)',
      'fr': '',
    },
    'v4hs9ken': {
      'en': 'Heating',
      'fr': '',
    },
    '2ycrkr7h': {
      'en': 'Washer',
      'fr': '',
    },
    '88lt34nt': {
      'en': 'Dryer',
      'fr': '',
    },
    'gfb267il': {
      'en': 'Pet Friendly',
      'fr': '',
    },
    'k9dfil71': {
      'en': 'Workout Facility',
      'fr': '',
    },
    'hcih0ct1': {
      'en': 'STEP',
      'fr': '',
    },
    '1tqkziq9': {
      'en': '2/3',
      'fr': '',
    },
    '3rwv2v56': {
      'en': 'NEXT',
      'fr': '',
    },
    '9842z2t2': {
      'en': 'Home',
      'fr': '',
    },
  },
  // editProperty_3
  {
    'uq2izm6i': {
      'en': 'Edit Property',
      'fr': '',
    },
    'gzdfb1pb': {
      'en': 'PRICE PER MONTH',
      'fr': '',
    },
    'cw4bztke': {
      'en': 'FCFA Price',
      'fr': '',
    },
    '2b6jqvvd': {
      'en': 'CLEANING FEE',
      'fr': '',
    },
    'vef8ttc8': {
      'en': 'FCFA Price',
      'fr': '',
    },
    '0sanc07e': {
      'en': 'Additional Notes',
      'fr': '',
    },
    '389yaux4': {
      'en': 'Additional notes...',
      'fr': '',
    },
    '2kyua372': {
      'en': 'Listing is Live',
      'fr': '',
    },
    'fxetn2xx': {
      'en': 'Turn this on for guests to start booking your listing.',
      'fr': '',
    },
    'geb75bka': {
      'en': 'STEP',
      'fr': '',
    },
    '68cj5o0u': {
      'en': '3/3',
      'fr': '',
    },
    'ty84yy6c': {
      'en': 'Save Changes',
      'fr': '',
    },
    'nn0173ek': {
      'en': 'Home',
      'fr': '',
    },
  },
  // bottomSheet
  {
    'tc5htkcx': {
      'en': 'Session Booked!',
      'fr': '',
    },
    'w5vt7daf': {
      'en': 'You have successfully booked a session on:',
      'fr': '',
    },
    'utk3mck0': {
      'en': 'Mon, Dec 11 - 2021',
      'fr': '',
    },
  },
  // total
  {
    'q6cmjvox': {
      'en': 'Order Total',
      'fr': '',
    },
    'o8wn4y0a': {
      'en':
          'Your order total is a summary of all items in your order minus any fees and taxes associated with your purchase.',
      'fr': '',
    },
    'eg93x6r5': {
      'en': 'Okay',
      'fr': '',
    },
  },
  // changePhoto
  {
    'nvon6xrt': {
      'en': 'Change Profile Photo',
      'fr': '',
    },
    'ue8oqnsj': {
      'en': 'Upload Photo',
      'fr': '',
    },
    'lpfs61wz': {
      'en': 'Save Photo',
      'fr': '',
    },
  },
  // reviewTrip
  {
    '2lwcc4bm': {
      'en': 'Rate Your Trip',
      'fr': '',
    },
    '2w133cw4': {
      'en': 'Let us know what you thought of the place below!',
      'fr': '',
    },
    '49dl6it9': {
      'en': 'How would you rate it?',
      'fr': '',
    },
    'h6qabff9': {
      'en': 'Please leave a description of the place...',
      'fr': '',
    },
    'vmzzg6c0': {
      'en': 'Submit Review',
      'fr': '',
    },
  },
  // changeMainPhoto
  {
    'vgc2xcnp': {
      'en': 'Change Main Photo',
      'fr': '',
    },
    '41kjvqjr': {
      'en': 'Upload Photo',
      'fr': '',
    },
    '8fv3frwi': {
      'en': 'Save Photo',
      'fr': '',
    },
  },
  // cancelTrip
  {
    '2o89tkju': {
      'en': 'Cancel Trip',
      'fr': '',
    },
    'ced0n31o': {
      'en':
          'If you want to cancel your tripl please leave a note below to send to the host.',
      'fr': '',
    },
    'gsk2f0nu': {
      'en': 'Your reason for cancelling...',
      'fr': '',
    },
    'iqp1zal0': {
      'en': 'Yes, Cancel Trip',
      'fr': '',
    },
    'h5gwj7ui': {
      'en': 'Never Mind',
      'fr': '',
    },
  },
  // cancelTripHOST
  {
    'vwav9uie': {
      'en': 'Cancel Trip',
      'fr': '',
    },
    'rqf8ppmi': {
      'en':
          'If you want to cancel your tripl please leave a note below to send to the host.',
      'fr': '',
    },
    'k3jqbcre': {
      'en': 'Your reason for cancelling...',
      'fr': '',
    },
    'xxmn8krt': {
      'en': 'Yes, Cancel Trip',
      'fr': '',
    },
    '3s2js6or': {
      'en': 'Never Mind',
      'fr': '',
    },
  },
  // Miscellaneous
  {
    'bvfpfdim': {
      'en': '',
      'fr': '',
    },
    '7z5o01ux': {
      'en': '',
      'fr':
          'Pour recuperere des photos l\'application a besion de votre permission',
    },
    's34de1q1': {
      'en': '',
      'fr': '',
    },
    'qz8u3m3k': {
      'en': '',
      'fr': '',
    },
    'h848ohpn': {
      'en': '',
      'fr': '',
    },
    'm5o5zoh9': {
      'en': '',
      'fr': '',
    },
    '0t7s3utz': {
      'en': '',
      'fr': '',
    },
    '6mpovhtp': {
      'en': '',
      'fr': '',
    },
    '8u5awcws': {
      'en': '',
      'fr': '',
    },
    'aek1w5te': {
      'en': '',
      'fr': '',
    },
    '9fefnt7j': {
      'en': '',
      'fr': '',
    },
    '1m9dypg0': {
      'en': '',
      'fr': '',
    },
    'xfyr5pmh': {
      'en': '',
      'fr': '',
    },
    'buemxhll': {
      'en': '',
      'fr': '',
    },
    'l9g4n54r': {
      'en': '',
      'fr': '',
    },
    '6yntwkjq': {
      'en': '',
      'fr': '',
    },
    '61kih585': {
      'en': '',
      'fr': '',
    },
    '3p5tmbox': {
      'en': '',
      'fr': '',
    },
    'd2q7mpgc': {
      'en': '',
      'fr': '',
    },
    'rbsp4uuf': {
      'en': '',
      'fr': '',
    },
    'yew1p2jr': {
      'en': '',
      'fr': '',
    },
    '7hh1n94z': {
      'en': '',
      'fr': '',
    },
    'wiw9fv7s': {
      'en': '',
      'fr': '',
    },
    'ai0uf0ji': {
      'en': '',
      'fr': '',
    },
    'zxk2y3ga': {
      'en': '',
      'fr': '',
    },
    'es8w7qgj': {
      'en': '',
      'fr': '',
    },
    '8yce0n9b': {
      'en': '',
      'fr': '',
    },
  },
].reduce((a, b) => a..addAll(b));
