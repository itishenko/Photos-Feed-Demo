//
//  BaseView.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

open class BaseView: UIView {
    
    public weak var rootView: UIView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open func setup() {
        xibSetup()
    }
    
    private func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        let views = ["v": view]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v]-0-|",
                                                      metrics: nil,
                                                      views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v]-0-|",
                                                      metrics: nil,
                                                      views: views))
        rootView = view
    }
    
    private func loadViewFromNib() -> UIView? {
        let nib = ResourceRouter.nib(forObject: self)
        guard let view = nib.instantiate(withOwner: self)[0] as? UIView else { return nil }
        return view
    }
}
