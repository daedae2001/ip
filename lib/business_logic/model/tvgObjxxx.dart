// To parse this JSON data, do
//
//     final tvgObj = tvgObjFromJson(jsonString);

import 'dart:convert';

TvgObj tvgObjFromJson(String str) => TvgObj.fromJson(json.decode(str));

String tvgObjToJson(TvgObj data) => json.encode(data.toJson());

class TvgObj {
  TvgObj({
    this.id,
    this.name,
    this.url,
  });

  String? id;
  String? name;
  String? url;

  factory TvgObj.fromJson(Map<String, dynamic> json) => TvgObj(
        id: json["id"] ?? "sin id",
        name: json["name"] ?? "sin nombre",
        url: json["url"] ??
            "https://upload.wikimedia.org/wikipedia/commons/f/f2/SiN_Logo.png",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
      };
}
