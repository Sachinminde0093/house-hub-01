// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import '../core/enums.dart';


class UserModel {
    UserModel({
        required this.uid,
        required this.mobile,
        required this.email,
        required this.profilePhoto,
        // required this.coverPhoto,
        this.createdAt,
        // this.updatedAt,
        this.birthdate,
        this.genderCode,
        required this.name,
        // this.username,
        required this.bio,
        this.type,
        // this.campusId,
        this.isVerified = false,
        // this.relation,
        // this.stats,
    });

    String uid;
    String mobile;
    String email;
    String profilePhoto;
    // String coverPhoto;
    DateTime? createdAt;
    // DateTime? updatedAt;
    DateTime? birthdate;
    int? genderCode;
    String name;
    // String? username;
    String bio;
    // String? campusId;
    bool isVerified;
    String? type;
    // UserRelation? relation;
    // UserStats? stats;
    
    bool get isMobileAvailable => mobile.isNotEmpty;
    bool get isEmailAvailable => email.isNotEmpty;
    bool get isBirthdateAvailable => birthdate != null;
    bool get isGenderAvailable => genderCode != null;
    bool get isTypeAvailable => type != null;

    String get gender {
      try {
        // return genderCode!;
        return genders[genderCode!]; 
      } catch (e) {
        return 'Not Available';
      }
    }

    factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["_id"],
        mobile: json["mobile"] == null ? '' : json["mobile"].toString(),
        email: json["email"] ?? '',
        profilePhoto: json["profilePhoto"]?? '',
        // coverPhoto: json["coverPhoto"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        // updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        birthdate: json["birthdate"] == null ? null : DateTime.parse(json["birthdate"]),
        genderCode: json["gender"],
        name: json["name"] ?? '',
        // username: json['username'] == null ? '' : json['username'],
        bio: json['bio'] ?? '',
        // campusId: json['campusId'],
        isVerified: json['isVerified'] ?? false,
        type: json['type'],
        // relation: json['relation'] == null ? null : UserRelation.fromJson(json['relation']),
        // stats: json['stats'] == null ? null : UserStats.fromJson(json['stats']),
    );

    Map<String, dynamic> toJson() => {
        "_id": uid,
        "mobile": mobile,
        "email": email,
        "profilePhoto": profilePhoto,
        // "coverPhoto": coverPhoto,
        "createdAt": createdAt?.toIso8601String(),
        // "updatedAt": updatedAt?.toIso8601String(),
        "birthdate": birthdate?.toIso8601String(),
        "gender": genderCode,
        "name": name,
        // "username": username,
        "isVerified": isVerified,
        "bio": bio,
        'type':type,
        // "campusId": campusId
    };
}

// class UserStats {
//     UserStats({
//         required this.followingCount,
//         required this.followerCount,
//         required this.postCount
//     });

//     int followingCount;
//     int followerCount;
//     int postCount;

//     factory UserStats.fromRawJson(String str) => UserStats.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory UserStats.fromJson(Map<String, dynamic> json) => UserStats(
//         followingCount: json['followingCount'] == null ? 0 : json["followingCount"],
//         followerCount: json['followerCount'] == null ? 0 : json["followerCount"],
//         postCount: json['postCount'] == null ? 0 : json["postCount"],
//     );

//     Map<String, dynamic> toJson() => {

//     };
// }

// class UserRelation {
//     UserRelation({
//         required this.isFollower,
//         required this.isFollowing,
//         required this.isClose,
//         required this.isSubscribed,
//         required this.isBlocked,
//         required this.isSelf,
//     });

//     bool isFollower;
//     bool isFollowing;
//     bool isClose;
//     bool isSubscribed;
//     bool isBlocked;
//     bool isSelf;

//     factory UserRelation.fromRawJson(String str) => UserRelation.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory UserRelation.fromJson(Map<String, dynamic> json) => UserRelation(
//         isFollower: json["isFollower"] == null ? false : json["isFollower"],
//         isFollowing: json["isFollowing"] == null ? false : json["isFollowing"],
//         isClose: json["isClose"] == null ? false : json["isClose"],
//         isSubscribed: json["isSubscribed"] == null ? false : json["isSubscribed"],
//         isBlocked: json["isBlocked"] == null ? false : json["isBlocked"],
//         isSelf: json['isSelf'] ?? false
//     );

//     Map<String, dynamic> toJson() => {
//         "isFollower": isFollower,
//         "isFollowing": isFollowing,
//         "isClose": isClose,
//         "isSubscribed": isSubscribed,
//         "isBlocked": isBlocked,
//     };
// }


