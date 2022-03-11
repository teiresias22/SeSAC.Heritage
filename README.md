# JHeritage
![다운로드](https://user-images.githubusercontent.com/83900106/157811382-bbcb7bca-30fb-4768-b8f3-8c3d65b1ada1.jpeg)
대한민국의 문화유산 정보를 보여주는 앱 입니다. 문화유산을 종류와 지역별로 목록화 하여 보여주며, 검색이 가능합니다. 지도를 통해 한눈에 볼수도 있습니다.    
방문목록과 즐겨찾기 목록을 통해 나만의 리스트를 관리할수 있습니다.

## 사용 기술 및 라이브러리
  * iOS, Swift, Storyboard, Codebase, MVC, MVVM, AutoLayout
  * MapKit, CoreLocation, CLAuthorizationStatus, SearchBar, SwiftXMLParser, ToastMessage, Observable
  * Alamofire, Snapkit, Firebase Analytics, Crashlytics, Cloud Messaging 
  * Github, Figma, Insomnia

## 구현한 기능
  * SwiftXMLParser를 활용한 XML데이터 활용
  * Snapket을 활용한 Codebase AutoLayout
  * Firebase Analytics와 Crashlytics를 활용하여 유저의 사용 패턴 확인
  * Firebase Cloud Messaging을 활용한 알림 사용
  * Mapkit의 CoreLocation와 Annotation을 활용한 위치 서비스
  * MVVM 패턴 적용
  * TableView Cell에 SwipeAction 기능 활용
  * ColorSet을 활용한 Dark모드 지원

## 회고 및 이슈
### App Store 출시
  * App Store 등록을 위한 출시 전 과정 진행
  * TestFlight을 통한 출시전 베타 테스트 진행

### Update
  * 출시 이후 정기적인 업데이트 관리를 통한 리팩토링 진행 
  * 1.0.5버전 업데이트
  ** 지도텝 진입시 사용자의 위치에 맞게 지역 필터 자동 설정
  * 1.0.4 업데이트 
  ** Storyboard를 활용한 MVC패턴 사용에서 Codebase를 활용한 MVVM패턴 사용으로 변경

### Firebase 연동
  * P8인증서를 활용한 Firebase 연동
  * Analytics와 Crashlytics를 활용하여 사용자의 이용 패턴을 확인 업데이트에 적극 활용
  * Cloud Messaging을 활용한 알람 발송 환경 구축

### 위치정보 활용
  * CLPlacemark 활용하여 사용자의 접속 위치 확인
  * 접속자의 위치를 확인하고 지도의 필터링 지역 자동 설정

### XMLParser 활용
  * JSON형식이 아닌 XML 형식식의 데이터를 활용
  * 

## Link
[앱스토어](https://apps.apple.com/kr/app/우리동네-문화유산/id1596845419) 
[지원페이지](https://foamy-cloche-5c7.notion.site/1574978a39894f489ffdd4af591c9a32) 
[블로그](https://teiresias.tistory.com/4)
