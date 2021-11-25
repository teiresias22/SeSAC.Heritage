import UIKit

protocol StoryboardInitializable {
    static var storyboardName: String { get set }
    static var storyboardId: String { get set }
    static func instantiate() -> Self
}

extension StoryboardInitializable where Self: UIViewController {
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardId) as! Self
        return vc
    }
}
