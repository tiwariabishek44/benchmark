class Book {
  final int? id;
  final int? subjectId;
  final String? name;
  final String? description;
  final String? fileLocation;
  final String? price;
  final String? bookType;

  Book({
    this.id,
    this.subjectId,
    this.name,
    this.description,
    this.fileLocation,
    this.price,
    this.bookType,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int?,
      subjectId: json['subjectId'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      fileLocation: json['fileLocation'] as String?,
      price: json['price'] as String?,
      bookType: json['bookType'] as String?,
    );
  }
}

class PhysicalItemApiResponse {
  final bool? success;
  final List<Book> data;
  final String message;

  PhysicalItemApiResponse({
    this.success,
    required this.data,
    required this.message,
  });

  factory PhysicalItemApiResponse.fromJson(Map<String, dynamic> json) {
    return PhysicalItemApiResponse(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => Book.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      message: json['message'] as String? ?? '',
    );
  }
}
