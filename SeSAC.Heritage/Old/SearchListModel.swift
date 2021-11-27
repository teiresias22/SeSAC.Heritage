import Foundation
import RealmSwift

class HeritageData: Object {
    @Persisted var sn: String
    @Persisted var no: String
    @Persisted var ccmaName: String
    @Persisted var crltsnoNm: String
    @Persisted var ccsiName: String
    @Persisted var ccbaMnm1: String
    @Persisted var ccbaMnm2: String
    @Persisted var ccbaCtcdNm: String
    @Persisted var ccbaAdmin: String
    @Persisted var ccbaKdcd: String
    @Persisted var ccbaCtcd: String
    @Persisted var ccbaAsno: String
    @Persisted var ccbaCncl: String
    @Persisted var ccbaCpno: String
    @Persisted var longitude: String
    @Persisted var latitude: String
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(sn: String, no: String, ccmaName: String, crltsnoNm: String, ccsiName:String, ccbaMnm1: String, ccbaMnm2:String, ccbaCtcdNm:String, ccbaAdmin:String, ccbaKdcd:String, ccbaCtcd:String, ccbaAsno:String, ccbaCncl:String, ccbaCpno:String, longitude:String, latitude:String ){
        self.init()
        self.sn = sn
        self.no = no
        self.ccmaName = ccmaName
        self.crltsnoNm = crltsnoNm
        self.ccsiName = ccsiName
        self.ccbaMnm1 = ccbaMnm1
        self.ccbaMnm2 = ccbaMnm2
        self.ccbaCtcdNm = ccbaCtcdNm
        self.ccbaAdmin = ccbaAdmin
        self.ccbaKdcd = ccbaKdcd
        self.ccbaCtcd = ccbaCtcd
        self.ccbaAsno = ccbaAsno
        self.ccbaCncl = ccbaCncl
        self.ccbaCpno = ccbaCpno
        self.longitude = longitude
        self.latitude = latitude
    }
}

struct Item {
    var sn: String //순번
    var no: String //고유 키값
    var ccmaName: String //문화재종목
    var crltsnoNm: String //지정호수
    var ccbaMnm1: String //문화재명(국문)
    var ccbaMnm2: String //문화재명(영문)
    var ccbaCtcdNm: String //시도명
    var ccsiName: String //시군구명
    var ccbaAdmin : String //관리자
    var ccbaKdcd: String //종목코드(필수)
    var ccbaCtcd: String //시도코드(필수)
    var ccbaAsno: String //지정번호(필수)
    var ccbaCncl: String //지정해제여부
    var ccbaCpno: String //문화재연계번호
    var longitude: String //경도
    var latitude: String //위도
}
