class Token {
  String access_token;
  String token_type;
  String refresh_token;
  String scope;
  Token({this.access_token, this.token_type, this.refresh_token, this.scope});
  factory Token.fromJson(Map<String, dynamic> json) => Token(
    access_token: json['access_token'],
    token_type: json['token_type'],
    refresh_token: json['refresh_token'],
    scope: json['scope'],
  );
}