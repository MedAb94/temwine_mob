class EndPoint {
  static const String devBaseUrl = "https://medex.mr/temwine-bk/public/api";
  static const String prodBaseUrl = "http://temwin.taazour.mr/api";

  static const String baseUrl = prodBaseUrl;
  //

  //auth
  static const String authSignInUrl = "$baseUrl/login";
  static const String authSignOutUrl = "$baseUrl/logout";
  static const String authRefreshUrl = "$baseUrl/refresh";

  //Vendor
  static const String verifyBnfUrl = "$baseUrl/verify_bnf";
  static const String sendOtpfUrl = "$baseUrl/send-otp";
  static const String verifyOtpUrl = "$baseUrl/verify-otp";
  static const String saveSalesUrl = "$baseUrl/save_sale";
  static String posSalesUrl({required String date1, required String date2}) =>
      "$baseUrl/pos_sales/4/$date1/$date2";

  static const String syncOfflineSalesUrl = "$baseUrl/synchronisations";
}
