import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
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
        }
    }

    @objc private func redCircleTapped() {
        view.endEditing(true)
    }
}
