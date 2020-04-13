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

final class KeyboardLayoutGuide: UILayoutGuide {

    let isSafeAreaLayoutGuide: Bool

    override var owningView: UIView? {
        didSet {
            bindToView()
        }
    }

    private var bottomConstraint: NSLayoutConstraint?

    init(isSafeAreaLayoutGuide: Bool) {
        self.isSafeAreaLayoutGuide = isSafeAreaLayoutGuide
        super.init()
        observeKeyboardNotifications()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("`init?(coder: NSCoder)` is unsupported.")
    }

    private func bindToView() {
        guard let view = owningView else { return }

        let bottom: NSLayoutConstraint
        if isSafeAreaLayoutGuide {
            bottom = bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                bottom
            ])
        } else {
            bottom = bottomAnchor.constraint(equalTo: view.bottomAnchor)
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: view.topAnchor),
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottom
            ])
        }

        self.bottomConstraint = bottom
    }

    private func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        var keyboardHeight = notification.keyboardHeight

        if isSafeAreaLayoutGuide {
            keyboardHeight -= owningView?.safeAreaInsets.bottom ?? 0
        }

        UIView.animate(
            withDuration: notification.keyboardAnimationDuration,
            delay: 0,
            options: notification.keyboardAnimationOptions,
            animations: { self.updateBottomConstraint(for: keyboardHeight) }
        )
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(
            withDuration: notification.keyboardAnimationDuration,
            delay: 0,
            options: notification.keyboardAnimationOptions,
            animations: { self.updateBottomConstraint(for: 0) }
        )
    }

    private func updateBottomConstraint(for keyboardHeight: CGFloat) {
        bottomConstraint?.constant = -keyboardHeight
        owningView?.layoutIfNeeded()
        owningView?.superview?.layoutIfNeeded()
    }
}

private extension Notification {

    var keyboardAnimationDuration: TimeInterval {
        return (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval) ?? 0.3
    }

    var keyboardAnimationOptions: UIView.AnimationOptions {
        let curve = userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        return curve.map(UIView.AnimationOptions.init) ?? UIView.AnimationOptions()
    }

    var keyboardHeight: CGFloat {
        let keyboardFrameValue = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)
        return keyboardFrameValue?.cgRectValue.height ?? 0
    }
}
#endif
