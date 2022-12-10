# 플러터 riverpod 블로그 만들기

### 아키텍처
- 싱글톤 패턴으로 구현 (이유 : Provider 접근이 위젯에서 ref로만 되서 싱글톤 패턴이 좋음)
- View관련된 것만 Provider로 구현
- domain, controller, provider, view, core, util

### 참고
https://getinthere.notion.site/riverpod-a31427c9b3444812b5ff84826c849d7f