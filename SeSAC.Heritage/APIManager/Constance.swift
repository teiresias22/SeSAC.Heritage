import Foundation

struct APIkey {
    
}

struct Endpoint {
    //문화재목록 검색
    static let Heritage_List = "http://www.cha.go.kr/cha/SearchKindOpenapiList.do?pageIndex=1&pageUnit=20"
    
    //문화재검색 상세
    //필수 파라미터 ccbaKdcd: 종목코드, ccbaAsno: 지정번호, ccbaCtcd: 시도코드
    static let Heritage_Detail = "http://www.cha.go.kr/cha/SearchKindOpenapiDt.do?"
    
    //시.군.구 목록
    //필수 파라미터 ccbaCtcd: 시도코드
    static let Heritage_Location = "http://www.cha.go.kr/common/heritage/selectSearchGugunCdOpenApi.jsp?"
    
    //이미지 검색
    //필수 파라미터 ccbaKdcd: 종목코드, ccbaAsno: 지정번호, ccbaCtcd: 시도코드
    static let Heritage_Image = "http://www.cha.go.kr/cha/SearchImageOpenapi.do?"
    
    //동영상 검색
    //필수 파라미터 ccbaKdcd: 종목코드, ccbaAsno: 지정번호, ccbaCtcd: 시도코드
    static let Heritage_Media = "http://www.cha.go.kr/cha/SearchVideoOpenapi.do?"
    
    //나레이션 검색
    //필수 파라미터 ccbaKdcd: 종목코드, ccbaAsno: 지정번호, ccbaCtcd: 시도코드
    static let Heritage_Narration = "http://www.cha.go.kr/cha/SearchVoiceOpenapi.do?"
}
