import UIKit

public struct RootStyleHolder {
    public static var rootStyle: StyleProtocol?
    public static func autoapply() {
        struct Static { static var token = dispatch_once_t() }
        dispatch_once(&Static.token) {
            swizzleInstance(UIView.self, originalSelector: #selector(UIView.init(frame:)), swizzledSelector: #selector(UIView.__init(frame:)))
            swizzleInstance(UIView.self, originalSelector: #selector(UIView.awakeFromNib), swizzledSelector: #selector(UIView.__awakeFromNib))
        }
    }
}

extension UIView {
    dynamic func __init(frame frame: CGRect) -> Self {
        let result = __init(frame: frame)
        applyRootStyle()
        return result
    }

    dynamic func __awakeFromNib() {
        __awakeFromNib()
        applyRootStyle()
    }

    private func applyRootStyle() {
        RootStyleHolder.rootStyle?.apply(to: self)
    }
}

/// Based on http://nshipster.com/method-swizzling/
func swizzleInstance<T: NSObject>(cls: T.Type, originalSelector: Selector, swizzledSelector: Selector) {
    let originalMethod = class_getInstanceMethod(cls, originalSelector)
    let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)

    let didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}