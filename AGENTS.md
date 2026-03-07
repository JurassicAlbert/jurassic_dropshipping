# AGENTS.md

## Cursor Cloud specific instructions

### Overview

Jurassic Dropshipping is a single Flutter desktop/mobile app for dropshipping arbitrage in the Polish market. It uses Drift (SQLite) for local storage, Riverpod for state management, and Freezed for model code generation. See `README.md` for standard commands and `HANDOFF.md` for implementation status.

### Running the app on Linux desktop

- The app requires `LIBGL_ALWAYS_SOFTWARE=1` to render on headless/VM environments (no GPU). Without it, the process crashes on startup due to EGL/DRI3 errors.
- Run with: `LIBGL_ALWAYS_SOFTWARE=1 DISPLAY=:1 ./build/linux/x64/release/bundle/jurassic_dropshipping`
- Or use `flutter run -d linux` for debug mode (also needs `LIBGL_ALWAYS_SOFTWARE=1`).

### Known notes

- `flutter analyze lib` — clean, no issues.
- `flutter test` — all 136 tests pass (domain, repositories, services, integration, widget).
- The `path_provider` fallback for Linux/headless environments was fixed in `app_database_storage_io.dart`. The database now falls back to `$HOME/.jurassic_dropshipping/` when XDG dirs are unavailable.
- `flutter build web` succeeds. The web build uses Drift WASM; `web/sqlite3.wasm` (~714KB) and `web/drift_worker.js` must be present.

### Code generation

After changing models or Drift schema, regenerate with: `dart run build_runner build --delete-conflicting-outputs`

### System dependencies for Linux desktop builds

Flutter Linux desktop builds need: `clang`, `cmake`, `ninja-build`, `pkg-config`, `libgtk-3-dev`, `libsqlite3-dev`, `libstdc++-14-dev`, `lld-18`, `llvm-18`.
