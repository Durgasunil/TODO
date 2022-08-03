//
//  ViewConstructable.swift
//  TODO
//
//  Created by Durgasunil Velicheti on 7/31/22.
//

import Foundation

///  protocol to define the phases of view construction.
///  Implement corresponding methods to programmatically construct the view , add subviews to the hierarchy and define constraints on the subviews
///
protocol ViewConstructable {
    /// configure the view and subviews which will be added to the hierarchy
    func constructView()
    
    /// assembels views in to the hierarchy
    func constructSubviewHierarchy()
    
    /// adds layout constraints
    func constructSubviewLayoutConstraints()
}

extension ViewConstructable {
    /// will call the viewconstructable protocol methods in the correct order to assemble the final view.
    func construct() {
        constructView()
        constructSubviewHierarchy()
        constructSubviewLayoutConstraints()
    }
}
