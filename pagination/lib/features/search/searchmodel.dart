class SearchResponse {
  final String kind;
  final Url url;
  final Queries queries;
  final Context context;
  final SearchInformation searchInformation;
  final List<Item> items;

  SearchResponse({
    required this.kind,
    required this.url,
    required this.queries,
    required this.context,
    required this.searchInformation,
    required this.items,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      kind: json['kind'] ?? '',
      url: Url.fromJson(json['url'] ?? {}),
      queries: Queries.fromJson(json['queries'] ?? {}),
      context: Context.fromJson(json['context'] ?? {}),
      searchInformation: SearchInformation.fromJson(json['searchInformation'] ?? {}),
      items: (json['items'] as List<dynamic>?)?.map((item) => Item.fromJson(item)).toList() ?? [],
    );
  }
}

class Url {
  final String type;
  final String template;

  Url({required this.type, required this.template});

  factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
      type: json['type'] ?? '',
      template: json['template'] ?? '',
    );
  }
}

class Queries {
  final List<Request> request;
  final List<Request> nextPage;

  Queries({required this.request, required this.nextPage});

  factory Queries.fromJson(Map<String, dynamic> json) {
    return Queries(
      request: (json['request'] as List<dynamic>?)?.map((item) => Request.fromJson(item)).toList() ?? [],
      nextPage: (json['nextPage'] as List<dynamic>?)?.map((item) => Request.fromJson(item)).toList() ?? [],
    );
  }
}

class Request {
  final String title;
  final String totalResults;
  final String searchTerms;
  final int count;
  final int startIndex;
  final String inputEncoding;
  final String outputEncoding;
  final String safe;
  final String cx;

  Request({
    required this.title,
    required this.totalResults,
    required this.searchTerms,
    required this.count,
    required this.startIndex,
    required this.inputEncoding,
    required this.outputEncoding,
    required this.safe,
    required this.cx,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      title: json['title'] ?? '',
      totalResults: json['totalResults'] ?? '',
      searchTerms: json['searchTerms'] ?? '',
      count: json['count'] ?? 0,
      startIndex: json['startIndex'] ?? 0,
      inputEncoding: json['inputEncoding'] ?? '',
      outputEncoding: json['outputEncoding'] ?? '',
      safe: json['safe'] ?? '',
      cx: json['cx'] ?? '',
    );
  }
}

class Context {
  final String title;

  Context({required this.title});

  factory Context.fromJson(Map<String, dynamic> json) {
    return Context(
      title: json['title'] ?? '',
    );
  }
}

class SearchInformation {
  final double searchTime;
  final String formattedSearchTime;
  final String totalResults;
  final String formattedTotalResults;

  SearchInformation({
    required this.searchTime,
    required this.formattedSearchTime,
    required this.totalResults,
    required this.formattedTotalResults,
  });

  factory SearchInformation.fromJson(Map<String, dynamic> json) {
    return SearchInformation(
      searchTime: (json['searchTime'] ?? 0.0).toDouble(),
      formattedSearchTime: json['formattedSearchTime'] ?? '',
      totalResults: json['totalResults'] ?? '',
      formattedTotalResults: json['formattedTotalResults'] ?? '',
    );
  }
}

class Item {
  final String kind;
  final String title;
  final String htmlTitle;
  final String link;
  final String displayLink;
  final String snippet;
  final String htmlSnippet;
  final String formattedUrl;
  final String htmlFormattedUrl;
  final PageMap pagemap;

  Item({
    required this.kind,
    required this.title,
    required this.htmlTitle,
    required this.link,
    required this.displayLink,
    required this.snippet,
    required this.htmlSnippet,
    required this.formattedUrl,
    required this.htmlFormattedUrl,
    required this.pagemap,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      kind: json['kind'] ?? '',
      title: json['title'] ?? '',
      htmlTitle: json['htmlTitle'] ?? '',
      link: json['link'] ?? '',
      displayLink: json['displayLink'] ?? '',
      snippet: json['snippet'] ?? '',
      htmlSnippet: json['htmlSnippet'] ?? '',
      formattedUrl: json['formattedUrl'] ?? '',
      htmlFormattedUrl: json['htmlFormattedUrl'] ?? '',
      pagemap: PageMap.fromJson(json['pagemap'] ?? {}),
    );
  }
}

class PageMap {
  final List<CseThumbnail> cseThumbnail;
  final List<Metatag> metatags;
  final List<CseImage> cseImage;

  PageMap({
    required this.cseThumbnail,
    required this.metatags,
    required this.cseImage,
  });

  factory PageMap.fromJson(Map<String, dynamic> json) {
    return PageMap(
      cseThumbnail: (json['cse_thumbnail'] as List<dynamic>?)?.map((item) => CseThumbnail.fromJson(item)).toList() ?? [],
      metatags: (json['metatags'] as List<dynamic>?)?.map((item) => Metatag.fromJson(item)).toList() ?? [],
      cseImage: (json['cse_image'] as List<dynamic>?)?.map((item) => CseImage.fromJson(item)).toList() ?? [],
    );
  }
}

class CseThumbnail {
  final String src;
  final String width;
  final String height;

  CseThumbnail({
    required this.src,
    required this.width,
    required this.height,
  });

  factory CseThumbnail.fromJson(Map<String, dynamic> json) {
    return CseThumbnail(
      src: json['src'] ?? '',
      width: json['width'] ?? '',
      height: json['height'] ?? '',
    );
  }
}

class Metatag {
  final String ogImage;
  final String ogType;
  final String ogTitle;
  final String ogDescription;
  final String ogUrl;

  Metatag({
    required this.ogImage,
    required this.ogType,
    required this.ogTitle,
    required this.ogDescription,
    required this.ogUrl,
  });

  factory Metatag.fromJson(Map<String, dynamic> json) {
    return Metatag(
      ogImage: json['og:image'] ?? '',
      ogType: json['og:type'] ?? '',
      ogTitle: json['og:title'] ?? '',
      ogDescription: json['og:description'] ?? '',
      ogUrl: json['og:url'] ?? '',
    );
  }
}

class CseImage {
  final String src;

  CseImage({required this.src});

  factory CseImage.fromJson(Map<String, dynamic> json) {
    return CseImage(
      src: json['src'] ?? '',
    );
  }
}
