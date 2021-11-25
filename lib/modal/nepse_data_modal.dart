class NepseDataModal {
  bool success;
  String message;
  Data data;

  NepseDataModal({this.success, this.message, this.data});

  NepseDataModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<HomeTable> homeTable;
  String date;

  Data({this.homeTable, this.date});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['home_table'] != null) {
      homeTable = new List<HomeTable>();
      json['home_table'].forEach((v) {
        homeTable.add(new HomeTable.fromJson(v));
      });
    }
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.homeTable != null) {
      data['home_table'] = this.homeTable.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    return data;
  }
}

class HomeTable {
  int id;
  String indexName;
  String fullName;
  String turnoverValues;
  String dailyGain;
  String totalPositiveGainer;
  String totalNegativeGainer;
  String pe;
  Null peFwd;
  String pb;
  String peg;
  String roe;
  String alpha;
  String beta;
  String sharpeRatio;
  String macd;
  String rsi;
  Null n50200Sma;
  Null investors;
  Null seasonalInvestors;
  Null traders;
  String createdAt;
  Null updatedAt;
  String yearlyPercentChange;
  String macdsignal;
  String sma200;
  String ltp;
  String totalDividendYield;
  String roa;
  int orders;
  Sparkline sparkline;
  Indexvalue indexvalue;

  HomeTable(
      {this.id,
        this.indexName,
        this.fullName,
        this.turnoverValues,
        this.dailyGain,
        this.totalPositiveGainer,
        this.totalNegativeGainer,
        this.pe,
        this.peFwd,
        this.pb,
        this.peg,
        this.roe,
        this.alpha,
        this.beta,
        this.sharpeRatio,
        this.macd,
        this.rsi,
        this.n50200Sma,
        this.investors,
        this.seasonalInvestors,
        this.traders,
        this.createdAt,
        this.updatedAt,
        this.yearlyPercentChange,
        this.macdsignal,
        this.sma200,
        this.ltp,
        this.totalDividendYield,
        this.roa,
        this.orders,
        this.sparkline,
        this.indexvalue});

  HomeTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    indexName = json['index_name'];
    fullName = json['full_name'];
    turnoverValues = json['turnover_values'];
    dailyGain = json['daily_gain'];
    totalPositiveGainer = json['total_positive_gainer'];
    totalNegativeGainer = json['total_negative_gainer'];
    pe = json['pe'];
    peFwd = json['pe_fwd'];
    pb = json['pb'];
    peg = json['peg'];
    roe = json['roe'];
    alpha = json['alpha'];
    beta = json['beta'];
    sharpeRatio = json['sharpe_ratio'];
    macd = json['macd'];
    rsi = json['rsi'];
    n50200Sma = json['_50_200_sma'];
    investors = json['investors'];
    seasonalInvestors = json['seasonal_investors'];
    traders = json['traders'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    yearlyPercentChange = json['yearly_percent_change'];
    macdsignal = json['macdsignal'];
    sma200 = json['sma_200'];
    ltp = json['ltp'];
    totalDividendYield = json['total_dividend_yield'];
    roa = json['roa'];
    orders = json['orders'];
    sparkline = json['sparkline'] != null
        ? new Sparkline.fromJson(json['sparkline'])
        : null;
    indexvalue = json['indexvalue'] != null
        ? new Indexvalue.fromJson(json['indexvalue'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['index_name'] = this.indexName;
    data['full_name'] = this.fullName;
    data['turnover_values'] = this.turnoverValues;
    data['daily_gain'] = this.dailyGain;
    data['total_positive_gainer'] = this.totalPositiveGainer;
    data['total_negative_gainer'] = this.totalNegativeGainer;
    data['pe'] = this.pe;
    data['pe_fwd'] = this.peFwd;
    data['pb'] = this.pb;
    data['peg'] = this.peg;
    data['roe'] = this.roe;
    data['alpha'] = this.alpha;
    data['beta'] = this.beta;
    data['sharpe_ratio'] = this.sharpeRatio;
    data['macd'] = this.macd;
    data['rsi'] = this.rsi;
    data['_50_200_sma'] = this.n50200Sma;
    data['investors'] = this.investors;
    data['seasonal_investors'] = this.seasonalInvestors;
    data['traders'] = this.traders;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['yearly_percent_change'] = this.yearlyPercentChange;
    data['macdsignal'] = this.macdsignal;
    data['sma_200'] = this.sma200;
    data['ltp'] = this.ltp;
    data['total_dividend_yield'] = this.totalDividendYield;
    data['roa'] = this.roa;
    data['orders'] = this.orders;
    if (this.sparkline != null) {
      data['sparkline'] = this.sparkline.toJson();
    }
    if (this.indexvalue != null) {
      data['indexvalue'] = this.indexvalue.toJson();
    }
    return data;
  }
}

class Sparkline {
  String current;
  num time;

  Sparkline({this.current, this.time});

  Sparkline.fromJson(Map<String, dynamic> json) {
    current = json['current'].cast<String>();
    time = json['time'].cast<num>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current'] = this.current;
    data['time'] = this.time;
    return data;
  }
}

class Indexvalue {
  String formattedIndex;
  String current;
  String percentChange;
  String turnOverValue;

  Indexvalue(
      {this.formattedIndex,
        this.current,
        this.percentChange,
        this.turnOverValue});

  Indexvalue.fromJson(Map<String, dynamic> json) {
    formattedIndex = json['formatted_index'];
    current = json['current'];
    percentChange = json['percent_change'];
    turnOverValue = json['turn_over_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formatted_index'] = this.formattedIndex;
    data['current'] = this.current;
    data['percent_change'] = this.percentChange;
    data['turn_over_value'] = this.turnOverValue;
    return data;
  }
}