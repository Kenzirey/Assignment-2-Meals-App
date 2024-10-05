import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePersistency {
  static const _favoritesKey = "FAVORITE_MEALS";

  Future<SharedPreferences> get _preferences async {
    return await SharedPreferences.getInstance();
  }

  void save(Set<String> favoriteIds) async {
    bool didSet = await (await _preferences).setStringList(_favoritesKey, favoriteIds.toList());

    if (!didSet) {
      throw const FileSystemException("Failed to save filters");
    }
  }

  Future<Set<String>> load() async {
    List<String> loadedValue = (await _preferences).getStringList(_favoritesKey) ?? [];

    return loadedValue.toSet();
  }
}

final favoritePersistency = FavoritePersistency();