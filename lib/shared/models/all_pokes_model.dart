import 'dart:convert';

class AllPokesModel {
  int? count;
  String? next;
  String? previous;
  List<Result>? results;

  AllPokesModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  AllPokesModel copyWith({
    int? count,
    String? next,
    String? previous,
    List<Result>? results,
  }) =>
      AllPokesModel(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory AllPokesModel.fromJson(String str) =>
      AllPokesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllPokesModel.fromMap(Map<String, dynamic> json) => AllPokesModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Result>.from(json["results"]!.map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toMap())),
      };
}

class Result {
  String? name;
  String? url;

  Result({
    this.name,
    this.url,
  });

  Result copyWith({
    String? name,
    String? url,
  }) =>
      Result(
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}
