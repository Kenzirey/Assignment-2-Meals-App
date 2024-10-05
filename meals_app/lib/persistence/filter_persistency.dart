import 'dart:io';

import 'package:meals_app/data/filter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Responsible for saving and loading applied filters
class FilterPersistency {
  static const _filterKey = "APPLIED_FILTERS";

  Future<SharedPreferences> get _preferences async {
    return await SharedPreferences.getInstance();
  }

  void save(Set<Filter> filters) async {
    int bitflag = toBitflag(filters);
    bool didSet = await (await _preferences).setInt(_filterKey, bitflag);

    if (!didSet) {
      throw const FileSystemException("Failed to save filters");
    }
  }

  Future<Set<Filter>> load() async {
    int bitflag = (await _preferences).getInt(_filterKey) ?? 0;

    return fromBitflag(bitflag);
  }

  // For below:
  // Bitflags are a very compact way of storing a large amount of booleans. This is used
  // entirely to reduce the storage required for persistency. It is not necessary, as the
  // app would barely store any data anyways, but it's great practice for whenever we
  // actually need to store a huge amount of data.

  /// Creates a bitflag from a set of filters. Used for persistence.
  static int toBitflag(Set<Filter> filters) {
    int bitflag = 0;

    for (Filter filter in filters) {
      bitflag += 1 << filter.index;
    }

    return bitflag;
  }

  /// Creates a set of filters from a bitflag. Used for persistence.
  static Set<Filter> fromBitflag(int bitflag) {
    Set<Filter> filters = {};

    int mask = 1;
    for (int i = 0; i < bitflag.bitLength; i++) {
      if (bitflag & mask == mask) {
        filters.add(Filter.values[i]);
      }
      mask <<= 1;
    }

    return filters;
  }
}

final filterPersistency = FilterPersistency();