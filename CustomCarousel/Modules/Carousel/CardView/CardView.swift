//
//  CardView.swift
//  CustomCarousel
//
//  Created by Andrey Grinevich on 09.03.2020.
//  Copyright © 2020 Andrey Grinevich. All rights reserved.
//

import Foundation

class CardView: UIView {
    
    @IBOutlet var bodyView: UIView!
    @IBOutlet weak var indexLabel: UILabel!
    
    // MARK: - Init funcs
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed(String(describing: type(of: self)),
                                 owner: self, options: nil)
        bodyView.frame.size = frame.size
        addSubview(bodyView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed(String(describing: type(of: self)),
                                 owner: self, options: nil)
        bodyView.frame = frame
        addSubview(bodyView)
    }
    
    public func setupCardView(with index: Int) {
        indexLabel.text = index.description
        
        bodyView.layer.cornerRadius = 10
        bodyView.backgroundColor = .black
    }
}
