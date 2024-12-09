
class EmailAddress {
  final String name;
  final String address;

  EmailAddress({
    required this.name,
    required this.address,
  });

  factory EmailAddress.fromJson(Map<String, dynamic> json) {
    return EmailAddress(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
    };
  }
}

class Message {
  final String id;
  final String accountId;
  final String msgid;
  final EmailAddress from;
  final List<EmailAddress> to;
  final String subject;
  final String intro;
  final bool seen;
  final bool isDeleted;
  final bool hasAttachments;
  final int size;
  final String downloadUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
    required this.id,
    required this.accountId,
    required this.msgid,
    required this.from,
    required this.to,
    required this.subject,
    required this.intro,
    required this.seen,
    required this.isDeleted,
    required this.hasAttachments,
    required this.size,
    required this.downloadUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? '',
      accountId: json['accountId'] ?? '',
      msgid: json['msgid'] ?? '',
      from: EmailAddress.fromJson(json['from'] ?? {}),
      to: (json['to'] as List<dynamic>?)
          ?.map((e) => EmailAddress.fromJson(e))
          .toList() ??
          [],
      subject: json['subject'] ?? '',
      intro: json['intro'] ?? '',
      seen: json['seen'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      hasAttachments: json['hasAttachments'] ?? false,
      size: json['size'] ?? 0,
      downloadUrl: json['downloadUrl'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountId': accountId,
      'msgid': msgid,
      'from': from.toJson(),
      'to': to.map((e) => e.toJson()).toList(),
      'subject': subject,
      'intro': intro,
      'seen': seen,
      'isDeleted': isDeleted,
      'hasAttachments': hasAttachments,
      'size': size,
      'downloadUrl': downloadUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class HydraMapping {
  final String type;
  final String variable;
  final String property;
  final bool required;

  HydraMapping({
    required this.type,
    required this.variable,
    required this.property,
    required this.required,
  });

  factory HydraMapping.fromJson(Map<String, dynamic> json) {
    return HydraMapping(
      type: json['@type'] ?? '',
      variable: json['variable'] ?? '',
      property: json['property'] ?? '',
      required: json['required'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '@type': type,
      'variable': variable,
      'property': property,
      'required': required,
    };
  }
}

class HydraSearch {
  final String type;
  final String template;
  final String variableRepresentation;
  final List<HydraMapping> mapping;

  HydraSearch({
    required this.type,
    required this.template,
    required this.variableRepresentation,
    required this.mapping,
  });

  factory HydraSearch.fromJson(Map<String, dynamic> json) {
    return HydraSearch(
      type: json['@type'] ?? '',
      template: json['hydra:template'] ?? '',
      variableRepresentation: json['hydra:variableRepresentation'] ?? '',
      mapping: (json['hydra:mapping'] as List<dynamic>?)
          ?.map((e) => HydraMapping.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '@type': type,
      'hydra:template': template,
      'hydra:variableRepresentation': variableRepresentation,
      'hydra:mapping': mapping.map((e) => e.toJson()).toList(),
    };
  }
}
class HydraView {
  final String id;
  final String type;
  final String? first;
  final String? last;
  final String? previous;
  final String? next;

  HydraView({
    required this.id,
    required this.type,
    this.first,
    this.last,
    this.previous,
    this.next,
  });

  factory HydraView.fromJson(Map<String, dynamic> json) {
    return HydraView(
      id: json['@id'] ?? '',
      type: json['@type'] ?? '',
      first: json['hydra:first'],
      last: json['hydra:last'],
      previous: json['hydra:previous'],
      next: json['hydra:next'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '@id': id,
      '@type': type,
      'hydra:first': first,
      'hydra:last': last,
      'hydra:previous': previous,
      'hydra:next': next,
    };
  }
}

class MessagesResponse {
  final List<Message> messages;
  final int totalItems;
  final HydraView? view;
  final HydraSearch? search;

  MessagesResponse({
    required this.messages,
    required this.totalItems,
    this.view,
    this.search,
  });

  factory MessagesResponse.fromJson(Map<String, dynamic> json) {
    return MessagesResponse(
      messages: (json['hydra:member'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e))
          .toList() ??
          [],
      totalItems: json['hydra:totalItems'] ?? 0,
      view: json['hydra:view'] != null
          ? HydraView.fromJson(json['hydra:view'])
          : null,
      search: json['hydra:search'] != null
          ? HydraSearch.fromJson(json['hydra:search'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hydra:member': messages.map((e) => e.toJson()).toList(),
      'hydra:totalItems': totalItems,
      'hydra:view': view?.toJson(),
      'hydra:search': search?.toJson(),
    };
  }
}