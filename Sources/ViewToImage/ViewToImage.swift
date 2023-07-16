#if os(iOS)
import UIKit

public extension UIView {
    func asImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, window?.screen.scale ?? 1)

        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
        }

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}

#elseif os(macOS)
import Cocoa

public extension NSView {
    func asImage() -> NSImage? {
        NSImage(size: bounds.size, flipped: false) { [weak self] rect in
            guard let self,
                  let rep = bitmapImageRepForCachingDisplay(in: rect)
            else { return false }

            cacheDisplay(in: rect, to: rep)
            return rep.draw()
        }
    }
}
#endif
