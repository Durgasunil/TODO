//
//  CompletedButton.swift
//  TODO
//
//  Created by Durgasunil Velicheti on 8/2/22.
//

import Foundation
import UIKit

/// Custom Button to mark the Task as Complete
///
/// 1. User can toggle the completed property to mark the task as completed and update the task in realm accordingly.
/// 2. Similarly set the property when displaying the task details based on the tasks completion status
class CompleteTaskButton: UIButton {
    public var completed: Bool = false {
        didSet {
            if completed {
                setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            } else {
                setImage(UIImage(systemName: "circle"), for: .normal)
            }
        }
    }
        
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
         
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
