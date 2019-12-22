
class MessageDto {

  final String date,
      text,
      user;

  MessageDto._({this.date, this.text, this.user});

  factory MessageDto.fromJson(Map<String, dynamic> json) => MessageDto._(
      date: json['created'],
      text: json['text'],
      user: json['name']
  );

  Map<String, dynamic> toJson() => {
    'created': date,
    'text': text,
    'name': user
  };

}
