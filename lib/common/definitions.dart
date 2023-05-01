import 'package:shared_preferences/shared_preferences.dart';

class Definitions {
  //static String api_url = "https://billsasa.co.ke/api/";
  //static String api_url = "http://192.168.220.104/BILL_SASA_BACKUP/public/api/";
  //static String api_url = "http://192.168.100.13/BILL_SASA_BACKUP/public/api/";
  //static String api_url = "http://172.20.10.8/BILL_SASA_BACKUP/public/api/";
  //static String api_url = "http://192.168.100.14/BILL_SASA_BACKUP/public/api/";
  //static String api_url = "http://192.168.220.223/BILL_SASA_BACKUP/public/api/";
  static String api_url = "https://api.domartservices.co.ke/api/";
  //static String api_url = "http://f16821775b77.ngrok.io/api/";
  static String endpoint_login = "login";
  static String endpoint_register = "register";
  static String book_ticket = "book_ticket";
  static
  String endpoint_profile = "profile";
  static String endpoint_update = "update";
  static String endpoint_create_type = "create_type";
  static String endpoint_get_types = "get_types";
  static String endpoint_create_group = "create_group";
  static String endpoint_my_groups = "my_groups";
  static String endpoint_explore_groups = "explore_groups";
  static String endpoint_add_config = "add_config";
  static String endpoint_update_config = "update_config";
  static String endpoint_fetch_config = "fetch_config";
  static String endpoint_initiate_pmt = "initiate_pmt";
  static String endpoint_mobilemoney = "mobilemoney";
  static String endpoint_notification = "set_push_notification_token";
  static String endpoint_stk = "stk";
  static String endpoint_mpesa_stk = "stk_mpesa";
  static String endpoint_confirm_stk = "confirm-stk";
  static String endpoint_creditcard = "creditcard";
  static String app_token = "#@BillS@s@^&&";
  static String request_fname = "first_name";
  static String request_lname = "last_name";
  static String request_phoneno = "phone_number";
  static String request_amount = "amount";
  static String request_email = "email";
  static String request_currency = "currency";
  static String request_description = "description";
  static String request_ksh = "KES";

  static final String serverToken = 'AIzaSyDeOXKv15mibnYuBP_KqK2D0SmVVP_mZVo';

  static final TOPUP_FLEXI = 'TopupFlexi';
  static final BILL_PAY = 'BillPay';
  static final TOPUP_FIX = 'TopupFix';
  static final VOUCHER_FLEXI = 'VoucherFlexi';
  static final VOUCHER_FIX = 'VoucherFix';
  static final SAFARICOM = 'SAFARICOM';
  static final TELKOM = 'TELKOM';
  static final AIRTEL = 'AIRTEL';
  static final KPLC = 'KPLC';
  static final NAIROBI_WTR = 'NAIROBI_WTR';
  static final GOTV = 'GOTV';
  static final DSTV = 'DSTV';
  static final ZUKU = 'ZUKU';
  static final STARTIMES = 'STARTIMES';

}

class Payments {
  final String created_at;
  final String amount_billed;
  final String status;
  //final int status;
  final String message;
  final String channel;
  final String sid;

  Payments(
      {this.created_at,
      this.amount_billed,
      this.status,
      this.message,
      this.channel,
      this.sid});

  factory Payments.fromJson(dynamic json) {
    return Payments(
      created_at: json['created_at'] as String,
      amount_billed: json['amount_billed'] as String,
      status: json['status'] as String,
      //status: json['status'] as int,
      message: json['message'] as String,
      channel: json['channel'] as String,
      sid: json['sid'] as String,
    );
  }

  @override
  String toString() {
    return '{'
        ' ${this.created_at}, '
        ' ${this.amount_billed}, '
        ' ${this.status}, '
        ' ${this.message}, '
        ' ${this.channel}, '
        ' ${this.sid}, '
        '}';
  }
}
