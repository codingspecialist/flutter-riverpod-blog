class PostWriteReqDto {
  String title;
  String content;

  PostWriteReqDto({required this.title, required this.content});

  Map<String, dynamic> toJson() {
    return {"title": title, "content": content};
  }
}

class PostUpdateReqDto {
  String title;
  String content;

  PostUpdateReqDto({required this.title, required this.content});

  Map<String, dynamic> toJson() {
    return {"title": title, "content": content};
  }
}
