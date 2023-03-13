import 'dart:io';

String jsonReader(String name) => File('assets/json_responses/$name.response.json').readAsStringSync();
