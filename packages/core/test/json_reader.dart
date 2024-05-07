import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('packages/core/test/')) {
    dir = dir.replaceAll('packages/core/test/', '');
  }
  return File('$dir/packages/core/test/$name').readAsStringSync();
}
