import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("게시글 아이디 : 1, 로그인 상태 : false"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "제목",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            Divider(),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {},
                  child: Text("삭제"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("수정"),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text("글 내용"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
