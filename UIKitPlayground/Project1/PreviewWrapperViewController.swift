//
//  PreivewWrapperViewController.swift
//  UIKitPlayground
//
//  Created by Anthony Da cruz on 27/07/2023.
//

import UIKit

protocol WrapperVC {
    var childVC : UIViewController? { get set }
}

class PreviewWrapperViewController: UIViewController, WrapperVC {
    var childVC: UIViewController? = nil 
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
