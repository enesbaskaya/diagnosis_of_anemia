import 'package:cloud_firestore/cloud_firestore.dart';

enum AnemiTypes { type1, type2, type3 }

extension AnemiTypesEx on AnemiTypes {
  String get getName {
    switch (this) {
      case AnemiTypes.type1:
        return "Anemi Testi 1";
      case AnemiTypes.type2:
        return "Anemi Testi 2";
      case AnemiTypes.type3:
        return "Anemi Testi 3";
      default:
        return "NULL";
    }
  }
}

class Anemi {
  double? rbc;
  double? hgb;
  double? hct;
  double? mcv;
  double? mch;
  double? mchc;
  String? uid;
  String? type;
  bool? result;
  Timestamp? date;

  Anemi({
    required this.rbc,
    required this.hgb,
    required this.hct,
    required this.mcv,
    required this.mch,
    required this.mchc,
    required this.uid,
    required this.type,
    required this.result,
    required this.date,
  });

  Anemi.fromJson(Map<String, dynamic> json)
      : this(
          rbc: json['rbc'] as double,
          hgb: json['hgb'] as double,
          hct: json['hct'] as double,
          mcv: json['mcv'] as double,
          mch: json['mch'] as double,
          mchc: json['mchc'] as double,
          uid: json['uid'] as String,
          type: json['type'] as String,
          result: json['result'] as bool,
          date: json['date'] as Timestamp,
        );
  Map<String, dynamic> toJson() {
    return {
      'rbc': rbc,
      'hgb': hgb,
      'hct': hct,
      'mcv': mcv,
      'mch': mch,
      'mchc': mchc,
      'uid': uid,
      'type': type,
      'result': result,
      'date': date,
    };
  }
}
