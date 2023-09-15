import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/home/view/widgets/property_item_view.dart';
import 'package:hatspace/features/home/view_model/get_properties_cubit.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetPropertiesCubit>(
          create: (context) => GetPropertiesCubit()..getProperties(),
        ),
      ],
      child: const HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => HomePageBodyState();
}

class HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            String? welcome = (state is AuthenticatedState)
                ? HatSpaceStrings.current
                    .welcomeName(state.userDetail.displayName ?? '')
                : HatSpaceStrings.current.welcomeDefault;

            return Text(
              welcome.trim(), // trim text in case display name is null
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: colorScheme.onPrimary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          },
        ),
        titleSpacing: HsDimens.spacing16,
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: HsDimens.size68,
        elevation: 0.0,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         // TODO add action
        //       },
        //       icon: SvgPicture.asset(
        //         Assets.icons.icAgent,
        //         colorFilter: ColorFilter.mode(
        //             Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
        //         width: HsDimens.size24,
        //         height: HsDimens.size24,
        //       )),
        //   IconButton(
        //     onPressed: () {
        //       // TODO add action
        //     },
        //     icon: SvgPicture.asset(
        //       Assets.icons.notification,
        //       colorFilter: ColorFilter.mode(
        //           Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
        //       width: HsDimens.size24,
        //       height: HsDimens.size24,
        //     ),
        //   )
        // ],
      ),
      body: BlocBuilder<GetPropertiesCubit, GetPropertiesState>(
        builder: (context, state) {
          if (state is GetPropertiesSucceedState) {
            if (state.propertyList.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: HsDimens.spacing16,
                  vertical: HsDimens.spacing24,
                ),
                itemBuilder: (_, idx) => PropertyItemView(
                    key: ValueKey(state.propertyList[idx].id),
                    property: state.propertyList[idx]),
                itemCount: state.propertyList.length,
                separatorBuilder: (_, __) => const SizedBox(
                  height: HsDimens.spacing12,
                ),
              );
            }

            /// TODO :  Render empty data widget
          } else if (state is GetPropertiesFailedState) {
            /// TODO :  Render failed widget
          } else if (state is GettingPropertiesState) {
            /// TODO :  Render loading widget
          }
          return const SizedBox();
        },
      ),
    );
  }
}
