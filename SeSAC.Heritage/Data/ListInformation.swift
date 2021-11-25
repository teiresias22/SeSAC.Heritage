import Foundation


struct ListInformation {
    
    let list: [List] = [
        
        List(title: "종류별 문화재", text: "종류별로 분류된 문화재를 확인하세요.", target: "ListCategory"),
        List(title: "지역별 문화재", text: "지역별로 분류된 문화재를 확인하세요.", target: "ListCategory"),
        List(title: "내 주변 문화재", text: "내 주변 문화재를 확인하세요 /n 서비스 준비중", target: "Map"),
        List(title: "유네스코 문화재", text: "한국의 유네스코 문화재를 확인하세요.", target: "ListCategory"),
        
    ]

}
