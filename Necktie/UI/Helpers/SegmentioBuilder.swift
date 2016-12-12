//
//  SegmentioBuilder.swift
//  Necktie
//
//  Created by Ondra Kandera on 8/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation

import Segmentio

struct SegmentioBuilder {
    
    static func setupBadgeCountForIndex(_ segmentioView: Segmentio, index: Int, count: Int) {
        segmentioView.addBadge(
            at: index,
            count: count,
            color: UIColor.red
        )
    }
    
    static func buildSegmentioView(segmentioView: Segmentio, segmentioItems: [SegmentioItem], segmentioStyle: SegmentioStyle) {
        segmentioView.setup(
            content: segmentioContent(content: segmentioItems),
            style: segmentioStyle,
            options: segmentioOptions(segmentioStyle: segmentioStyle)
        )
    }
    
    private static func segmentioContent(content: [SegmentioItem]) -> [SegmentioItem] {
        return content
    }
    
    private static func segmentioOptions(segmentioStyle: SegmentioStyle) -> SegmentioOptions {
        var imageContentMode = UIViewContentMode.center
        switch segmentioStyle {
        case .imageBeforeLabel, .imageAfterLabel:
            imageContentMode = .scaleAspectFit
        default:
            break
        }
        
        return SegmentioOptions(
            backgroundColor: UIColor.white,
            maxVisibleItems: 4,
            scrollEnabled: true,
            indicatorOptions: segmentioIndicatorOptions(),
            horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions(),
            verticalSeparatorOptions: segmentioVerticalSeparatorOptions(),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            labelTextNumberOfLines: 1,
            segmentStates: segmentioStates(),
            animationDuration: 0.3
        )
    }
    
    private static func segmentioStates() -> SegmentioStates {
        return SegmentioStates(
            defaultState: segmentioState(
                backgroundColor: .clear,
                titleFont: UIFont(name: "Roboto-Regular", size: 12)!,
                titleTextColor: .lightGray
            ),
            selectedState: segmentioState(
                backgroundColor: .clear,
                titleFont: UIFont(name: "Roboto-Bold", size: 12)!,
                titleTextColor: .black
            ),
            highlightedState: segmentioState(
                backgroundColor: .clear,
                titleFont: UIFont(name: "Roboto-Regular", size: 12)!,
                titleTextColor: .lightGray
            )
        )
    }
    
    private static func segmentioState(backgroundColor: UIColor, titleFont: UIFont, titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            titleTextColor: titleTextColor
        )
    }
    
    private static func segmentioIndicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 2,
            color: UIColor().necktiePrimary
        )
    }
    
    private static func segmentioHorizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(
            type: .topAndBottom,
            height: 0,
            color: .clear
        )
    }
    
    private static func segmentioVerticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(
            ratio: 0,
            color: .clear
        )
    }
    
}
