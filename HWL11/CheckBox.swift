//
//  CheckBox.swift
//  HWL11
//
//  Created by Даниил Евгеньевич on 30.05.2024.
//

import UIKit

@IBDesignable
class CheckBox: UIControl {
    private let backgroundView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let iconImageView = {
        let view = UIImageView(image: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.tintColor = .secondaryLabel
        return view
        
    }()
    
    private let textLabel = {
        let text = UILabel(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .secondaryLabel
        text.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        
        addSubview(backgroundView)
        addSubview(iconImageView)
        addSubview(textLabel)
        
        iconImageView.image = UIImage(systemName: "square")
        
        let tapCheckBoxGestureRecognizer = UITapGestureRecognizer()
        tapCheckBoxGestureRecognizer.numberOfTapsRequired = 1
        tapCheckBoxGestureRecognizer.numberOfTouchesRequired = 1
        tapCheckBoxGestureRecognizer.addTarget(self, action: #selector(tapCheckBoxAction))
        addGestureRecognizer(tapCheckBoxGestureRecognizer)
        
        
        
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
    }
    @IBInspectable
    var text: String {
        get {
            textLabel.text ?? ""
        }
        
        set {
            textLabel.text = newValue
        }
    }
    
    @IBInspectable
    var cheked: Bool = false
    
    
    @objc private func tapCheckBoxAction() {
        cheked = !cheked
        sendActions(for: .valueChanged)
        
        cheked ? (iconImageView.image = UIImage(systemName: "checkmark.square")) : (iconImageView.image = UIImage(systemName: "square"))
    }
    
    
    
    //    var iconImage: UIImage? {
    //        didSet {
    //            iconImageView.image = iconImage
    //        }
    //    }
}


