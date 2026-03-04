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

## Handoff

See [HANDOFF.md](HANDOFF.md) for current implementation state and what the cloud agent should do next.
