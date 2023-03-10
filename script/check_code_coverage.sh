# !/bin/sh

root=$(pwd)

rm -r coverage/

flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter test --coverage
lcov --remove coverage/lcov.info -o coverage/lcov.info \
	'lib/generated/**' \
	'lib/firebase_options.dart' \
	'lib/**/*.g.dart' \
	'lib/main.dart' \
	'lib/features/debug/**' \
	'lib/initial_app.dart'

cat coverage/lcov.info > coverage/lcov.base.info

echo 'Generate html'
genhtml coverage/lcov.base.info -o coverage/html
open coverage/html/index.html
