//
//  CarouselViewController.swift
//  CustomCarousel
//
//  Created by Andrey Grinevich on 09.03.2020.
//  Copyright © 2020 Andrey Grinevich. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var carouselView: iCarousel!
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var visibleItemsLabel: UILabel!
    @IBOutlet weak var arcTextField: UITextField!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var spacingTextField: UITextField!
    
    // MARK: - Private variables
    private let vm = CarouselViewModel()
    
    // MARK: - Overrided funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - IBActions
    @IBAction func increaseCount(_ sender: UIButton) {
        vm.updateCount(tag: sender.tag, isIncrease: true) { [weak self] in
            self?.updateIndicators()
        }
    }
    
    @IBAction func decreaseCount(_ sender: UIButton) {
        vm.updateCount(tag: sender.tag, isIncrease: false) { [weak self] in
            self?.updateIndicators()
        }
    }
    
    @IBAction func valueChanged(_ sender: UITextField) {
        vm.textFieldValueUpdated(with: sender.text, tag: sender.tag) { [weak self] in
            self?.updateIndicators()
        }
    }
    
    @IBAction func finishEdittingButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    // MARK: - Private funcs
    private func updateIndicators() {
        itemsCountLabel.text = vm.items.description
        arcTextField.text = String(format: "%.1f", vm.arc)
        radiusTextField.text = String(format: "%.1f", vm.radius)
        spacingTextField.text = String(format: "%.1f", vm.spacing)
        visibleItemsLabel.text = vm.visibleItems.description
        
        carouselView.reloadData()
    }
    
    private func setupView() {
        setupCarouselView()
        updateIndicators()
    }
    
    private func setupCarouselView() {
        carouselView.delegate = self
        carouselView.dataSource = self
        carouselView.type = .rotary
        carouselView.isVertical = false
        carouselView.isPagingEnabled = true
    }
}

// MARK: - iCarouselDelegate
extension CarouselViewController: iCarouselDelegate { }

// MARK: - iCarouselDataSource
extension CarouselViewController: iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return vm.items
    }
    
    func carousel(_ carousel: iCarousel,
                  viewForItemAt index: Int,
                  reusing view: UIView?) -> UIView {
        let someView = CardView(frame: frameForCarouselViewCell())
        someView.setupCardView(with: index)
        return someView
    }
    
    func carousel(_ carousel: iCarousel,
                  valueFor option: iCarouselOption,
                  withDefault value: CGFloat) -> CGFloat {
        switch option {
        case .arc: return CGFloat(2 * CFloat.pi) * vm.arc
        case .radius: return vm.radius
        case .spacing: return vm.spacing
        case .visibleItems: return vm.visibleItems
        case .wrap: return CarouselConstants.wrap
        default: return value
        }
    }
    
    public func frameForCarouselViewCell() -> CGRect {
        let screenWidth = UIScreen.main.bounds.size.width
        let width = screenWidth * CarouselConstants.cellViewScaleWidth
        let height = width / CarouselConstants.cellViewHeightAspectRatio
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        return frame
    }
}

// MARK: - CarouselConstants
extension CarouselViewController {
    private struct CarouselConstants {
        static let wrap: CGFloat = 1
        static let cellViewScaleWidth: CGFloat = 0.8
        static let cellViewHeightAspectRatio: CGFloat = 1.7
    }
}


