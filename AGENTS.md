# AGENTS.md

## Cursor Cloud specific instructions

### Overview

Jurassic Dropshipping is a single Flutter desktop/mobile app for dropshipping arbitrage in the Polish market. It uses Drift (SQLite) for local storage, Riverpod for state management, and Freezed for model code generation. See `README.md` for standard commands and `HANDOFF.md` for implementation status.

### Running the app on Linux desktop

- The app requires `LIBGL_ALWAYS_SOFTWARE=1` to render on headless/VM environments (no GPU). Without it, the process crashes on startup due to EGL/DRI3 errors.
- Run with: `LIBGL_ALWAYS_SOFTWARE=1 DISPLAY=:1 ./build/linux/x64/release/bundle/jurassic_dropshipping`
- Or use `flutter run -d linux` for debug mode (also needs `LIBGL_ALWAYS_SOFTWARE=1`).

### Known pre-existing issues

- `flutter analyze lib` reports 2 info-level `use_build_context_synchronously` warnings in `lib/features/settings/settings_screen.dart`. These are non-blocking.
- `flutter test` fails because `test/widget_test.dart` references `MyApp` which was renamed to `JurassicDropshippingApp` in a later commit. This is a pre-existing issue.
- The Dashboard shows `MissingPlatformDirectoryException` errors at runtime. This is a pre-existing issue in the app's `path_provider` usage on Linux. The app UI and navigation still work; only DB-backed views (Dashboard, Products, Orders, etc.) show this error. The Settings page renders fully.

### Code generation

After changing models or Drift schema, regenerate with: `dart run build_runner build --delete-conflicting-outputs`

### System dependencies for Linux desktop builds

Flutter Linux desktop builds need: `clang`, `cmake`, `ninja-build`, `pkg-config`, `libgtk-3-dev`, `libsqlite3-dev`, `libstdc++-14-dev`, `lld-18`, `llvm-18`.
