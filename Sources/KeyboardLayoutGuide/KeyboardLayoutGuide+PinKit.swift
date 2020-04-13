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

    /// Constrains edge of the view to the specified edge of the target view's keyboard layout guide
    ///
    /// - Parameters:
    ///     - edge: Edge which will be constraint
    ///     - viewEdge: Target edge of the target view's safe area keyboard layout guide
    ///     - view: Target view to which's safe area keyboard layout guide will be constraint to.
    ///     - relation: The relation between the first attribute and the modified second attribute
    ///      in a constraint.
    ///     - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///     - constant: A constant added to the resulting constraint adjusting it along the appropriate axis.
    ///     - multiplier: A multiplier adjusting the created constraint.
    ///
    /// - Returns: `NSLayoutConstraint` created by matching the provided requirements.
    ///
    @available(iOS 11.0, *)
    @discardableResult
    func pinEdge(
        _ edge: KeyboardLayoutEdge,
        toSafeAreaKeyboardGuideEdge viewEdge: KeyboardLayoutEdge,
        of view: UIView,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(
            item: self,
            attribute: translateToAttributeFrom(edge: edge),
            relatedBy: relation,
            toItem: view.safeAreaKeyboardLayoutGuide,
            attribute: translateToAttributeFrom(edge: viewEdge),
            multiplier: multiplier,
            constant: constant
        )

        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    /// Constrains edge of the view to the specified edge of the target view's keyboard layout guide
    ///
    /// - Parameters:
    ///     - edge: Edge which will be constraint
    ///     - viewEdge: Target edge of the target view's keyboard layout guide
    ///     - view: Target view to which's keyboard layout guide will be constraint to.
    ///     - relation: The relation between the first attribute and the modified second attribute
    ///      in a constraint.
    ///     - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///     - constant: A constant added to the resulting constraint adjusting it along the appropriate axis.
    ///     - multiplier: A multiplier adjusting the created constraint.
    ///
    /// - Returns: `NSLayoutConstraint` created by matching the provided requirements.
    ///
    @available(iOS 11.0, *)
    @discardableResult
    func pinEdge(
        _ edge: KeyboardLayoutEdge,
        toKeyboardGuideEdge viewEdge: KeyboardLayoutEdge,
        of view: UIView,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(
            item: self,
            attribute: translateToAttributeFrom(edge: edge),
            relatedBy: relation,
            toItem: view.keyboardLayoutGuide,
            attribute: translateToAttributeFrom(edge: viewEdge),
            multiplier: multiplier,
            constant: constant
        )

        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    /// Sets the view's edge equal to the same edge of the view's superview's keyboard layout guide.
    ///
    /// - Parameters:
    ///     - edge: The specific edge of the view which will be constrained.
    ///     - relation: The relation between the first attribute and the modified second attribute
    ///      in a constraint.
    ///     - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///     - constant: The constant which will be added to the resulting constraint. Adding a constant of
    ///     50 would result in the resulting constraint to be offset by 50 units on the appropriate axis.
    ///     - multiplier: The multiplier which is used to modify the size. A size 100 with a multiplier
    ///     of 0.5
    ///      would result in the dimension size of 50.
    ///
    /// - Returns: `NSLayoutConstraint` matching the appropriate layout constraint generated.
    ///
    @discardableResult
    func pinEdge(
        toSuperviewKeyboardEdge edge: KeyboardLayoutEdge,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        let superview = unwrapSuperviewOrFailure()
        return pinEdge(
            edge,
            toKeyboardGuideEdge: edge,
            of: superview,
            relation: relation,
            priority: priority,
            constant: constant,
            multiplier: multiplier
        )
    }

    /// Sets the view's edge equal to the same edge of the view's superview's safe area keyboard layout guide.
    ///
    /// - Parameters:
    ///     - edge: The specific edge of the view which will be constrained.
    ///     - relation: The relation between the first attribute and the modified second attribute
    ///      in a constraint.
    ///     - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///     - constant: The constant which will be added to the resulting constraint. Adding a constant of
    ///     50 would result in the resulting constraint to be offset by 50 units on the appropriate axis.
    ///     - multiplier: The multiplier which is used to modify the size. A size 100 with a multiplier
    ///     of 0.5
    ///      would result in the dimension size of 50.
    ///
    /// - Returns: `NSLayoutConstraint` matching the appropriate layout constraint generated.
    ///
    @discardableResult
    func pinEdge(
        toSuperviewSafeAreaKeyboardEdge edge: KeyboardLayoutEdge,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        let superview = unwrapSuperviewOrFailure()
        return pinEdge(
            edge,
            toSafeAreaKeyboardGuideEdge: edge,
            of: superview,
            relation: relation,
            priority: priority,
            constant: constant,
            multiplier: multiplier
        )
    }

    /// Sets the view's edges equal to the same edges of another view's keyboard layout guide.
    ///
    /// - Parameters:
    ///     - edges: The specific edges of the view which will be constrained.
    ///     - view: Target view which will be constrained to.
    ///     - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///     - insets: The edge insets adding spacing between the edge insets. An edge set of [.top, .bottom]
    ///     with an inset set of .top(10) + .bottom(10) would result in constraints where the top edge
    ///     of the view being constraint is 10 units below the target view and the bottom is above the target
    ///     view by 10 units.
    ///
    /// - Returns: An array of  `NSLayoutConstraint` matching the appropriate layout constraints in
    ///  the same order as the param `edges` was provided generated.
    ///
    @discardableResult
    func pinEdges(
        toKeyboardEdges edges: [KeyboardLayoutEdge],
        of view: UIView,
        priority: UILayoutPriority = .required,
        insets: UIEdgeInsets = .zero
    ) -> [NSLayoutConstraint] {
        return edges.map { edge in
            pinEdge(
                edge,
                toKeyboardGuideEdge: edge,
                of: view,
                priority: priority,
                constant: translateToConstantFrom(inset: insets, for: edge)
            )
        }
    }

    /// Sets the view's edges equal to the same edges of another view's safe area keyboard layout guide.
    ///
    /// - Parameters:
    ///     - edges: The specific edges of the view which will be constrained.
    ///     - view: Target view which will be constrained to.
    ///     - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///     - insets: The edge insets adding spacing between the edge insets. An edge set of [.top, .bottom]
    ///     with an inset set of .top(10) + .bottom(10) would result in constraints where the top edge
    ///     of the view being constraint is 10 units below the target view and the bottom is above the target
    ///     view by 10 units.
    ///
    /// - Returns: An array of  `NSLayoutConstraint` matching the appropriate layout constraints in
    ///  the same order as the param `edges` was provided generated.
    ///
    @discardableResult
    func pinEdges(
        toSafeAreaKeyboardEdges edges: [KeyboardLayoutEdge],
        of view: UIView,
        priority: UILayoutPriority = .required,
        insets: UIEdgeInsets = .zero
    ) -> [NSLayoutConstraint] {
        return edges.map { edge in
            pinEdge(
                edge,
                toSafeAreaKeyboardGuideEdge: edge,
                of: view,
                priority: priority,
                constant: translateToConstantFrom(inset: insets, for: edge)
            )
        }
    }

    /// Sets the view's edges equal to the same edges of the view's superview's keyboard layout guide.
    ///
    /// - Parameters:
    ///     - edges: The specific edges of the view which will be constrained, defaults to All edges.
    ///     - insets: The edge insets adding spacing between the edge insets. An edge set of [.top, .bottom]
    ///     with an inset set of .top(10) + .bottom(10) would result in constraints where the top edge
    ///     of the view being constraint is 10 units below the target view and the bottom is above the target
    ///     view by 10 units.
    ///
    /// - Returns: An array of  `NSLayoutConstraint` matching the appropriate layout constraints in
    ///  the following order: Top, Leading, Trailing, Bottom.
    ///
    @discardableResult
    func pinEdgesToSuperviewKeyboardEdges(insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        let superview = unwrapSuperviewOrFailure()
        return pinEdges(toKeyboardEdges: .all, of: superview, insets: insets)
    }

    /// Sets the view's edges equal to the same edges of the view's superview.
    ///
    /// - Parameters:
    ///     - edges: The specific edges of the view which will be constrained, defaults to All edges.
    ///     - insets: The edge insets adding spacing between the edge insets. An edge set of [.top, .bottom]
    ///     with an inset set of .top(10) + .bottom(10) would result in constraints where the top edge
    ///     of the view being constraint is 10 units below the target view and the bottom is above the target
    ///     view by 10 units.
    ///
    /// - Returns: An array of  `NSLayoutConstraint` matching the appropriate layout constraints in
    ///  the following order: Top, Leading, Trailing, Bottom.
    ///
    @discardableResult
    func pinEdgesToSuperviewSafeAreaKeyboardEdges(insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        let superview = unwrapSuperviewOrFailure()
        return pinEdges(toSafeAreaKeyboardEdges: .all, of: superview, insets: insets)
    }

    private func unwrapSuperviewOrFailure() -> UIView {
        guard let superview = superview else { preconditionFailure("The view's superview can't be nil") }
        return superview
    }

    private func translateToAttributeFrom(edge: KeyboardLayoutEdge) -> NSLayoutConstraint.Attribute {
        switch edge {
        case .top: return .top
        case .left: return .left
        case .leading: return .leading
        case .right: return .right
        case .trailing: return .trailing
        case .bottom: return .bottom
        }
    }

    private func translateToConstantFrom(inset: UIEdgeInsets, for edge: KeyboardLayoutEdge) -> CGFloat {
        let isLeftToRight = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .leftToRight
        switch edge {
        case .top: return inset.top
        case .left: return inset.left
        case .leading: return isLeftToRight ? inset.left : -inset.right
        case .right: return -inset.right
        case .trailing: return isLeftToRight ? -inset.right : inset.left
        case .bottom: return -inset.bottom
        }
    }
}

public enum KeyboardLayoutEdge {
    case top
    case left
    case leading
    case right
    case trailing
    case bottom
}

public extension Collection where Element == KeyboardLayoutEdge {
    static var all: [KeyboardLayoutEdge] {
        return [.top, .leading, .trailing, .bottom]
    }

    static func all(except edge: KeyboardLayoutEdge) -> [KeyboardLayoutEdge] {
        var edges: [KeyboardLayoutEdge] = .all
        switch edge {
        case .top:
            edges.removeAll(where: { $0 == .top })
        case .left, .leading:
            edges.removeAll(where: { $0 == .leading })
        case .bottom:
            edges.removeAll(where: { $0 == .bottom })
        case .right, .trailing:
            edges.removeAll(where: { $0 == .trailing })
        }

        return edges
    }
}
#endif
