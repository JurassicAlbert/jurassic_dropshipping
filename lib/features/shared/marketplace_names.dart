/// Display names for target platform IDs.
const Map<String, String> marketplaceDisplayNames = {
  'allegro': 'Allegro',
  'temu': 'Temu',
  'amazon': 'Amazon',
};

String marketplaceDisplayName(String platformId) =>
    marketplaceDisplayNames[platformId] ?? platformId;
