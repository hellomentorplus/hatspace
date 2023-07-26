import 'package:flutter/material.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/theme/hs_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child:
          Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: HsDimens.size64,
                    child: Image.network('https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80'),),
                  const SizedBox(width: HsDimens.spacing16),
                  Column(
                    children: [
                      Text('Hoang Nguyen', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontStyleGuide.fwBold,
                          fontSize: FontStyleGuide.fontSize16
                      )),
                      const SizedBox(height: HsDimens.spacing4),
                      Text('View profile', style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: HsDimens.spacing4),
                      ...Roles.values.map((role) => )
                    ],
                  )
                ],
              ),
            ]
          )
      )
    );
  }
}

