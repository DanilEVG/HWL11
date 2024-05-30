//
//  TextFieldWithIcon.swift
//  HWL11
//
//  Created by Даниил Евгеньевич on 29.05.2024.
//

import UIKit
import OSLog

@IBDesignable
class TextFieldWithIcon: UIControl {
    
    private let backgroundView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .textFieldBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        let shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 10)
        view.layer.shadowPath = shadowPath.cgPath
        view.layer.shadowColor = UIColor(white: 0.0, alpha: 0.03).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 20
        view.layer.cornerRadius = 10
        view.clipsToBounds = false
        return view
    }()
    
    private let textField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return textField
    }()
    
    private let iconImageView = {
        let view = UIImageView(image: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let shadowPath = UIBezierPath(roundedRect: backgroundView.bounds, cornerRadius: 10)
        backgroundView.layer.shadowPath = shadowPath.cgPath
    }
    @IBInspectable
    var text: String {
        get {
            textField.text ?? ""
        }
        
        set {
            textField.text = newValue
        }
    }
    @IBInspectable
    var placeholder: String = ""{
        didSet{
            let placeholderString = AttributedString(placeholder, attributes: AttributeContainer()
                .foregroundColor(UIColor.secondaryLabel)
                .font(UIFont.systemFont(ofSize: 16, weight: .regular)))
            textField.attributedPlaceholder = NSAttributedString(placeholderString)
        }
    }
    @IBInspectable
    var iconImage: UIImage? {
        didSet {
            iconImageView.image = iconImage
        }
    }
    
    private func setup() {
        backgroundColor = .clear
        clipsToBounds = false
        
        updateColors()
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) {(self: Self, previousTraitCollection) in
            self.updateColors()
        }
        addSubview(backgroundView)
        addSubview(iconImageView)
        addSubview(textField)
        
        textField.addTarget(self, action: #selector(textFieldEditingBegin(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldEditingEnd(_:)), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textFieldEditingEndOnExit(_:)), for: .editingDidEndOnExit)
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        //одним пальцем
        tapGestureRecognizer.numberOfTouchesRequired = 1
        //одним нажатием
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.addTarget(self, action: #selector(tapGestureAction(_:)))
        addGestureRecognizer(tapGestureRecognizer)
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 0).withPriority(.defaultLow - 100),
            iconImageView.widthAnchor.constraint(equalToConstant: 0).withPriority(.defaultHigh - 1),
            
            textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 20),
            textField.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
        
        iconImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        iconImageView.setContentCompressionResistancePriority(.defaultHigh + 10, for: .horizontal)
        
    }
    
    private func updateColors() {
        switch self.traitCollection.userInterfaceStyle {
            
            
        case .light, .unspecified:
            self.backgroundView.layer.shadowColor = UIColor(white: 0.0, alpha: 0.39).cgColor
        case .dark:
            self.backgroundView.layer.shadowColor = UIColor(white: 1.0, alpha: 0.39).cgColor
        @unknown default:
            Logger().warning("Unknown user interface style \(String(describing: self.traitCollection.userInterfaceStyle))")
            self.backgroundView.layer.shadowColor = UIColor(white: 0.0, alpha: 0.39).cgColor
        }
    }
    
    @objc private func tapGestureAction(_ sender: UITapGestureRecognizer){
        guard sender.state == .ended else {return}
        textField.becomeFirstResponder()
    }
    
    @objc private func textFieldEditingBegin(_ sender: UITextField) {
        sendActions(for: .editingDidBegin)
    }
    
    @objc private func textFieldEditingEnd(_ sender: UITextField) {
        sendActions(for: .editingDidEnd)
    }
    
    @objc private func textFieldEditingEndOnExit(_ sender: UITextField) {
        sendActions(for: .editingDidEndOnExit)
    }
    
    @objc private func textFieldEditingChanged(_ sender: UITextField) {
        sendActions(for: .editingChanged)
    }
    
}
