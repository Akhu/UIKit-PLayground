//
//  TestViewController.swift
//  UIKitPlayground
//
//  Created by Anthony Da cruz on 11/07/2023.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let metrics = ["labelHeight": 50]
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.red
        label1.text = "THESE"
        
        let label2 = UILabel()
          label2.translatesAutoresizingMaskIntoConstraints = false
          label2.backgroundColor = UIColor.cyan
          label2.text = "ARE"
          label2.sizeToFit()

          let label3 = UILabel()
          label3.translatesAutoresizingMaskIntoConstraints = false
          label3.backgroundColor = UIColor.yellow
          label3.text = "SOME"
          label3.sizeToFit()

          let label4 = UILabel()
          label4.translatesAutoresizingMaskIntoConstraints = false
          label4.backgroundColor = UIColor.green
          label4.text = "AWESOME"
          label4.sizeToFit()

          let label5 = UILabel()
          label5.translatesAutoresizingMaskIntoConstraints = false
          label5.backgroundColor = UIColor.orange
          label5.text = "LABELS"
          label5.sizeToFit()

          view.addSubview(label1)
          view.addSubview(label2)
          view.addSubview(label3)
          view.addSubview(label4)
          view.addSubview(label5)
        
        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
        
        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight)]-[label2(labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]->=10-|", options: [], metrics: metrics, views: viewsDictionary))


        for label in viewsDictionary.keys {
            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
            

        }
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
