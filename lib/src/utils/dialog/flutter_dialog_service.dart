import 'package:flutter/material.dart';

import 'dialog_service.dart';

class FlutterDialogService implements DialogService {
  final GlobalKey<NavigatorState> _navigatorKey;

  FlutterDialogService(this._navigatorKey);

  BuildContext? get _context => _navigatorKey.currentContext;

  @override
  Future<void> showError(String message) async {
    if (_context == null) return;
    return showDialog(
      context: _context!,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> showInfo(String message) async {
    if (_context == null) return;
    return showDialog(
      context: _context!,
      builder: (context) => AlertDialog(
        title: const Text('Information'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Future<bool> showConfirmation(String message) async {
    if (_context == null) return false;
    final result = await showDialog<bool>(
      context: _context!,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
