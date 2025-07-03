import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Bloc/sync_bloc/sync_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/language_cubit.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/user_cubit/user_cubit.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Commons/alert_dialog.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Commons/common_button.dart';
import 'package:temwin_front_app/Core/Navigation/go_router_navigation.dart';
import 'package:temwin_front_app/Core/utils/app_assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:temwin_front_app/Domain/entities/bnf_entity.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _nniController = TextEditingController();

  @override
  void dispose() {
    _nniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.settings,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              onPressed: () {
                // Handle language change
                showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog.adaptive(
                        title: Text(
                          AppLocalizations.of(context)!.language_change,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                        content: LanguageDialog(),
                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                        // actions: [
                        //   //  TextButton(onPressed:() {}, child: child)
                        //   CommonButton(
                        //     text: "OK",
                        //     fn: () {
                        //       CustomNavigationHelper.router.pop();
                        //     },
                        //     color: Colors.black,
                        //     textColor: Colors.white,
                        //   )
                        // ],
                      );
                    });
              },
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Spacer(),
                  Image.asset(
                    AppAssets.app_logo, // Replace with the path to your logo
                    height: 100,
                  ),
                  Text(
                    'V1.1.0',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${AppLocalizations.of(context)!.user_name} : ${context.read<UserCubit>().state!.user?.name ?? "--"}',
                            style: TextStyle(fontSize: 18)),
                        Text(
                            '${AppLocalizations.of(context)!.point} : ${context.read<UserCubit>().state!.user?.pos?.name ?? "--"}',
                            style: TextStyle(fontSize: 18)),
                        SizedBox(height: 20),
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return AbsorbPointer(
                              absorbing: state is UnAuthenticating,
                              child: Row(
                                spacing: 10.w,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: CommonButtonWithIcon(
                                      text:
                                          AppLocalizations.of(context)!.logout,
                                      icon: Icons.logout,
                                      fn: () {
                                        context.read<AuthBloc>().add(SignOut());
                                      },
                                      isLoading: state is UnAuthenticating,
                                      color: Colors.red,
                                      textColor: Colors.white,
                                      buttonFontSize: 14.sp,
                                    ),
                                  ),
                                  BlocConsumer<SyncBloc, SyncState>(
                                    listener: (context, state) {
                                      if (state is SyncOfflineDataSuccess) {
                                        showSellDialog(context, [
                                          AppLocalizations.of(context)!
                                              .sync_success,
                                        ]);
                                        debugPrint("SyncOfflineDataSuccess...");
                                      }

                                      if (state is SyncOfflineDataFailure) {
                                        //show error
                                        showSellDialog(
                                            context,
                                            [
                                              state.errorMessage,
                                            ],
                                            true);
                                        debugPrint("SyncOfflineDataFailure...");
                                      }
                                    },
                                    builder: (context, state) {
                                      return Expanded(
                                        child: CommonButtonWithIcon(
                                          text: AppLocalizations.of(context)!
                                              .sync,
                                          icon: Icons.upload_file,
                                          isLoading:
                                              state is SyncOfflineDataLoading,
                                          isDisabled:
                                              state is SyncOfflineDataLoading,
                                          fn: () {
                                            context
                                                .read<SyncBloc>()
                                                .add(SyncOfflineData(
                                                  posEntity: context
                                                      .read<UserCubit>()
                                                      .state!
                                                      .user!
                                                      .pos!,
                                                ));
                                          },
                                          color: Colors.red,
                                          textColor: Colors.white,
                                          buttonFontSize: 14.sp,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _nniController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.benef_nni,
                          ),
                        ),
                        SizedBox(height: 10),
                        CommonButton(
                          text: AppLocalizations.of(context)!.add,
                          color: Colors.green,
                          fn: () {
                            if (_nniController.text.trim().length == 10) {
                              context.read<UserCubit>().addBeneficiaire(
                                  beneficiaire: BnfEntity(
                                      nni: _nniController.text.trim()));
                              _nniController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ])

            //    Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       ElevatedButton(
            //         onPressed: () {
            //           CustomNavigationHelper.router.go(
            //             CustomNavigationHelper.loginPath,
            //           );
            //         },
            //         child: const Text('Go SignIn Page'),
            //       ),
            //       const Padding(
            //         padding: EdgeInsets.all(8.0),
            //         child: Text(
            //           'Or instead we can launch the bottom navigation page(with shell) for different tab with only changing the path',
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            ));
  }
}

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({super.key});

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  int? _selectedValue = 1;

  Map<int, String> map = {
    1: "fr",
    // 2: "en",
    2: "ar",
  };

  void _handleRadioValueChange(int? value) {
    // setState(() {
    //   _selectedValue = value;
    // });

    BlocProvider.of<LanguageCubit>(context).setLanguage(map[value] ?? 'fr');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale?>(
      builder: (context, state) {
        _selectedValue = map.entries
            .firstWhere(
              (entry) => entry.value == state?.languageCode,
            )
            .key;
        return Column(
          spacing: 10.h,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RadioListTile<int>(
              title: Text(
                AppLocalizations.of(context)!.fr,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
              value: 1,
              groupValue: _selectedValue,
              onChanged: _handleRadioValueChange,
            ),
            RadioListTile<int>(
              title: Text(
                AppLocalizations.of(context)!.ar,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
              value: 2,
              groupValue: _selectedValue,
              onChanged: _handleRadioValueChange,
            ),
          ],
        );
      },
    );
  }
}
