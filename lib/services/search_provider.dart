import 'dart:async';
import 'package:flutter/material.dart';

class SearchProvider<T> extends ChangeNotifier {
  List<T> _suggestions = [];
  bool _isLoading = false;
  Timer? _debounce;

  List<T> get suggestions => _suggestions;
  bool get isLoading => _isLoading;

  // Función genérica que usa un Future para obtener sugerencias
  void onSearchChanged(String query, Future<List<T>> Function(String) fetchFunction) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchSuggestions(query, fetchFunction);
    });
  }

  Future<void> _fetchSuggestions(String query, Future<List<T>> Function(String) fetchFunction) async {
    // if (query.isEmpty) {
    //   _suggestions = [];
    //   notifyListeners();
    //   return;
    // }

    _isLoading = true;
    notifyListeners();

    try {
      _suggestions = await fetchFunction(query);
    } catch (e) {
      print("Error en la búsqueda: $e");
      _suggestions = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
