import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("게시글 아이디 : 1, 로그인 상태 : false"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "제목",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
          const Divider(),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {},
                child: const Text("삭제"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                child: const Text("수정"),
              ),
            ],
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Text("글 내용"),
            ),
          ),
        ],
      ),
    );
  }
}
