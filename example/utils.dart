String mapToString(Map<String, dynamic> map) {
  String out = '{';
  for(var entry in map.entries) {
    out += '${entry.key}: ';
    if(entry.value is String) {
      out += '"${entry.value}"';
    } else {
      out += '${entry.value}';
    }
    out += ', ';
  }
  out = out.substring(0, out.length - 2);
  out += '}';
  return out;
}