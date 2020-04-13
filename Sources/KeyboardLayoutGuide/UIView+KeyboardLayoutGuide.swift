/*
Copyright © 2020 Rouk OÜ. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
#if os(iOS)
import UIKit

public extension UIView {

    /// The layout guide representing your view and other content and reacts to the keyboard being presented.
    var keyboardLayoutGuide: UILayoutGuide {
        return findKeyboardLayoutGuide(isSafeAreaLayoutGuide: false)
            ?? instantiateKeyboardLayoutGuide(isSafeAreaLayoutGuide: false)
    }

    /// The layout guide representing the portion of your view that is unobscured by bars and other content and reacts to the keyboard being presented.
    var safeAreaKeyboardLayoutGuide: UILayoutGuide {
        return findKeyboardLayoutGuide(isSafeAreaLayoutGuide: true)
            ?? instantiateKeyboardLayoutGuide(isSafeAreaLayoutGuide: true)
    }

    private func findKeyboardLayoutGuide(isSafeAreaLayoutGuide: Bool) -> UILayoutGuide? {
        return layoutGuides.first(where: { guide in
            guard let guide = guide as? KeyboardLayoutGuide else { return false }
            return guide.isSafeAreaLayoutGuide == isSafeAreaLayoutGuide
        })
    }

    private func instantiateKeyboardLayoutGuide(isSafeAreaLayoutGuide: Bool) -> UILayoutGuide {
        let guide = KeyboardLayoutGuide(isSafeAreaLayoutGuide: isSafeAreaLayoutGuide)
        addLayoutGuide(guide)
        return guide
    }
}
#endif
