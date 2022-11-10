import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/theme/buttons/buttonTheme.dart';
import 'package:hatspace/theme/buttons/sharedButtons.dart';

void main() {
  testWidgets("Test if DefaultPrimaryTextOnlyButton has proper theme (DefaultPrimaryTextOnlyButtonTheme)", ((WidgetTester tester) async {
    GlobalKey primaryTextButtonKey = GlobalKey();
    Widget primaryTextButton = DefaultPrimaryTextOnlyButton(
        key: primaryTextButtonKey, child: const Text("button"), onClick: () {});

    Widget displayButton = _materialWrapWidget(child: primaryTextButton);
    await tester.pumpWidget(displayButton);

    ElevatedButton foundButton =
        tester.widget(find.byKey(primaryTextButtonKey));
    final state = <MaterialState>{};
    expect(reason:"True if alignment is center" ,foundButton.style?.alignment, Alignment.center);
    expect(
        foundButton.style?.padding?.resolve(state), const EdgeInsets.fromLTRB(22, 17, 39, 17));
    expect(foundButton.style?.shape?.resolve(state),RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));
    expect(foundButton.style?.backgroundColor?.resolve(state),const Color(0xff3ACD64));
  }));
}

class _materialWrapWidget extends StatelessWidget {
  final Widget child;

  const _materialWrapWidget({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: child,
        ),
      );
}
