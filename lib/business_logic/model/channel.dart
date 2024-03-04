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
        name: json["tvg-name"] ?? "sin nombre",
        logo: json["tvg-logo"] ??
            "https://upload.wikimedia.org/wikipedia/commons/f/f2/SiN_Logo.png",
        url: json["url"] ??
            "https://upload.wikimedia.org/wikipedia/commons/f/f2/SiN_Logo.png",
        countries: [json['group-title']],
        languages: ['Es'],
        categories: [json['group-title']],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
        "website": url,
        "categories": categories,
        "broadcast_area": countries,
        "languages": languages,
      };
}
