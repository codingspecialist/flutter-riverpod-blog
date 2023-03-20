# 플러터 riverpod 블로그 만들기

K디지털 수업 내용 반영

### 아키텍처

- Service, HttpConnector 싱글톤 패턴으로 구현 (이유 : Provider 접근이 위젯에서 ref로만 되서 싱글톤 패턴이 좋음)
- ViewModel, Controller는 View관련된 것이어서 Provider로 구현
- ViewModel에서는 절대 controller 요청하면 안됨.
- controller(화면 비지니스), provider(전역 상태관리), service(파싱, 데이터 컨트롤), view(화면), core(유틸,상수, 라우터)
- viewModel의 model, provider의 model 이 있음.
- ResponseDto (통신) -> ResponeDto의 data값 파싱해서 다시 채우기 -> ViewModel의 model에게 전달!!

### 이슈
- flutter_secure_storage 에 jwt Token 저장 (sdk 33, min 21)

### 남은 일정
- 게시글 수정


### 참고
https://getinthere.notion.site/riverpod-a31427c9b3444812b5ff84826c849d7f