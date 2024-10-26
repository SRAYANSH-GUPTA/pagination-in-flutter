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
      kind: json['kind'],
      url: Url.fromJson(json['url']),
      queries: Queries.fromJson(json['queries']),
      context: Context.fromJson(json['context']),
      searchInformation: SearchInformation.fromJson(json['searchInformation']),
      items: List<Item>.from(json['items'].map((item) => Item.fromJson(item))),
    );
  }
}

class Url {
  final String type;
  final String template;

  Url({
    required this.type,
    required this.template,
  });

  factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
      type: json['type'],
      template: json['template'],
    );
  }
}

class Queries {
  final List<Request> request;

  Queries({
    required this.request,
  });

  factory Queries.fromJson(Map<String, dynamic> json) {
    return Queries(
      request: List<Request>.from(
          json['request'].map((item) => Request.fromJson(item))),
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
      title: json['title'],
      totalResults: json['totalResults'],
      searchTerms: json['searchTerms'],
      count: json['count'],
      startIndex: json['startIndex'],
      inputEncoding: json['inputEncoding'],
      outputEncoding: json['outputEncoding'],
      safe: json['safe'],
      cx: json['cx'],
    );
  }
}

class Context {
  final String title;
  final List<List<Facet>> facets;

  Context({
    required this.title,
    required this.facets,
  });

  factory Context.fromJson(Map<String, dynamic> json) {
    return Context(
      title: json['title'],
      facets: (json['facets'] as List).map((facetList) {
        return List<Facet>.from(
            facetList.map((facet) => Facet.fromJson(facet)));
      }).toList(),
    );
  }
}

class Facet {
  final String anchor;
  final String label;
  final String labelWithOp;

  Facet({
    required this.anchor,
    required this.label,
    required this.labelWithOp,
  });

  factory Facet.fromJson(Map<String, dynamic> json) {
    return Facet(
      anchor: json['anchor'],
      label: json['label'],
      labelWithOp: json['label_with_op'],
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
      searchTime: json['searchTime'].toDouble(),
      formattedSearchTime: json['formattedSearchTime'],
      totalResults: json['totalResults'],
      formattedTotalResults: json['formattedTotalResults'],
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
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      kind: json['kind'],
      title: json['title'],
      htmlTitle: json['htmlTitle'],
      link: json['link'],
      displayLink: json['displayLink'],
      snippet: json['snippet'],
      htmlSnippet: json['htmlSnippet'],
      formattedUrl: json['formattedUrl'],
      htmlFormattedUrl: json['htmlFormattedUrl'],
    );
  }
}