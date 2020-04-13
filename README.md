# KeyboardLayoutGuide

Almost every iOS developer has at one point had to deal with handling the presence of the keyboard. This framework makes it super simple to deal with by creating two new layout guides, `keyboardLayoutGuide` and `safeAreakeyboardLayoutGuide`. Both are added to the `UIView` class through extensions. These can easily constraint to and are updated automatically if a keyboard is presented.

## Installation

### Swift Package Manager
As of Xcode 11 SPM integrates nicely with Xcode. This means that installing dependencies with Xcode support is super easy. To add the dependency using Swift Package Manager do the following steps:

1. Select the desired project and choose the `Swift Packages` tab of your project.
2. Tap on the + button.
3. Enter `https://github.com/sanderrouk/KeyboardLayoutGuide` onto the search bar and click next.
4. Choose the `Version` option leaving the selection on `Up to Next Major` option.
5. Click Next.
6. Click Finish.
7. Either create a separate file for it or add `import KeyboardLayoutGuide` in the file where you want to use it.

### Carthage
1. Add `github "sanderrouk/KeyboardLayoutGuide" ~> 1.0.0` project to your Cartfile.
2. Run `$ carthage update --platform ios`, this library does not support building for platforms other than iOS.
3. [Do the additional steps required for carthage frameworks.](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)
4. Either create a separate file for it or add `import KeyboardLayoutGuide` in the file where you want to use it.

## Usage
KeyboardLayoutGuide works by simply extending UIKit's `UIView` class functionality by adding KeyboardLayoutGuides to it. These can be used the same way the default SafeAreaLayoutGuide can be.

```swift
        let greenView = UIView()
        greenView.translatesAutoresizingMaskIntoConstraints = false
        greenView.backgroundColor = .green

        view.addSubview(greenView)
        NSLayoutConstraint.activate([
            greenView.topAnchor.constraint(equalTo: view.safeAreaKeyboardLayoutGuide.topAnchor),
            greenView.leftAnchor.constraint(equalTo: view.safeAreaKeyboardLayoutGuide.leftAnchor),
            greenView.rightAnchor.constraint(equalTo: view.safeAreaKeyboardLayoutGuide.rightAnchor),
            greenView.bottomAnchor.constraint(equalTo: view.safeAreaKeyboardLayoutGuide.bottomAnchor),
        ])

        let redCircle = UIView()
        redCircle.translatesAutoresizingMaskIntoConstraints = false
        redCircle.backgroundColor = .red
        redCircle.layer.cornerRadius = 50

        view.addSubview(redCircle)
        NSLayoutConstraint.activate([
            redCircle.heightAnchor.constraint(equalToConstant: 100),
            redCircle.widthAnchor.constraint(equalToConstant: 100),
            redCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redCircle.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.bottomAnchor)
        ])

        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Example Text"
        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(redCircleTapped))
        redCircle.addGestureRecognizer(tapRecognizer)
```

Or if you use [PinKit](https://github.com/sanderrouk/PinKit) then you can keep to the same style as this framework brings the familiar syntax.

```swift
        let greenView = UIView()
        greenView.backgroundColor = .green

        view.addSubview(greenView)
        greenView.pinEdgesToSuperviewSafeAreaKeyboardEdges()

        let redCircle = UIView()
        redCircle.backgroundColor = .red
        redCircle.setDimensions(to: CGSize(width: 100, height: 100))
        redCircle.layer.cornerRadius = 50

        view.addSubview(redCircle)
        redCircle.alignAxisToSuperview(axis: .vertical)
        redCircle.pinEdge(toSuperviewKeyboardEdge: .bottom)

        let textField = UITextField()
        textField.placeholder = "Example Text"
        view.addSubview(textField)
        textField.centerInSuperview()

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(redCircleTapped))
        redCircle.addGestureRecognizer(tapRecognizer)
```

## Roadmap
This framework is planned to be a part of the iOS PowerKit framework which is coming soon.

## License
The project is under the MIT licence meaning you can use this project however you want.