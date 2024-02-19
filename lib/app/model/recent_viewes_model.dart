class RecentViewModel {
  String stream;
  String noteName;
  String pdfLink;
  RecentViewModel(
      {required this.stream, required this.noteName, required this.pdfLink});

  // Convert the model instance to a Map
  Map<String, dynamic> toMap() {
    return {'stream': stream, 'noteName': noteName, 'pdfLink': pdfLink};
  }

  // Create a model instance from a Map
  factory RecentViewModel.fromMap(Map<String, dynamic> map) {
    return RecentViewModel(
      stream: map['stream'],
      noteName: map['noteName'],
      pdfLink: map['pdfLink'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecentViewModel &&
        other.stream == stream &&
        other.noteName == noteName;
  }

  @override
  int get hashCode {
    return stream.hashCode ^ noteName.hashCode;
  }
}
