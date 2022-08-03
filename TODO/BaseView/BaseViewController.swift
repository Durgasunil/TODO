//
//  BaseViewController.swift
//  TODO
//
//  Created by Durgasunil Velicheti on 7/31/22.
//

import Foundation
import UIKit

/// BaseViewController which provides an unified functionality across all the viewControllers when inherited.
///
/// 1. Conforms to the ViewConstructable protocol
/// 2. Has methods to seperate out view construction Logic
/// 3. Additionally can host any methods which will be used across viewcontrollers. for e.g. ShowError below.
class BaseViewController: UIViewController, ViewConstructable {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        construct()
    }
    
    /// 
    func constructView() {}
    
    func constructSubviewHierarchy() {}
    
    func constructSubviewLayoutConstraints() {}
}


extension BaseViewController {
    // Show error dialog across view controllers.
    
    func showError(_ error: NSError, shouldDismiss: Bool = true) {
        let alertTitle = NSLocalizedString("Error", comment: "Error alert title")
        let alert = UIAlertController(title: alertTitle, message: error.localizedDescription, preferredStyle: .alert)
        let actionTitle = NSLocalizedString("OK", comment: "Alert OK button title")
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: {[weak self] _ in
            if shouldDismiss {
                self?.dismiss(animated: true)
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showError(_ message: String, shouldDismiss: Bool = true) {
        let alertTitle = NSLocalizedString("Error", comment: "Error alert title")
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let actionTitle = NSLocalizedString("OK", comment: "Alert OK button title")
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: {[weak self] _ in
            if shouldDismiss {
                self?.dismiss(animated: true)
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
