import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: SplitColorPainter(Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.background),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            color: Colors.white,
            elevation: 4.0,
            shadowColor: HSColor.black.withOpacity(0.2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SvgPicture.asset(
                      Assets.icons.search,
                      width: 20.0,
                      height: 20.0,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                          hintText: HatSpaceStrings.current.searchHint,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(height: 1.0)),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(height: 1.0),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 12.0),
                    child: VerticalDivider(
                      indent: 16.0,
                      endIndent: 16.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SvgPicture.asset(
                      Assets.icons.filter,
                      width: 24.0,
                      height: 24.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}

class SplitColorPainter extends CustomPainter {
  final Color firstColor;
  final Color secondColor;

  SplitColorPainter(this.firstColor, this.secondColor);

  final Paint _paint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = firstColor;
    canvas.drawRect(
        Rect.fromPoints(Offset.zero, Offset(size.width, size.height / 2)),
        _paint);
    _paint.color = secondColor;
    canvas.drawRect(
        Rect.fromPoints(
            Offset(0.0, size.height / 2), Offset(size.width, size.height)),
        _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
