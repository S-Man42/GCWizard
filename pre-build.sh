#!/bin/bash
find ./lib/tools/ -name "*_registration.dart" -type f \
	| xargs grep -l "implements AbstractToolRegistration" \
	| cut -c 2- \
	| sed "s/.lib\//import 'package:gc_wizard\//g" \
	| sed "s/$/';/" \
	> ./lib/configuration/reflectors/gcw_tool_reflected_classes.dart
	
flutter packages pub run build_runner build DIR --delete-conflicting-outputs