import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_theme.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Profile', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontWeight: FontStyleGuide.fwBold
      )), actions: [
        InkWell(
          child: Text('Edit',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontStyleGuide.fwBold, color: HSColor.primary)),
        )
      ],
      backgroundColor: HSColor.neutral2,
      leading: BackButton(color: Colors.black,),
      elevation: 0.5,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: HsDimens.spacing16),
          child: Column(
            children: [
              const SizedBox(height: HsDimens.spacing32),
              Stack(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: HSColor.neutral2,
                      ),
                      height: HsDimens.size104,
                      width: HsDimens.size104,
                      child: SvgPicture.asset(Assets.images.calendar,
                          fit: BoxFit.none)),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(Assets.images.cameraCircle))
                ],
              ),
              const SizedBox(height: HsDimens.spacing32),
              _InformationView(
                title: 'Display name',
                value: 'abc',
              ),
              _InformationView(
                title: 'Full name',
                value: 'abc',
              ),
              _InformationView(
                title: 'Email',
                value: 'abc',
              ),
              _InformationView(
                title: 'Phone number',
                value: 'abc',
              ),
              _InformationView(
                title: 'Date of Birth',
                value: 'abc',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InformationView extends StatelessWidget {
  final String title;
  final String? value;
  const _InformationView({required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: HsDimens.spacing12),
        Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: HSColor.neutral6
        )),
        const SizedBox(height: HsDimens.spacing4),
        Text(value != null && value!.isNotEmpty ? value! : 'Not updated',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: HsDimens.spacing12),
        const Divider(color: HSColor.neutral2, thickness: 1, height: 1)
      ],
    );
  }
}
