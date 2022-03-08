// ignore_for_file: parameter_assignments

/// Parses the given query string into a Map.
Map parse(String query) {
  final search = RegExp('([^&=]+)=?([^&]*)');
  final result = {};

// Get rid off the beginning ? in query strings.
  if (query.startsWith('?')) {
    query = query.substring(1);
  }

// A custom decoder.
  String decode(String s) => Uri.decodeComponent(s.replaceAll('+', ' '));

// Go through all the matches and build the result map.
  for (final Match match in search.allMatches(query)) {
    result[decode(match.group(1)!)] = decode(match.group(2)!);
  }

  return result;
}
