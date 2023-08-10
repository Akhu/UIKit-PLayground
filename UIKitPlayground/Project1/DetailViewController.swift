//
//  DetailViewController.swift
//  UIKitPlayground
//
//  Created by Anthony Da cruz on 11/07/2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        if let selectedImageName = selectedImage {
            self.imageView.image = UIImage(named: selectedImageName)
            title = selectedImageName
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))        // Do any additional setup after loading the view.
        
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }

    }
    
    @objc func shareTapped() {
        
        let activityItem = ImageActivityItemSource(title: "FileName", text: "SomeText", fileToShare: nil, urlToFile: FileReader.getUrl(ofFileName: "DSCF4222", withExtension: "jpg"))
        
        let vc = UIActivityViewController(activityItems: [activityItem], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
//
//
//        if let fileContent = FileReader.getRawContent(ofFileName: "DSCF4222", withExtension: "jpg") {
//
//            let activityItem = ImageActivityItemSource(title: "DSCF4222", text: "Some image", fileToShare: fileContent)
//
//            let vc = UIActivityViewController(activityItems: [activityItem], applicationActivities: [])
//            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//            present(vc, animated: true)
//        }
//        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
//            print("no image found")
//            return
//        }
//
//        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
//        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        present(vc, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
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
