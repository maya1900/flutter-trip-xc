// To parse this JSON data, do
//
//     final travelModel = travelModelFromJson(jsonString);

import 'dart:convert';

TravelModel? travelModelFromJson(String str) => TravelModel.fromJson(json.decode(str));

String travelModelToJson(TravelModel? data) => json.encode(data!.toJson());

class TravelModel {
  TravelModel({
    this.totalCount,
    this.resultList,
  });

  int? totalCount;
  List<TravelItem?>? resultList;

  factory TravelModel.fromJson(Map<String, dynamic> json) => TravelModel(
    totalCount: json["totalCount"],
    resultList: json["resultList"] == null ? [] : List<TravelItem?>.from(json["resultList"]!.map((x) => TravelItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "resultList": resultList == null ? [] : List<dynamic>.from(resultList!.map((x) => x!.toJson())),
  };
}

class TravelItem {
  TravelItem({
    this.type,
    this.article,
  });

  int? type;
  Article? article;

  factory TravelItem.fromJson(Map<String, dynamic> json) => TravelItem(
    type: json["type"],
    article: Article.fromJson(json["article"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "article": article!.toJson(),
  };
}

class Article {
  Article({
    this.articleId,
    this.productType,
    this.articleTitle,
    this.content,
    this.author,
    this.images,
    this.hasVideo,
    this.likeCount,
    this.commentCount,
    this.urls,
    this.pois,
    this.publishTime,
    this.publishTimeDisplay,
    this.shootTime,
    this.shootTimeDisplay,
    this.distanceText,
    this.isLike,
    this.imageCounts,
    this.isCollected,
    this.collectCount,
    this.articleStatus,
    this.poiName,
    this.shareInfo,
    this.videoAutoplayNet,
    this.combinateContent,
    this.combinedTitle,
    this.ambitious,
    this.video,
    this.indigo,
    this.tentacled,
    this.purple,
    this.article,
    this.magenta,
    this.frisky,
    this.indecent,
    this.fluffy,
    this.cunning,
    this.mischievous,
    this.empty,
    this.hilarious,
    this.sticky,
    this.i,
    this.mFine,
  });

  int? articleId;
  int? productType;
  String? articleTitle;
  String? content;
  Author? author;
  List<ImageList?>? images;
  bool? hasVideo;
  int? likeCount;
  int? commentCount;
  List<Url?>? urls;
  List<Pois?>? pois;
  String? publishTime;
  String? publishTimeDisplay;
  String? shootTime;
  String? shootTimeDisplay;
  String? distanceText;
  bool? isLike;
  int? imageCounts;
  bool? isCollected;
  int? collectCount;
  int? articleStatus;
  String? poiName;
  ShareInfo? shareInfo;
  String? videoAutoplayNet;
  String? combinateContent;
  String? combinedTitle;
  String? ambitious;
  Video? video;
  String? indigo;
  String? tentacled;
  String? purple;
  String? article;
  String? magenta;
  String? frisky;
  String? indecent;
  String? fluffy;
  String? cunning;
  String? mischievous;
  String? empty;
  String? hilarious;
  String? sticky;
  String? i;
  String? mFine;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    articleId: json["articleId"],
    productType: json["productType"],
    articleTitle: json["articleTitle"],
    content: json["content"],
    author: Author.fromJson(json["author"]),
    images: json["images"] == null ? [] : json["images"] == null ? [] : List<ImageList?>.from(json["images"]!.map((x) => ImageList.fromJson(x))),
    hasVideo: json["hasVideo"],
    likeCount: json["likeCount"],
    commentCount: json["commentCount"],
    urls: json["urls"] == null ? [] : json["urls"] == null ? [] : List<Url?>.from(json["urls"]!.map((x) => Url.fromJson(x))),
    pois: json["pois"] == null ? [] : json["pois"] == null ? [] : List<Pois?>.from(json["pois"]!.map((x) => Pois.fromJson(x))),
    publishTime: json["publishTime"],
    publishTimeDisplay: json["publishTimeDisplay"],
    shootTime: json["shootTime"],
    shootTimeDisplay: json["shootTimeDisplay"],
    distanceText: json["distanceText"],
    isLike: json["isLike"],
    imageCounts: json["imageCounts"],
    isCollected: json["isCollected"],
    collectCount: json["collectCount"],
    articleStatus: json["articleStatus"],
    poiName: json["poiName"],
    shareInfo: json["shareInfo"] == null ? null : ShareInfo.fromJson(json["shareInfo"]),
    videoAutoplayNet: json["videoAutoplayNet"],
    combinateContent: json["combinateContent"],
    combinedTitle: json["combinedTitle"],
    ambitious: json["西树泡芙"],
    video: json["video"] == null ? null : Video.fromJson(json["video"]),
    indigo: json["气"],
    tentacled: json["四大名园"],
    purple: json["入趣"],
    article: json["临碧"],
    magenta: json["酌泉漱玉"],
    frisky: json["风暖鸟声碎，日高花影重"],
    indecent: json["淡著烟云轻著柳，竹边台榭水边亭"],
    fluffy: json["半槛泉声三径月，一亭诗境满湖云"],
    cunning: json["这是个奇迹，给人以美好的幻觉。"],
    mischievous: json["风雨同舟"],
    empty: json["上海方舟"],
    hilarious: json["美丽人生"],
    sticky: json["总有人山高路远为你而来"],
    i: json["I"],
    mFine: json["m fine兔"],
  );

  Map<String, dynamic> toJson() => {
    "articleId": articleId,
    "productType": productType,
    "articleTitle": articleTitle,
    "content": content,
    "author": author,
    "images": images == null ? [] : images == null ? [] : List<dynamic>.from(images!.map((x) => x!.toJson())),
    "hasVideo": hasVideo,
    "likeCount": likeCount,
    "commentCount": commentCount,
    "urls": urls == null ? [] : urls == null ? [] : List<dynamic>.from(urls!.map((x) => x!.toJson())),
    "pois": pois == null ? [] : pois == null ? [] : List<dynamic>.from(pois!.map((x) => x!.toJson())),
    "publishTime": publishTime,
    "publishTimeDisplay": publishTimeDisplay,
    "shootTime": shootTime,
    "shootTimeDisplay": shootTimeDisplay,
    "distanceText": distanceText,
    "isLike": isLike,
    "imageCounts": imageCounts,
    "isCollected": isCollected,
    "collectCount": collectCount,
    "articleStatus": articleStatus,
    "poiName": poiName,
    "shareInfo": shareInfo,
    "videoAutoplayNet": videoAutoplayNet,
    "combinateContent": combinateContent,
    "combinedTitle": combinedTitle,
    "西树泡芙": ambitious,
    "video": video,
    "气": indigo,
    "四大名园": tentacled,
    "入趣": purple,
    "临碧": article,
    "酌泉漱玉": magenta,
    "风暖鸟声碎，日高花影重": frisky,
    "淡著烟云轻著柳，竹边台榭水边亭": indecent,
    "半槛泉声三径月，一亭诗境满湖云": fluffy,
    "这是个奇迹，给人以美好的幻觉。": cunning,
    "风雨同舟": mischievous,
    "上海方舟": empty,
    "美丽人生": hilarious,
    "总有人山高路远为你而来": sticky,
    "I": i,
    "m fine兔": mFine,
  };
}

class Author {
  Author({
    this.nickName,
    this.clientAuth,
    this.userUrl,
    this.jumpUrl,
    this.coverImage,
    this.identityType,
    this.identityTypeName,
    this.isFollow,
    this.vIcon,
    this.identityDesc,
    this.isStarAccount,
    this.showTagList,
    this.avatarDecoration,
  });

  String? nickName;
  String? clientAuth;
  String? userUrl;
  String? jumpUrl;
  ImageList? coverImage;
  int? identityType;
  String? identityTypeName;
  bool? isFollow;
  String? vIcon;
  String? identityDesc;
  bool? isStarAccount;
  List<ShowTagList?>? showTagList;
  AvatarDecoration? avatarDecoration;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    nickName: json["nickName"],
    clientAuth: json["clientAuth"],
    userUrl: json["userUrl"],
    jumpUrl: json["jumpUrl"],
    coverImage: ImageList.fromJson(json["coverImage"]),
    identityType: json["identityType"],
    identityTypeName: json["identityTypeName"],
    isFollow: json["isFollow"],
    vIcon: json["vIcon"],
    identityDesc: json["identityDesc"],
    isStarAccount: json["isStarAccount"],
    showTagList: json["showTagList"] == null ? [] : List<ShowTagList?>.from(json["showTagList"]!.map((x) => ShowTagList.fromJson(x))),
    avatarDecoration: json["avatarDecoration"] != null ? AvatarDecoration.fromJson(json["avatarDecoration"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "nickName": nickName,
    "clientAuth": clientAuth,
    "userUrl": userUrl,
    "jumpUrl": jumpUrl,
    "coverImage": coverImage!.toJson(),
    "identityType": identityType,
    "identityTypeName": identityTypeName,
    "isFollow": isFollow,
    "vIcon": vIcon,
    "identityDesc": identityDesc,
    "isStarAccount": isStarAccount,
    "showTagList": showTagList == null ? [] : List<dynamic>.from(showTagList!.map((x) => x!.toJson())),
    "avatarDecoration": avatarDecoration,
  };
}

class AvatarDecoration {
  AvatarDecoration({
    this.svga,
    this.webp,
    this.png,
  });

  String? svga;
  String? webp;
  String? png;

  factory AvatarDecoration.fromJson(Map<String, dynamic> json) => AvatarDecoration(
    svga: json["svga"],
    webp: json["webp"],
    png: json["png"],
  );

  Map<String, dynamic> toJson() => {
    "svga": svga,
    "webp": webp,
    "png": png,
  };
}

class ImageList {
  ImageList({
    this.imageId,
    this.dynamicUrl,
    this.width,
    this.height,
    this.originalUrl,
  });

  int? imageId;
  String? dynamicUrl;
  double? width;
  double? height;
  String? originalUrl;

  factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
    imageId: json["imageId"],
    dynamicUrl: json["dynamicUrl"],
    width: json["width"],
    height: json["height"],
    originalUrl: json["originalUrl"],
  );

  Map<String, dynamic> toJson() => {
    "imageId": imageId,
    "dynamicUrl": dynamicUrl,
    "width": width,
    "height": height,
    "originalUrl": originalUrl,
  };
}

class ShowTagList {
  ShowTagList({
    this.tagStyle,
    this.tagName,
    this.tagStyleMap,
  });

  int? tagStyle;
  String? tagName;
  TagStyleMap? tagStyleMap;

  factory ShowTagList.fromJson(Map<String, dynamic> json) => ShowTagList(
    tagStyle: json["tagStyle"],
    tagName: json["tagName"],
    tagStyleMap: TagStyleMap.fromJson(json["tagStyleMap"]),
  );

  Map<String, dynamic> toJson() => {
    "tagStyle": tagStyle,
    "tagName": tagName,
    "tagStyleMap": tagStyleMap!.toJson(),
  };
}

class TagStyleMap {
  TagStyleMap({
    this.white,
    this.black,
  });

  Black? white;
  Black? black;

  factory TagStyleMap.fromJson(Map<String, dynamic> json) => TagStyleMap(
    white: Black.fromJson(json["white"]),
    black: Black.fromJson(json["black"]),
  );

  Map<String, dynamic> toJson() => {
    "white": white!.toJson(),
    "black": black!.toJson(),
  };
}

class Black {
  Black({
    this.tagStyleFont,
    this.tagStyleBack,
    this.tagStyleBackArgb,
  });

  TagStyleFont? tagStyleFont;
  TagStyleBack? tagStyleBack;
  TagStyleBackArgb? tagStyleBackArgb;

  factory Black.fromJson(Map<String, dynamic> json) => Black(
    tagStyleFont: tagStyleFontValues!.map[json["tagStyleFont"]],
    tagStyleBack: tagStyleBackValues!.map[json["tagStyleBack"]],
    tagStyleBackArgb: tagStyleBackArgbValues!.map[json["tagStyleBackARGB"]],
  );

  Map<String, dynamic> toJson() => {
    "tagStyleFont": tagStyleFontValues.reverse![tagStyleFont],
    "tagStyleBack": tagStyleBackValues.reverse![tagStyleBack],
    "tagStyleBackARGB": tagStyleBackArgbValues.reverse![tagStyleBackArgb],
  };
}

enum TagStyleBack { THE_4_F310080, CC840814 }

final tagStyleBackValues = EnumValues({
  "#CC840814": TagStyleBack.CC840814,
  "#4F310080": TagStyleBack.THE_4_F310080
});

enum TagStyleBackArgb { THE_804_F3100, THE_14_CC8408 }

final tagStyleBackArgbValues = EnumValues({
  "#14CC8408": TagStyleBackArgb.THE_14_CC8408,
  "#804F3100": TagStyleBackArgb.THE_804_F3100
});

enum TagStyleFont { FFC054, CC8408 }

final tagStyleFontValues = EnumValues({
  "#CC8408": TagStyleFont.CC8408,
  "#FFC054": TagStyleFont.FFC054
});

class Pois {
  Pois({
    this.poiType,
    this.poiId,
    this.poiName,
    this.businessId,
    this.districtId,
    this.poiExt,
    this.districtName,
    this.countryName,
  });

  int? poiType;
  int? poiId;
  String? poiName;
  int? businessId;
  int? districtId;
  PoiExt? poiExt;
  String? districtName;
  String? countryName;

  factory Pois.fromJson(Map<String, dynamic> json) => Pois(
    poiType: json["poiType"],
    poiId: json["poiId"],
    poiName: json["poiName"],
    businessId: json["businessId"],
    districtId: json["districtId"],
    poiExt: PoiExt.fromJson(json["poiExt"]),
    districtName: json["districtName"],
    countryName: json["countryName"] ?? '中国',
  );

  Map<String, dynamic> toJson() => {
    "poiType": poiType,
    "poiId": poiId,
    "poiName": poiName,
    "businessId": businessId,
    "districtId": districtId,
    "poiExt": poiExt!.toJson(),
    "districtName": districtName,
    "countryName": countryName,
  };
}

enum CountryName { EMPTY }

final countryNameValues = EnumValues({
  "中国": CountryName.EMPTY
});

class PoiExt {
  PoiExt({
    this.h5Url,
    this.appUrl,
  });

  String? h5Url;
  String? appUrl;

  factory PoiExt.fromJson(Map<String, dynamic> json) => PoiExt(
    h5Url: json["h5Url"],
    appUrl: json["appUrl"],
  );

  Map<String, dynamic> toJson() => {
    "h5Url": h5Url,
    "appUrl": appUrl,
  };
}

class ShareInfo {
  ShareInfo({
    this.imageUrl,
    this.shareTitle,
    this.token,
  });

  String? imageUrl;
  String? shareTitle;
  String? token;

  factory ShareInfo.fromJson(Map<String, dynamic> json) => ShareInfo(
    imageUrl: json["imageUrl"],
    shareTitle: json["shareTitle"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "shareTitle": shareTitle,
    "token": token,
  };
}

class Url {
  Url({
    this.version,
    this.appUrl,
    this.h5Url,
    this.wxUrl,
  });

  Version? version;
  String? appUrl;
  String? h5Url;
  String? wxUrl;

  factory Url.fromJson(Map<String, dynamic> json) => Url(
    version: versionValues!.map[json["version"]],
    appUrl: json["appUrl"],
    h5Url: json["h5Url"],
    wxUrl: json["wxUrl"],
  );

  Map<String, dynamic> toJson() => {
    "version": versionValues.reverse![version],
    "appUrl": appUrl,
    "h5Url": h5Url,
    "wxUrl": wxUrl,
  };
}

enum Version { ARTICLE, TRIP_SHOOT, TRIP_SHOOT2 }

final versionValues = EnumValues({
  "article": Version.ARTICLE,
  "tripShoot": Version.TRIP_SHOOT,
  "tripShoot2": Version.TRIP_SHOOT2
});

class Video {
  Video({
    this.videoId,
    this.coverImageUrl,
    this.videoUrl,
    this.width,
    this.height,
    this.durationSeconds,
  });

  int? videoId;
  String? coverImageUrl;
  String? videoUrl;
  double? width;
  double? height;
  int? durationSeconds;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    videoId: json["videoId"],
    coverImageUrl: json["coverImageUrl"],
    videoUrl: json["videoUrl"],
    width: json["width"],
    height: json["height"],
    durationSeconds: json["durationSeconds"],
  );

  Map<String, dynamic> toJson() => {
    "videoId": videoId,
    "coverImageUrl": coverImageUrl,
    "videoUrl": videoUrl,
    "width": width,
    "height": height,
    "durationSeconds": durationSeconds,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
