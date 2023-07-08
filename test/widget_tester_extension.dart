import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/strings/l10n.dart';

extension WidgetExtension on WidgetTester {
  Future<void> wrapAndPump(Widget widget,
      {bool infiniteAnimationWidget = false,
      ThemeData? theme,
      bool useRouter = false}) async {
    final Widget wrapper = _MaterialWrapWidget(
      theme: theme,
      useRouter: useRouter,
      child: widget,
    );

    await pumpWidget(wrapper);
    if (infiniteAnimationWidget) {
      await pump();
    } else {
      await pumpAndSettle();
    }
  }

  Future<void> blocWrapAndPump<B extends StateStreamableSource<Object?>>(
      B bloc, Widget widget,
      {bool infiniteAnimationWidget = false,
      ThemeData? theme,
      bool useRouter = false}) async {
    final Widget wrapper = BlocProvider<B>(
      create: (_) => bloc,
      child: _MaterialWrapWidget(
        theme: theme,
        useRouter: useRouter,
        child: widget,
      ),
    );

    await pumpWidget(wrapper);
    if (infiniteAnimationWidget) {
      await pump();
    } else {
      await pumpAndSettle();
    }

    await pumpFrames(wrapper, const Duration(milliseconds: 16));
  }

  Future<void> multiBlocWrapAndPump(
      List<BlocProvider<StateStreamableSource<Object?>>> providers,
      // List<BlocProvider<<B extends StateStreamableSource<Object?>>> providers,
      Widget widget,
      {bool infiniteAnimationWidget = false,
      bool useRouter = false,
      String? targetRoute}) async {
    final Widget wrapper = MultiBlocProvider(
        providers: providers,
        child: _MaterialWrapWidget(
          useRouter: useRouter,
          child: widget,
        ));

    await pumpWidget(wrapper);
    if (infiniteAnimationWidget) {
      await pump();
    } else {
      await pumpAndSettle();
    }

    if (useRouter) {
      await tap(find.text('Start testing'));
      if (infiniteAnimationWidget) {
        await pump();
      } else {
        await pumpAndSettle();
      }
    }

    await pumpFrames(wrapper, const Duration(milliseconds: 16));
  }
}

class _MaterialWrapWidget extends StatelessWidget {
  final Widget child;
  final ThemeData? theme;
  final bool useRouter;

  const _MaterialWrapWidget(
      {required this.child, required this.useRouter, Key? key, this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        body: useRouter ? _DummyRouter(targetPage: child) : child,
      ),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        HatSpaceStrings.delegate
      ],
      supportedLocales: HatSpaceStrings.delegate.supportedLocales,
    );
  }
}

class _DummyRouter extends StatelessWidget {
  final Widget targetPage;
  const _DummyRouter({required this.targetPage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: TextButton(
            child: const Text('Start testing'),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => targetPage,
            )),
          ),
        ),
      );
}