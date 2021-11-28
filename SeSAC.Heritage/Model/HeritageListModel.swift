//
//  HeritageListAPIManager.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/11/23.
//

import Foundation
import RealmSwift

class Heritage_List: Object {
    @Persisted var sn: String //순번
    @Persisted var no: String //고유 키값
    @Persisted var ccmaName: String //문화재종목
    @Persisted var crltsnoNm: String //지정호수
    @Persisted var ccbaMnm1: String //문화재명(국문)
    @Persisted var ccbaMnm2: String //문화재명(영문)
    @Persisted var ccbaCtcdNm: String //시도명
    @Persisted var ccsiName: String //시군구명
    @Persisted var ccbaAdmin : String //관리자
    @Persisted var ccbaKdcd: String //종목코드(필수)
    @Persisted var ccbaCtcd: String //시도코드(필수)
    @Persisted var ccbaAsno: String //지정번호(필수)
    @Persisted var ccbaCncl: String //지정해제여부
    @Persisted var ccbaCpno: String //문화재연계번호
    @Persisted var longitude: String //경도
    @Persisted var latitude: String //위도
    @Persisted var visited: Bool //방문했어요
    @Persisted var wantvisit: Bool //방문하고 싶어요
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(sn: String, no: String, ccmaName: String, crltsnoNm: String, ccbaMnm1: String, ccbaMnm2: String, ccbaCtcdNm: String, ccsiName: String, ccbaAdmin: String, ccbaKdcd: String, ccbaCtcd: String, ccbaAsno: String, ccbaCncl: String, ccbaCpno: String, longitude: String, latitude: String){
        self.init()
        self.sn = sn
        self.no = no
        self.ccmaName = ccmaName
        self.crltsnoNm = crltsnoNm
        self.ccbaMnm1 = ccbaMnm1
        self.ccbaMnm2 = ccbaMnm2
        self.ccbaCtcdNm = ccbaCtcdNm
        self.ccsiName = ccsiName
        self.ccbaAdmin = ccbaAdmin
        self.ccbaKdcd = ccbaKdcd
        self.ccbaCtcd = ccbaCtcd
        self.ccbaAsno = ccbaAsno
        self.ccbaCncl = ccbaCncl
        self.ccbaCpno = ccbaCpno
        self.longitude = longitude
        self.latitude = latitude
        self.visited = false
        self.wantvisit = false
        
    }
}
