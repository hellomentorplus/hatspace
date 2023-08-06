import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_button_theme.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HatSpaceStrings.current.details,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontStyleGuide.fwBold)),
        actions: [
            IconButton(
            onPressed: () {
              // TODO add action
            },
            icon: SvgPicture.asset(
              Assets.icons.delete,
              colorFilter: const ColorFilter.mode(
                  HSColor.red05, BlendMode.srcIn),
              width: HsDimens.size24,
              height: HsDimens.size24,
            ),
          )
        ],
        backgroundColor: HSColor.neutral1,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: SvgPicture.asset(Assets.icons.arrowCalendarLeft),
        ),
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(HsDimens.size1),
            child: Container(
              color: HSColor.neutral2,
              height: HsDimens.size1,
            )),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: HsDimens.spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: HsDimens.spacing16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: HsDimens.size110,
                          height: HsDimens.size110,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(HsDimens.radius8),
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80'))),
                          // child: ,
                        ),
                        const SizedBox(width: HsDimens.spacing16),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('House',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: HSColor.green06)),
                            const SizedBox(height: HsDimens.spacing4),
                            Text('Single room for rent in Bankstown',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontWeight: FontStyleGuide.fwBold)),
                            Text('Gateway, Island',
                                style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: HsDimens.spacing4),
                            Row(
                              children: [
                                Text(r'$200',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontStyleGuide.fwBold)),
                                const SizedBox(width: HsDimens.spacing4),
                                Expanded(
                                    child: Text(HatSpaceStrings.current.pw,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall))
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                    const SizedBox(height: HsDimens.spacing20),
                    const _Divider(),
                    const SizedBox(height: HsDimens.spacing20),
                    Row(
                      children: [
                        Container(
                          width: HsDimens.size24,
                          height: HsDimens.size24,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Image.network(
                            'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: HsDimens.spacing8),
                        Expanded(
                            child: Text('Jane Cooper',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w500))),
                        _RoundIconButton(
                          iconPath: Assets.icons.message,
                          onPressed: () {},
                        ),
                        const SizedBox(width: HsDimens.spacing20),
                        _RoundIconButton(
                          iconPath: Assets.icons.phone,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: HsDimens.spacing20),
                    const _Divider(),
                    const SizedBox(height: HsDimens.spacing20),
                    Row(
                      children: [
                        Expanded(
                          child: _TimeInformationView(
                            title: HatSpaceStrings.current.start,
                            value: '09:00AM',
                          ),
                        ),
                        const SizedBox(width: HsDimens.spacing15),
                        Expanded(
                          child: _TimeInformationView(
                            title: HatSpaceStrings.current.end,
                            value: '10:00AM',
                          ),
                        ),
                        const SizedBox(width: HsDimens.spacing15),
                        Expanded(
                          child: _TimeInformationView(
                            title: HatSpaceStrings.current.date,
                            value: '14 Mar, 2023',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: HsDimens.spacing20),
                    const _Divider(),
                    const SizedBox(height: HsDimens.spacing20),
                    _TitleView(title: HatSpaceStrings.current.notes),
                    const SizedBox(height: HsDimens.spacing4),
                    Text(
                        'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: HsDimens.spacing16,
              right: HsDimens.spacing16,
              child: Container(
                padding: const EdgeInsets.only(
                  top: HsDimens.spacing8,
                  bottom: HsDimens.spacing42,
                ),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(
                    width: 1,
                    color: HSColor.neutral2
                  ))
                ),
                child: SecondaryButton(
                label: 'Edit',
                iconUrl: Assets.icons.edit,
                onPressed: () {},
              ),
              ))
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;
  const _RoundIconButton({required this.iconPath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RoundButton(
      iconUrl: iconPath,
      style: roundButtonTheme.style?.copyWith(
        minimumSize: const MaterialStatePropertyAll<Size>(Size(HsDimens.size40, HsDimens.size40)),
        maximumSize: const MaterialStatePropertyAll<Size>(Size(HsDimens.size40, HsDimens.size40)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.all(HsDimens.spacing8))),
      onPressed: onPressed,
    );
  }
}

class _TimeInformationView extends StatelessWidget {
  final String title;
  final String value;
  const _TimeInformationView(
      {required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleView(title: title),
        const SizedBox(height: HsDimens.spacing4),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _TitleView extends StatelessWidget {
  final String title;
  const _TitleView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(fontWeight: FontWeight.w500, color: HSColor.neutral5));
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
        color: HSColor.neutral2,
        thickness: HsDimens.size1,
        height: HsDimens.size1);
  }
}
