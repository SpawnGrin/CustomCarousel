//
//  CarouselViewModel.swift
//  CustomCarousel
//
//  Created by Andrey Grinevich on 09.03.2020.
//  Copyright © 2020 Andrey Grinevich. All rights reserved.
//

import Foundation

class CarouselViewModel {
    
    // MARK: - Public variables
    public var items: Int = 3
    public var arc: CGFloat = 0
    public var radius: CGFloat = 0
    public var spacing: CGFloat = 0
    public var visibleItems: CGFloat = 5
    
    // MARK: - Public funcs
    public func updateCount(tag: Int, isIncrease: Bool, completion: @escaping () -> ()) {
        switch CarouselSettings(rawValue: tag) ?? .items {
        case .items:
            items = isIncrease ? items + 1 : items - 1
        case .arc:
            arc = isIncrease ? arc + 0.1 : arc - 0.1
        case .radius:
            radius = isIncrease ? radius + 0.1 : radius - 0.1
        case .spacing:
            spacing = isIncrease ? spacing + 0.1 : spacing - 0.1
        case .visible:
            visibleItems = isIncrease ? visibleItems + 1 : visibleItems - 1
        }
        completion()
    }
}
