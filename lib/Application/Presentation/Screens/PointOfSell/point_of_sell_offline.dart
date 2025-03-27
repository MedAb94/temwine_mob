import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Bloc/otp_bloc/otp_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/cubit/update_invoice_cubit.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/cubit/update_invoice_state.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/language_cubit.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/offline_sales_cubit/offline_sales_storage_cubit.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/user_cubit/user_cubit.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Commons/alert_dialog.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Commons/common_button.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Commons/custom_text_field.dart';
import 'package:temwin_front_app/Core/Navigation/go_router_navigation.dart';
import 'package:temwin_front_app/Core/dependency_injection.dart/injections.dart';
import 'package:temwin_front_app/Core/utils/colors.dart';
import 'package:temwin_front_app/Core/utils/maps_compare.dart';
import 'package:temwin_front_app/Domain/entities/bnf_entity.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/items_entity.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/sales_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_bnf_data_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_entity.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';
import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:temwin_front_app/Domain/entities/user_data_entity.dart';
import 'package:temwin_front_app/Domain/entities/user_entity.dart';

class PointOfSellOffline extends StatefulWidget {
  const PointOfSellOffline({super.key, required this.bnf});

  final PosBnfDataEntity bnf;

  @override
  State<PointOfSellOffline> createState() => _PointOfSellOfflineState();
}

class _PointOfSellOfflineState extends State<PointOfSellOffline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.sell,
          //  "Espace de vente",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.green,
      ),
      body: SingleChildScrollView(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<UpdateInvoiceCubit>(
                create: (context) => sl<UpdateInvoiceCubit>()),
            // BlocProvider<OtpBloc>(create: (context) => sl<OtpBloc>()),
          ],
          child: BlocBuilder<UserCubit, UserDataEntity?>(
            builder: (context, uesrCubitState) {
              //  UserEntity? user = uesrCubitState!.user;
              List<ProductsEntity>? products = uesrCubitState!.products;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 5.h,
                children: [
                  PosVendorInfOffline(data: widget.bnf),
                  PosProductTableOffline(products: products),
                  PosProductClickableSquaresOffline(products: products),
                  BlocBuilder<UpdateInvoiceCubit, UpdateInvoiceState>(
                    // buildWhen: (previous, current) {
                    //   return !compareMaps(previous, current);
                    // },
                    builder: (context, state) {
                      //debugPrint('addNewRow in widget map : $state');
                      return state.data.isEmpty
                          ? SizedBox.shrink()
                          : PosProductTableInvoiceOffline(
                              productRowData: state.data,
                              //bnf: widget.data.bnf!,

                              onValideButtonPressed: () {
                                debugPrint("onValideButtonPressed...");
                                context
                                    .read<OfflineSalesStorageCubit>()
                                    .storeOfflineSales(
                                        data: SalesEntity(
                                            date: DateFormat(
                                                    'dd/MM/yyyy HH:mm:ss')
                                                .format(DateTime.now()),
                                            nni: widget.bnf.bnf?.nni ?? "",
                                            benefFirstName:
                                                widget.bnf.bnf?.prenom ?? "",
                                            benefLastName:
                                                widget.bnf.bnf?.nom ?? "",
                                            items:
                                                state.data.entries.map((entry) {
                                              return ItemsEntity(
                                                  id: entry.key.id,
                                                  qte: entry.value);
                                            }).toList()));

                                //update products used quota
                                context
                                    .read<UserCubit>()
                                    .updateUserProductsUsedQuota(
                                        storedSalesItems: state.data.map(
                                            (key, value) =>
                                                MapEntry(key.id!, value)));
                              },
                              // showOtpValidationDialog: () {
                              //   debugPrint('we are here2');
                              //   showDialog(
                              //     context:
                              //         context, // This should be the context where BlocProvider is available
                              //     barrierDismissible: false,
                              //     builder: (dialogContext) {
                              //       return BlocProvider.value(
                              //         value: BlocProvider.of<OtpBloc>(context),
                              //         child: BlocConsumer<OtpBloc, OtpState>(
                              //           listener: (context, state) {
                              //             if (state is SaveSalesSuccess) {
                              //               CustomNavigationHelper.router.pop(true);
                              //             }

                              //             if (state is SaveSalesFailed) {
                              //               //CustomNavigationHelper.router.pop(true);
                              //             }
                              //             // Listener code here
                              //           },
                              //           builder: (context, otpState) {
                              //             return AlertDialog(
                              //                 title: Text(
                              //                   AppLocalizations.of(context)!
                              //                       .sms_validation,
                              //                   // 'Validation SMS',
                              //                   style: TextStyle(
                              //                       fontWeight: FontWeight.bold,
                              //                       fontSize: 16.sp),
                              //                 ),
                              //                 content: SendOtpDialogContent(
                              //                   onVerifyOtp: ({required otp}) {
                              //                     BlocProvider.of<OtpBloc>(context)
                              //                         .add(VerifyOtp(
                              //                       phone: widget.data.bnf?.phone ??
                              //                           "",
                              //                       otp: otp,
                              //                       items: state.data,
                              //                       bnf: widget.data.bnf!,
                              //                       posEntity: context
                              //                           .read<UserCubit>()
                              //                           .state!
                              //                           .user!
                              //                           .pos!,
                              //                     ));
                              //                   },
                              //                   state: otpState,
                              //                 ));
                              //           },
                              //         ),
                              //       );
                              //     },
                              //   ).then((value) {
                              //     if (value == true) {
                              //       CustomNavigationHelper.router.pop(true);
                              //     }
                              //   });
                              //   // showAlertDialog(context,
                              //   //     hasActions: true, title: "validation SMS",
                              //   //     content: SendOtpDialogContent(
                              //   //   onVerifyOtp: ({required otp}) {
                              //   //     BlocProvider.of<OtpBloc>(context).add(VerifyOtp(
                              //   //       phone: widget.data.bnf?.phone ?? "",
                              //   //       otp: otp,
                              //   //       items: state.data,
                              //   //       bnf: widget.data.bnf!,
                              //   //       posEntity: context
                              //   //           .read<UserCubit>()
                              //   //           .state!
                              //   //           .user!
                              //   //           .pos!,
                              //   //     ));
                              //   //   },
                              //   // ));
                              // },
                            );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class PosProductClickableSquaresOffline extends StatelessWidget {
  const PosProductClickableSquaresOffline({
    super.key,
    required this.products,
  });

  final List<ProductsEntity>? products;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: SizedBox(
          height: 130.h,
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
            separatorBuilder: (context, index) => SizedBox(
              width: 30.w,
            ),
            itemCount: products?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              num remainingQuota = (products![index].quotaMonth ?? 0) -
                  (products![index].usedQuota ?? 0);
              return Badge(
                backgroundColor: AppColors.green,
                textColor: AppColors.white,
                label: Text('$remainingQuota'),
                child: GestureDetector(
                  onTap: remainingQuota > 0
                      ? () {
                          context
                              .read<UpdateInvoiceCubit>()
                              .addNewRow(p: products![index]);
                        }
                      : null,
                  child: Card.outlined(
                    child: Container(
                      height: 80.h,
                      width: 80.h,
                      color: AppColors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocBuilder<LanguageCubit, Locale?>(
                            builder: (context, state) {
                              String lang =
                                  state?.countryCode?.toLowerCase() ?? "fr";
                              return Text(
                                lang == "fr"
                                    ? (products![index].title ?? '')
                                    : products![index].titleAr ?? '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.white,
                                      offset: Offset(5.0, 5.0),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          )
                        ],
                      ),

                      // Card(
                      //   child: Image.network(
                      //     data.products![index].image ?? '',
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                    ),
                  ),
                ),
              );
            },
          )

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: rowChildren,
          // ),
          ),
    );
  }
}

class PosVendorInfOffline extends StatelessWidget {
  const PosVendorInfOffline({
    super.key,
    required this.data,
  });

  final PosBnfDataEntity data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        color: Colors.white,
        child: Column(
          spacing: 10.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "${AppLocalizations.of(context)!.name} : ${data.bnf?.nom ?? "--"} ${data.bnf?.prenom ?? "--"}"),
            // Text(
            //     "${AppLocalizations.of(context)!.tell} : ${data.bnf?.phone ?? "--"}"),
          ],
        ),
      ),
    );
  }
}

class PosProductTableOffline extends StatelessWidget {
  const PosProductTableOffline({
    super.key,
    required this.products,
  });

  final List<ProductsEntity>? products;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: LayoutBuilder(builder: (context, constraints) {
        return DataTable(
            showCheckboxColumn: false,
            columnSpacing: constraints.maxWidth / 9,
            columns: <DataColumn>[
              DataColumn(
                label: Text(
                  AppLocalizations.of(context)!.product,
                  //'Produit',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  AppLocalizations.of(context)!.quota,
                  //  'Quota',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  AppLocalizations.of(context)!.quota_used,
                  // 'Consomme',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  AppLocalizations.of(context)!.equart,
                  //'Restant',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: <DataRow>[
              ...products!.map(
                (p) {
                  num remainingQuota = (p.quotaMonth ?? 0) - (p.usedQuota ?? 0);
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(BlocBuilder<LanguageCubit, Locale?>(
                        builder: (context, state) {
                          String lang =
                              state?.countryCode?.toLowerCase() ?? "fr";
                          return Text(lang == "fr"
                              ? (p?.title ?? '--')
                              : (p?.titleAr ?? '--'));
                        },
                      )),
                      DataCell(Text('${p.quotaMonth ?? 0}')),
                      DataCell(Text('${p.usedQuota ?? 0}')),
                      DataCell(Text('$remainingQuota')),
                    ],
                  );
                },
              )
            ]);
      }),
    );
  }
}

class PosProductTableInvoiceOffline extends StatefulWidget {
  const PosProductTableInvoiceOffline({
    super.key,
    required this.productRowData,
    required this.onValideButtonPressed,

    //required this.bnf,
  });

  final Map<ProductsEntity, num> productRowData;
  final VoidCallback onValideButtonPressed;

  @override
  State<PosProductTableInvoiceOffline> createState() =>
      _PosProductTableInvoicOfflineeState();
}

class _PosProductTableInvoicOfflineeState
    extends State<PosProductTableInvoiceOffline> {
  // showAlertDialog(context,
  //     hasActions: true, title: "validation SMS",
  //     content: SendOtpDialogContent(
  //   onVerifyOtp: ({required otp}) {
  //     BlocProvider.of<OtpBloc>(context).add(VerifyOtp(
  //       phone: widget.data.bnf?.phone ?? "",
  //       otp: otp,
  //       items: state.data,
  //       bnf: widget.data.bnf!,
  //       posEntity: context
  //           .read<UserCubit>()
  //           .state!
  //           .user!
  //           .pos!,
  //     ));
  //   },
  // ));

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfflineSalesStorageCubit, OfflineSalesStorageState>(
      listener: (context, state) {
        debugPrint('we are here1');
        if (state is OfflineSalesStorageSuccess) {
          CustomNavigationHelper.router.pop(true);
        }
      },
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is OfflineSalesStorageLoading,
          child: Column(
            spacing: 15.h,
            children: [
              Card(
                color: Colors.white,
                child: LayoutBuilder(builder: (context, constraints) {
                  return Column(
                    children: [
                      DataTable(
                          showCheckboxColumn: false,
                          columnSpacing: constraints.maxWidth / 12,
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text(
                                AppLocalizations.of(context)!.product,
                                //'Produit',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.price,
                                  //  'Prix',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.qte,
                                  //'Qte',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.total,
                                  //'Total',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                          rows: <DataRow>[
                            ...widget.productRowData!.entries.map((p) {
                              num total = (p.key.price ?? 0) * p.value;
                              debugPrint('quota day :${p.key.quotaDay}');
                              debugPrint('quota day value :${p.value}');
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(BlocBuilder<LanguageCubit, Locale?>(
                                    builder: (context, state) {
                                      String lang =
                                          state?.countryCode?.toLowerCase() ??
                                              "fr";
                                      return Text(
                                        lang == "fr"
                                            ? p.key.title ?? '--'
                                            : p.key.titleAr ?? '--',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      );
                                    },
                                  )),
                                  DataCell(Center(
                                      child: Text(
                                    '${p.key.price ?? 0}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))),
                                  DataCell(Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5.h),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Rounded corners
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.remove,
                                                color: Colors.black),
                                            onPressed: (p.value) >
                                                    (p.key.smallestUnit ?? 0)
                                                ? () {
                                                    context
                                                        .read<
                                                            UpdateInvoiceCubit>()
                                                        .decrementQuantity(
                                                            p: p.key);
                                                  }
                                                : () {
                                                    context
                                                        .read<
                                                            UpdateInvoiceCubit>()
                                                        .removeRow(p: p.key);
                                                  },
                                            padding: EdgeInsets.all(4.0),
                                            constraints: BoxConstraints(
                                                minWidth: 20, minHeight: 20),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text(
                                            '${p.value ?? 1}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5.h),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Rounded corners
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.add,
                                                color: Colors.black),
                                            onPressed: (((p.key.quotaMonth ??
                                                                0) -
                                                            (p.key.usedQuota ??
                                                                0))) >
                                                        p.value &&
                                                    p.value <
                                                        (p.key.quotaDay ?? 0)
                                                ? () {
                                                    context
                                                        .read<
                                                            UpdateInvoiceCubit>()
                                                        .incrementQuantity(
                                                            p: p.key);
                                                  }
                                                : null,
                                            padding: EdgeInsets.all(4.0),
                                            constraints: BoxConstraints(
                                                minWidth: 20, minHeight: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )

                                      //   Row(
                                      //   children: [
                                      //     Text('${p.value ?? 1}'),
                                      //   ],
                                      // )

                                      ),
                                  DataCell(Center(
                                      child: Text(
                                    '$total',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))),
                                ],
                              );
                            })
                          ]),
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.beneficaire,
                              // 'Beneficiaire',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget.productRowData.entries.fold(0.0, (total, entry) => total + (entry.key.priceSub ?? 0) * entry.value).round().toStringAsFixed(0)} MRU',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.taazour,
                              // 'TAAZOUR',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${(widget.productRowData.entries.fold(0.0, (total, entry) => total + (entry.key.price ?? 0) * entry.value) - widget.productRowData.entries.fold(0.0, (total, entry) => total + (entry.key.priceSub ?? 0) * entry.value)).round().toStringAsFixed(0)} MRU',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.total_to_pay,
                      //  'Total a payer',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                    Text(
                      '${widget.productRowData.entries.fold(0.0, (total, entry) => total + (entry.key.price ?? 0) * entry.value).round()} MRU',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      text: AppLocalizations.of(context)!.validate,
                      // "Valider",
                      fn: widget.onValideButtonPressed,
                      color: AppColors.green,
                      textColor: AppColors.white,
                      isLoading: state is SendOtpLoading,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
