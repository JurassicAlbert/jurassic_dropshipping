# Jurassic Dropshipping

Personal dropshipping arbitrage app (Flutter) – automate sourcing, listing, and order fulfillment for the Polish market. Single-user; optional manual approval for listings and orders.

## Setup

- Flutter SDK (see `environment.sdk` in [pubspec.yaml](pubspec.yaml)).
- Copy [.env.example](.env.example) to `.env` if you need env-based config (API base URLs). **Do not commit API keys** – use the app Settings and secure storage.

## Run

```bash
flutter pub get
flutter run   # pick Android or desktop (Windows/macOS/Linux)
```

## Codegen

After changing models or the Drift schema:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Documentation

- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) – High-level architecture and data flow.
- [docs/DECISION_LOGIC.md](docs/DECISION_LOGIC.md) – Listing and supplier decision rules.
- [docs/ADDING_A_MARKETPLACE.md](docs/ADDING_A_MARKETPLACE.md) – How to add a new source or target platform.

## Integrations

- **Source**: CJ Dropshipping (API v2). Configure email + API key in Settings.
- **Target**: Allegro REST API. Configure OAuth tokens (access/refresh) and client credentials in code/secure storage; full Allegro OAuth flow in app can be added later.
- **Stubs**: Temu (source) and Amazon (target) are stubs for future implementation.
