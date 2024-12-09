class DomainModel {
  final String? id;
  final String? type;
  final String? context;
  final String? domain;
  final bool? isActive;
  final bool? isPrivate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DomainModel({
    this.id,
    this.type,
    this.context,
    this.domain,
    this.isActive,
    this.isPrivate,
    this.createdAt,
    this.updatedAt,
  });

  factory DomainModel.fromJson(Map<String, dynamic> json) {
    return DomainModel(
      id: json['id'] as String?,
      type: json['@type'] as String?,
      context: json['@context'] as String?,
      domain: json['domain'] as String?,
      isActive: json['isActive'] as bool?,
      isPrivate: json['isPrivate'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }
}
