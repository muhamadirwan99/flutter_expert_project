import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/packages/core/test')) {
    dir = dir.replaceAll('/packages/core/test', '');
  }
  if (dir.endsWith('tv')) {
    return File('$dir/packages/core/test/$name').readAsStringSync();
  }
  return File('$dir/packages/tv/test/$name').readAsStringSync();
}
