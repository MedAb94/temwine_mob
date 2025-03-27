import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Bloc/pos_sales_history_bloc/pos_sales_history_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/language_cubit.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Commons/loader.dart';
import 'package:temwin_front_app/Core/dependency_injection.dart/injections.dart';
import 'package:temwin_front_app/Core/utils/colors.dart';
import 'package:temwin_front_app/Domain/entities/pos_sales_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'fr_FR';
  }

  DateTime? _selectedDate1;
  DateTime? _selectedDate2;

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      locale: Locale('fr'),
      context: context,
      currentDate: DateTime.now(),
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate1) {
      setState(() {
        _selectedDate1 = picked;
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      locale: Locale('fr'),
      context: context,
      currentDate: DateTime.now(),
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate2) {
      setState(() {
        _selectedDate2 = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date); // Format the date
  }

  String _formatDate2(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date); // Format the date
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.history,
            //"History",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: Colors.green,
        ),
        body: BlocProvider(
          create: (context) => sl<PosSalesHistoryBloc>(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 15.h,
            children: [
              BlocBuilder<PosSalesHistoryBloc, PosSalesHistoryState>(
                builder: (context, state) {
                  return AbsorbPointer(
                    absorbing: state is GetPosSaleHistoryLoading,
                    child: Card(
                      color: AppColors.white,
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 5.h,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.start_date,
                                    // "Date de debut"
                                  ),
                                  GestureDetector(
                                    onTap: () => _selectDate1(context),
                                    child: Container(
                                      color: AppColors.grey4,
                                      padding: EdgeInsets.all(10.w)
                                          .copyWith(right: 30.w),
                                      child: Text(_formatDate(
                                          _selectedDate1 ?? DateTime.now())),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 5.h,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.end_date,
                                    //"Date de fin"
                                  ),
                                  GestureDetector(
                                    onTap: () => _selectDate2(context),
                                    child: Container(
                                      color: AppColors.grey4,
                                      padding: EdgeInsets.all(10.w)
                                          .copyWith(right: 30.w),
                                      child: Text(_formatDate(
                                          _selectedDate2 ?? DateTime.now())),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 5.h,
                              children: [
                                Visibility(
                                    visible: false,
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    maintainState: true,
                                    child: Text("hhh")),
                                Container(
                                  color: AppColors.green2,
                                  child: IconButton(
                                    color: AppColors.green2,
                                    icon: Icon(Icons.refresh,
                                        color: Colors.white),
                                    onPressed: () {
                                      context.read<PosSalesHistoryBloc>().add(
                                          GetPosSaleHistory(
                                              date1: _formatDate2(
                                                  _selectedDate1 ??
                                                      DateTime.now()),
                                              date2: _formatDate2(
                                                  _selectedDate2 ??
                                                      DateTime.now())));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<PosSalesHistoryBloc, PosSalesHistoryState>(
                builder: (context, state) {
                  return state is GetPosSaleHistoryLoading
                      ? Loader()
                      : state is GetPosSaleHistorySuccess
                          ? state.data.isEmpty
                              ? Text(
                                  AppLocalizations.of(context)!
                                      .history_is_empty,
                                  //history_is_empty
                                  // "L'historique est vide"
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ExpansionTile(
                                        title: Container(
                                          padding: EdgeInsets.all(
                                              8.0), // Adjust padding as needed
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColors.green2,
                                                Colors.white,
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          child: Text(
                                              '${state.data[index].beneficaire?.prenom ?? '--'} ${state.data[index].beneficaire?.nom ?? '--'}'),
                                        ),
                                        children: <Widget>[
                                          PosSalesLines(
                                            data: state.data[index],
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount: state.data.length,
                                  ),
                                )
                          : Text(
                              AppLocalizations.of(context)!.history_is_empty,
                              // "L'historique est vide"
                            );
                },
              ),
            ],
          ),
        ));
  }
}

class PosSalesLines extends StatelessWidget {
  const PosSalesLines({super.key, required this.data});

  final PosSalesEntity data;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DataTable(
                showCheckboxColumn: false,
                columnSpacing: 0,
                horizontalMargin: 0,
                // columnSpacing: constraints.maxWidth / 1,
                columns: <DataColumn>[
                  DataColumn(
                    label: BlocBuilder<LanguageCubit, Locale?>(
                      builder: (context, state) {
                        String lang = state?.countryCode?.toLowerCase() ?? "fr";
                        return Padding(
                          padding:
                              EdgeInsets.only(right: lang == "fr" ? 0 : 20.w),
                          child: Text(
                            AppLocalizations.of(context)!.product,
                            // 'Produit',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      AppLocalizations.of(context)!.qte,
                      // 'Qte',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      AppLocalizations.of(context)!.total,
                      //'Total',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                rows: <DataRow>[
                  // ...data.lines?.map(line) =>
                  ...data.lines!.map((line) {
                    //num total = (p.key.price ?? 0) * p.value;
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: BlocBuilder<LanguageCubit, Locale?>(
                            builder: (context, state) {
                              String lang =
                                  state?.countryCode?.toLowerCase() ?? "fr";
                              debugPrint("countryCode : $lang");
                              return Padding(
                                padding: EdgeInsets.only(
                                    right: lang == "fr" ? 0 : 20.w),
                                child: Text(
                                  lang == "fr"
                                      ? (line.product?.title ?? '--')
                                      : (line.product?.titleAr ?? '--'),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          ),
                        )),
                        DataCell(SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              '${line.productQnty ?? 0}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                        DataCell(SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              '${line.total ?? 0}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                      ],
                    );
                  })
                ]),
            // SizedBox(
            //   height: 15.h,
            // ),
            Divider(
              color: AppColors.grey3,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.total,
                    // 'Total',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${data.total} MRU',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Divider(
              color: AppColors.grey3,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.reimbursed_amount,
                    //
                    //'Montant rembourse',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${(data.total ?? 0) - (data.totalSub ?? 0).round()} MRU',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      );
    });
  }
}
