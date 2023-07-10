# !/bin/bash

flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter --no-color pub run intl_utils:generate
