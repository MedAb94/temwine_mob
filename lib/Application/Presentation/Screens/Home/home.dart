import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Bloc/vendor_bloc/bloc/vendor_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/user_cubit/user_cubit.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Commons/alert_dialog.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Commons/common_button.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Commons/loader.dart';
import 'package:temwin_front_app/Core/Navigation/go_router_navigation.dart';
import 'package:temwin_front_app/Core/dependency_injection.dart/injections.dart';
import 'package:temwin_front_app/Core/utils/app_assets.dart';
import 'package:temwin_front_app/Core/utils/colors.dart';
import 'package:temwin_front_app/Data/dataSources/Local/OfflineSales/offline_sales_local_data_source.dart';
import 'package:temwin_front_app/Data/models/pos_bnf_data_model.dart';
import 'package:temwin_front_app/Domain/entities/bnf_entity.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/sales_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_bnf_data_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void verifyBnf(BuildContext context, String nni) {
    context.read<VendorBloc>().add(VerifyBnf(nni: nni));
  }

  void navigateToPointOfSellScreenOffline(
      {required PosBnfDataEntity data, required BuildContext context}) async {
    await CustomNavigationHelper.router
        .push(CustomNavigationHelper.posOfflinePath,
            extra: PosBnfDataModel(bnf: data.bnf))
        .then((result) {
      if (result != null && result == true) {
        // show sale done successfully dialog
        // ignore: use_build_context_synchronously
        showSellDialog(context, [
          AppLocalizations.of(context)!.payment_success,
          AppLocalizations.of(context)!.sale_with_success,
        ]);
      } else {
        //
      }
    });
  }

  void navigateToPointOfSellScreen(
      {required PosBnfDataEntity data, required BuildContext context}) async {
    await CustomNavigationHelper.router
        .push(CustomNavigationHelper.posPath, extra: data)
        .then((result) {
      if (result != null && result == true) {
        // show sale done successfully dialog
        // ignore: use_build_context_synchronously
        showSellDialog(context, [
          AppLocalizations.of(context)!.payment_success,
          AppLocalizations.of(context)!.sale_with_success,
        ]);
      } else {
        //
      }
    });
  }

  DateTime stringToDatetime(String dateString) {
    debugPrint("stringToDatetime : $dateString");
    DateFormat format = DateFormat("dd/MM/yyyy HH:mm:ss");
    DateTime dateTime = format.parse(dateString);

    return dateTime;
  }

  Future<bool> checkIfbnfPurshasedToday(
      {required BuildContext context, required String nni}) async {
    List<SalesEntity>? sales =
        await sl<OfflineSalessLocalDataSource>().getOfflineSaless();

    if (sales == null) return false;

    try {
      SalesEntity foundedSale = sales.lastWhere(
        (element) => element.nni == nni,
      );

      if (stringToDatetime(foundedSale.date ?? "").day == DateTime.now().day) {
        return true;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  Future<bool> checkIfDailyQuotaIsReached(
      {required BuildContext context, required String nni}) async {
    bool result = await checkIfbnfPurshasedToday(context: context, nni: nni);

    if (result == false) {
      return false;
    } else {
      List<ProductsEntity>? products =
          // ignore: use_build_context_synchronously
          context.read<UserCubit>().state!.products;

      if (products == null) return false;

      List<SalesEntity>? sales =
          await sl<OfflineSalessLocalDataSource>().getOfflineSaless();

      List<SalesEntity>? selectedSales = sales!
          .where((element) =>
              element.nni == nni &&
              (stringToDatetime(element.date ?? "").day == DateTime.now().day))
          .toList();

      for (var p in products) {
        int sum = 0;
        for (var sale in selectedSales) {
          if (sale.items!
              .where(
                (element) => element.id == p.id,
              )
              .toList()
              .isNotEmpty) {}
        }
      }

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.home,
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: BlocProvider(
        create: (context) => sl<VendorBloc>(),
        child: Center(
          child: BlocConsumer<VendorBloc, VendorState>(
            listener: (context, state) {
              if (state is VerifyBnfSuccess) {
                debugPrint('state.data bnf : ${state.data.bnf}');
                navigateToPointOfSellScreen(data: state.data, context: context);
              }

              if (state is VerifyBnfFailed) {
                // show dialog
                // showAlertDialog(context,
                //     hasActions: false,
                //     title: "Error",
                //     content: Text(state.errorMessage));

                showSellDialog(
                    // ignore: use_build_context_synchronously
                    context,
                    [state.errorMessage],
                    true);
              }
            },
            builder: (context, state) {
              return state is VerifyBnfLoading
                  ? const Loader()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            bool isOffline = context
                                    .read<UserCubit>()
                                    .state!
                                    .user!
                                    .pos!
                                    .type !=
                                1;
                            final result = await CustomNavigationHelper.router
                                .push(CustomNavigationHelper.cameraIsolatePath,
                                    extra: isOffline);
                            if (result != null) {
                              // Handle the returned value
                              debugPrint('Returned value: $result');

                              if (isOffline) {
                                //checkIfbnfPurshasedToday
                                String nni = (result as List<String>)[0];
                                bool checkIfbnfPurshasedTodayvalue =
                                    await checkIfbnfPurshasedToday(
                                        // ignore: use_build_context_synchronously
                                        context: context,
                                        nni: nni);

                                if (checkIfbnfPurshasedTodayvalue) {
                                  //show error dialog
                                  showSellDialog(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      [
                                        // ignore: use_build_context_synchronously
                                        AppLocalizations.of(context)!
                                            .quota_finished,
                                      ],
                                      true);
                                } else {
                                  String fullname = result[1];
                                  String firstname =
                                      fullname.trim().split(" ")[0];
                                  String lastname =
                                      fullname.trim().split(" ")[1];
                                  navigateToPointOfSellScreenOffline(
                                      // ignore: use_build_context_synchronously
                                      context: context,
                                      data:
                                          //PosBnfDataModel.fromEntity(posBnfDataEntity: posBnfDataEntity)
                                          PosBnfDataEntity(
                                              bnf: BnfEntity(
                                                  nni: nni,
                                                  nom: lastname.trim(),
                                                  prenom: firstname.trim())));
                                }
                              } else {
                                // ignore: use_build_context_synchronously
                                verifyBnf(context, (result as List<String>)[0]);
                              }
                            } else {
                              debugPrint('le scan a echoue : $result');
                            }
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Card(
                              color: AppColors.white,
                              margin: EdgeInsets.all(10.w),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  spacing: 15.h,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppAssets.id_scan,
                                      colorBlendMode: BlendMode.darken,
                                      // width:
                                      //     MediaQuery.of(context).size.width * 0.8,
                                      height: 150.h,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.scan_cin,
                                      //  'Veuiller scanner le dos de la CIN',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ElevatedButton(
                        //   onPressed: () {
                        //     CustomNavigationHelper.router.push(
                        //       CustomNavigationHelper.posPath,
                        //     );
                        //   },
                        //   child: const Text('Push Detail'),
                        // ),
                        // const Padding(
                        //   padding: EdgeInsets.all(8.0),
                        //   child: Text(
                        //     'Using push method of router enable us to navigate in the current tab without losing the shell',
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),

                        /// TODO continue
                        // ElevatedButton(
                        //   onPressed: () {
                        //     CustomNavigationHelper.router.push(
                        //       CustomNavigationHelper.rootDetailPath,
                        //     );
                        //   },
                        //   child: const Text('Push Detail From Root Navigator'),
                        // ),
                        // const Padding(
                        //   padding: EdgeInsets.all(8.0),
                        //   child: Text(
                        //     'Using push method of router enable us to navigate in the current tab without losing the shell',
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
