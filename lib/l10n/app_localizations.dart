import 'package:flutter/material.dart';

/// App strings in Polish (default) and English.
/// Use [AppLocalizations.of(context)] or [ref.watch(appLocalizationsProvider)].
class AppLocalizations {
  AppLocalizations(this.locale) : isPl = locale.languageCode == 'pl';

  final Locale locale;
  final bool isPl;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const Locale defaultLocale = Locale('pl');
  static const List<Locale> supportedLocales = [Locale('pl'), Locale('en')];

  // ─── App & nav ───
  String get appTitle => isPl ? 'Jurassic Dropshipping' : 'Jurassic Dropshipping';

  List<String> get navLabels => isPl ? _navLabelsPl : _navLabelsEn;
  static const _navLabelsPl = [
    'Panel',
    'Analityka',
    'Zysk',
    'Produkty',
    'Zamówienia',
    'Dostawcy',
    'Marketplace',
    'Zwroty',
    'Incydenty',
    'Ryzyko',
    'Zwrócony towar',
    'Kapitał',
    'Kolejka zatwierdzeń',
    'Dziennik decyzji',
    'Polityki zwrotów',
    'Ustawienia',
    'Jak to działa',
  ];
  static const _navLabelsEn = [
    'Dashboard',
    'Analytics',
    'Profit',
    'Products',
    'Orders',
    'Suppliers',
    'Marketplaces',
    'Returns',
    'Incidents',
    'Risk',
    'Returned stock',
    'Capital',
    'Approval Queue',
    'Decision Log',
    'Return policies',
    'Settings',
    'How it works',
  ];

  String navLabelAt(int index) {
    if (index >= 0 && index < navLabels.length) return navLabels[index];
    return appTitle;
  }

  // ─── Settings ───
  String get settingsTitle => isPl ? 'Ustawienia' : 'Settings';
  String get language => isPl ? 'Język' : 'Language';
  String get languagePolish => isPl ? 'Polski' : 'Polish';
  String get languageEnglish => isPl ? 'Angielski' : 'English';
  String get appearance => isPl ? 'Wygląd' : 'Appearance';
  String get themeSystem => isPl ? 'System' : 'System';
  String get themeLight => isPl ? 'Jasny' : 'Light';
  String get themeDark => isPl ? 'Ciemny' : 'Dark';
  String get rulesSaved => isPl ? 'Zapisano ustawienia.' : 'Rules saved successfully!';
  String get dismiss => isPl ? 'Zamknij' : 'Dismiss';
  String get planAndUsage => isPl ? 'Plan i użycie' : 'Plan & usage';
  String get developerTools => isPl ? 'Narzędzia deweloperskie' : 'Developer Tools';

  // ─── Shell / common ───
  String get openNav => isPl ? 'Otwórz menu' : 'Open navigation menu';
  String get readOnlyLabel => isPl ? 'Tylko odczyt (brak zapisu na marketplace)' : 'Read-only (no writes to marketplaces)';
  String get liveWritesLabel => isPl ? 'Zapis na marketplace włączony' : 'Live writes enabled';
  String get readOnlyTooltip => isPl ? 'Zapis na marketplace wyłączony. Zmień w Ustawieniach, aby włączyć.' : 'Writes to marketplaces are disabled. Change in Settings to enable.';
  String get liveWritesTooltip => isPl ? 'Tryb live: zamówienia i oferty są wysyłane na marketplace.' : 'Live mode: orders and listings can be sent to marketplaces.';
  String get searchTooltip => isPl ? 'Szukaj ekranu lub akcji albo przejdź do zamówienia po ID. Skrót: Ctrl+K' : 'Search any screen or action, or jump to an order by ID. Shortcut: Ctrl+K';
  String get helpTooltip => isPl ? 'Pomoc: wyszukaj sekcję, akcję lub zamówienie' : 'Help: open search to find any section, action, or order';
  String get jumpToOrderTooltip => isPl ? 'Przejdź do zamówienia po ID' : 'Jump directly to an order by entering its ID';
  String get jumpToOrder => isPl ? 'Przejdź do zamówienia' : 'Jump to order';
  String get orderId => isPl ? 'ID zamówienia' : 'Order ID';
  String get orderIdHint => isPl ? 'Wpisz ID zamówienia' : 'Enter order ID to open';
  String get cancel => isPl ? 'Anuluj' : 'Cancel';
  String get go => isPl ? 'Idź' : 'Go';
  String get lockApp => isPl ? 'Zablokuj aplikację' : 'Lock app';
}
