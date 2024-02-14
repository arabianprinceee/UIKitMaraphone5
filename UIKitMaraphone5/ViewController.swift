//
//  ViewController.swift
//  UIKitMaraphone5
//
//  Created by Анас Бен Мустафа on 14.02.2024.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    lazy var presentationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        button.addAction(
            UIAction(
                handler: { _ in
                    let vc = PopoverViewController()
                    vc.modalPresentationStyle = .popover
                    vc.popoverPresentationController?.sourceView = button
                    vc.popoverPresentationController?.permittedArrowDirections = .up
                    vc.popoverPresentationController?.delegate = self
                    self.present(vc, animated: true)
                }
            ),
            for: .touchUpInside
        )
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(presentationButton)
        NSLayoutConstraint.activate([
            presentationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        ])
    }
    
    public func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle {
        return .none
    }
    
}

final class PopoverViewController: UIViewController {
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.insertSegment(
            action: .init(handler: { _ in
                self.preferredContentSize = CGSize(width: 300, height: 280)
            }),
            at: 0,
            animated: false
        )
        control.setTitle("280pt", forSegmentAt: 0)
        control.insertSegment(
            action: .init(handler: { _ in
                self.preferredContentSize = CGSize(width: 300, height: 150)
            }),
            at: 1,
            animated: false
        )
        control.setTitle("150pt", forSegmentAt: 1)
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "sofa.fill")!.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .gray
        button.addAction(.init(handler: { _ in
            self.dismiss(animated: true)
        }), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        preferredContentSize = CGSize(width: 300, height: 280)
        
        view.addSubview(segmentedControl)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            closeButton.centerYAnchor.constraint(equalTo: segmentedControl.centerYAnchor),
        ])
    }
    
}
