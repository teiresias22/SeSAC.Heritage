import Foundation

extension String {
    //text 현지화 적용
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    //myLabel.text = "Hello".localized()
    
    //text Value에 Format 추가
    func localized(with argument: CVarArg = [], comment: String = "") -> String {
    return String(format: self.localized(comment: comment), argument)
    }
    //myLabel.text = "My Age %d".localized(with: 26, comment: "age")
}
