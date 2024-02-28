// To parse this JSON data, do
//
//     final channelObj = channelObjFromJson(jsonString);

import 'dart:convert';

ChannelObj channelObjFromJson(String str) =>
    ChannelObj.fromJson(json.decode(str));

String channelObjToJson(ChannelObj data) => json.encode(data.toJson());

class ChannelObj {
  ChannelObj({
    required this.name,
    required this.logo,
    required this.url,
    required this.categories,
    required this.countries,
    required this.languages,
  });

  String name;
  String logo;
  String url;
  List<String> categories;
  List<String> countries;
  List<String> languages;

  factory ChannelObj.fromJson(Map<String, dynamic> json) => ChannelObj(
        name: json["name"] ?? "",
        logo: json["logo"] ?? "",
        url: json["website"] ?? "",
        countries: List<String>.from(json['broadcast_area']),
        languages: List<String>.from(json['languages']),
        categories: List<String>.from(json['categories']),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
        "website": url,
        "categories": List<String>.from(categories),
        "broadcast_area": List<String>.from(countries),
        "languages": List<String>.from(languages),
      };
}
