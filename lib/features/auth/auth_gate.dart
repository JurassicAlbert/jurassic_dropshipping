import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/features/auth/login_screen.dart';

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<AuthGate> createState() => AuthGateState();
}

class AuthGateState extends ConsumerState<AuthGate> {
  bool _authenticated = false;
  bool _loading = true;
  bool _isFirstTime = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final auth = ref.read(authServiceProvider);
    final hasPassword = await auth.isPasswordSet;
    if (!hasPassword) {
      setState(() {
        _loading = false;
        _isFirstTime = true;
      });
      return;
    }
    final locked = await auth.isLocked;
    setState(() {
      _loading = false;
      _authenticated = !locked;
    });
  }

  void _onAuthenticated() {
    setState(() {
      _authenticated = true;
      _isFirstTime = false;
    });
  }

  void lockOut() {
    setState(() {
      _authenticated = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (!_authenticated) {
      return Navigator(
        onGenerateRoute: (_) => MaterialPageRoute<void>(
          builder: (_) => LoginScreen(
            isFirstTime: _isFirstTime,
            onAuthenticated: _onAuthenticated,
          ),
        ),
      );
    }
    return widget.child;
  }
}
