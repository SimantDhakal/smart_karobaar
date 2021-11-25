class HomeGraphModal {
  Sparkline sparkline;
  HomeGraphModal({this.sparkline});

  HomeGraphModal.fromJson(Map<String, dynamic> json) {
    sparkline = json['sparkline'] != null
        ? new Sparkline.fromJson(json['sparkline'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sparkline != null) {
      data['sparkline'] = this.sparkline.toJson();
    }
    return data;
  }
}

class Sparkline {
  List<String> current;
  List<String> time;

  Sparkline({this.current, this.time});

  Sparkline.fromJson(Map<String, dynamic> json) {
    current = json['current'].cast<String>();
    time = json['time'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current'] = this.current;
    data['time'] = this.time;
    return data;
  }
}