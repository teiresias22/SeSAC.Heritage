import Foundation


struct ListInformation {
    
    let list: [List] = [
        
        List(title: "종류별 문화유산", text: "종류별로 분류된 문화유산을 확인하세요.", target: "ListCategory"),
        List(title: "지역별 문화유산", text: "지역별로 분류된 문화유산을 확인하세요.", target: "ListCategory"),
        List(title: "문화유산 검색", text: "원하는 문화유산을 검색해보세요.", target: "Search"),
        List(title: "나의 문화유산", text: "방문했던, 방문하고 싶던 문화유산을 확인하세요.", target: "ListUp"),
        
    ]

}
