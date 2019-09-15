//
//  ScheduleGoToViewController.swift
//  SSA Student
//
//  Created by Nick on 8/26/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit
import Koyomi

protocol GoToDelegate: class {
    func didSelectCalendarDate(_ date: Date)
}

class ScheduleGoToViewController: UIViewController, KoyomiDelegate {

    weak var delegate: GoToDelegate?
    
    fileprivate var previousButton: UIButton! = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didPressLastButton), for: .touchUpInside)
        button.setImage(ImageAssets.previous, for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    @objc func didPressLastButton() {
        koyomi.display(in: .previous)
    }
    
    fileprivate var monthLabel: UILabel! = {
        let label = UILabel()
        return label
    }()
    
    fileprivate var nextButton: UIButton! = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didPressNextButton), for: .touchUpInside)
        button.setImage(ImageAssets.next, for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    @objc func didPressNextButton() {
        koyomi.display(in: .next)
    }
    
    fileprivate var controlStack: UIStackView! = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate var koyomi: Koyomi!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        var frame: CGRect!
        
        frame = CGRect(x: 8, y: 44, width: self.view.frame.width - 16, height: self.view.frame.height - 48)
        
        self.koyomi = Koyomi(
            frame: frame,
            sectionSpace: 1.5,
            cellSpace: 0.5,
            inset: .zero,
            weekCellHeight: 25)
        self.koyomi.calendarDelegate = self
        
        self.layoutSubviews()
        
        let date = Date()
        self.monthLabel.text = DateFormatter().monthSymbols[Calendar.current.component(.month, from: date) - 1] + " " + "\(Calendar.current.component(.year, from: date))"
    }
    
    func koyomi(_ koyomi: Koyomi, currentDateString dateString: String) {
        let splitString = dateString.split(separator: "/")
        let firstTwo = splitString[0]
        let year = splitString[1]
        guard let int = Int(firstTwo) else {return}
        self.monthLabel.text = DateFormatter().monthSymbols[int - 1]  + " " + year
    }
    
    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate, let date = date else {return}
        
        delegate.didSelectCalendarDate(date)
        self.dismiss(animated: true, completion: nil)
    }

    fileprivate func layoutSubviews() {
        self.view.addSubview(koyomi)
        self.view.addSubview(self.controlStack)
        controlStack.addArrangedSubview(self.previousButton)
        controlStack.addArrangedSubview(self.monthLabel)
        controlStack.addArrangedSubview(self.nextButton)
        
        NSLayoutConstraint.activate([
            self.controlStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            self.controlStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            self.controlStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            self.controlStack.heightAnchor.constraint(equalToConstant: 32.0)
        ])
    }
}
