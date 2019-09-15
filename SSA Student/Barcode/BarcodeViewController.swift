//
//  BarcodeViewController.swift
//  SSA Student
//
//  Created by Nick on 8/3/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit
import AVFoundation
import RSBarcodes_Swift

class BarcodeViewController: UIViewController {
    
    static var previousBrightness: CGFloat? = UIScreen.main.brightness
    
    fileprivate var barcodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.transform = CGAffineTransform(rotationAngle: .pi/2.0)
        return imageView
    }()
    
    fileprivate var addButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitle("Add a Barcode", for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        return addButton
    }()
    
    fileprivate func getBarcodeImage(studentId: String) -> UIImage? {
        return RSUnifiedCodeGenerator.shared.generateCode(studentId, machineReadableCodeObjectType: AVMetadataObject.ObjectType.code39.rawValue)
    }
    
    @objc fileprivate func didPressEdit() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        guard self.navigationItem.rightBarButtonItem != nil else {return}
        alertController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            Defaults.set(value: nil, key: .schoolId)
            self.updateBarcodeImageView()
        }
        
        let scanAction = UIAlertAction(title: "Scan", style: .default) { (action) in
            let barcodeScannerViewController = BarcodeScannerViewController(self)
            self.present(UINavigationController(rootViewController: barcodeScannerViewController), animated: true, completion: nil)
            return
        }
        
        let manualEnteryAction = UIAlertAction(title: "Manual Entry", style: .default) { (action) in
            let formModal = UIAlertController(title: "Set Barcode", message: nil, preferredStyle: .alert)
            
            formModal.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "StudentID"
                textField.keyboardType = .numberPad
            })
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: { (action) in
                guard let text = formModal.textFields?[0].text else {return}
                if text.count != 12 {
                    let errorController = UIAlertController(title: "Error!", message: "There was an error with your student ID. Please try again.", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                    errorController.addAction(okayAction)
                    self.present(errorController, animated: true, completion: nil)
                    return
                }
                Defaults.set(value: text, key: .schoolId)
                self.updateBarcodeImageView()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            formModal.addAction(cancelAction)
            formModal.addAction(okayAction)
            self.present(formModal, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            return
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(scanAction)
        alertController.addAction(manualEnteryAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    convenience init() {
        
        self.init(nibName:nil, bundle:nil)
        
        self.title = "Barcode"
        
        self.tabBarItem = UITabBarItem(title: "Barcode", image: ImageAssets.barcode, tag: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        BarcodeViewController.previousBrightness = UIScreen.main.brightness
        UIScreen.animateBrightness(to: 1.0)
        
        updateBarcodeImageView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let brightness = BarcodeViewController.previousBrightness else {return}
        UIScreen.animateBrightness(to: brightness)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: ImageAssets.settings, style: .plain, target: self, action: #selector(didPressEdit))
        self.navigationItem.rightBarButtonItem?.tintColor = .lightGray
        addButton.addTarget(self, action: #selector(didPressEdit), for: .touchUpInside)
        addButton.setTitleColor(self.view.tintColor, for: .normal)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.layoutSubviews()
    }
    
    public func updateBarcodeImageView() {
        if let studentId = Defaults.get(key: .schoolId) as? String {
            self.barcodeImageView.image = getBarcodeImage(studentId: studentId)
            self.addButton.isHidden = true
        } else {
            self.noBarcodeSaved()
        }
    }
    
    fileprivate func noBarcodeSaved() {
        
        self.addButton.isHidden = false
        self.barcodeImageView.image = nil
        
    }
    
    fileprivate func layoutSubviews() {
     
        self.view.addSubview(addButton)
        NSLayoutConstraint.activate([
            self.addButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.addButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        self.view.addSubview(barcodeImageView)
        NSLayoutConstraint.activate([
            barcodeImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            barcodeImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            barcodeImageView.widthAnchor.constraint(equalToConstant: 350.0),
            barcodeImageView.heightAnchor.constraint(equalToConstant: 200.0)
            ])
    }
}
