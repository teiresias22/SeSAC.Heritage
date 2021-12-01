import Foundation


struct ListInformation {
    
    let list: [List] = [
        
        List(title: "종류별 문화재", text: "종류별로 분류된 문화재를 확인하세요.", target: "ListCategory"),
        List(title: "지역별 문화재", text: "지역별로 분류된 문화재를 확인하세요.", target: "ListCategory"),
        List(title: "검색", text: "원하는 문화재를 검색해보세요.", target: "Search"),
        List(title: "방문한 여행지", text: "방문한 여행지, 벙문하고 싶은 여행지 리스트", target: "ListUp"),
        
    ]

}
