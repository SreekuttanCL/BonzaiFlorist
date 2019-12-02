//
//  FlowerDetailController.swift
//  Bonzai Florist
//
//  Created by Sreekuttan C L on 2019-11-30.
//  Copyright © 2019 Sreekuttan C L. All rights reserved.
//

import UIKit
import AlamofireImage
import Braintree

class FlowerDetailController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var btnPurchase: UIButton!
    
    var selectedPhoto: Photo?
    
    let braintreeClient = BTAPIClient(authorization: "sandbox_csgphtwc_q8x7kd5d9p62bhg7")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnPurchase.roundedButton()
        
        //Setting Nav bar title
        self.navigationItem.title = "Photo Detail"
        
        //setting the titleLabel
        titleLabel.text = selectedPhoto?.title ?? "Description..."
        
        //downloading images
        downloadImage(imageURL: (self.selectedPhoto?.url!)!)
    }
    
    func downloadImage(imageURL: String) {
        
        // image string to url
        let url = URL(string: imageURL)!
        
        //Adding placeholder image for the collection cells
        let placeholderImage = UIImage(named: "AppIcon")!
        
        //Setting downlaoded image to imageview
        imageView.af_setImage(withURL: url,  placeholderImage: placeholderImage)
        imageView.reloadInputViews()
    }
    
    
    @IBAction func btnPurchase(_ sender: Any) {
        
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
        payPalDriver.viewControllerPresentingDelegate = self
        payPalDriver.appSwitchDelegate = self // Optional
        
        // Specify the transaction amount here. "2.32" is used in this example.
        let request = BTPayPalRequest(amount: "100.0")
        request.currencyCode = "CAD" // Optional; see BTPayPalRequest.h for more options
        
        payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error)
            in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                
                // Access additional information
                let email = tokenizedPayPalAccount.email
                let firstName = tokenizedPayPalAccount.firstName
                let lastName = tokenizedPayPalAccount.lastName
                let phone = tokenizedPayPalAccount.phone
                
                // See BTPostalAddress.h for details
                let billingAddress = tokenizedPayPalAccount.billingAddress
         
                let shippingAddress = tokenizedPayPalAccount.shippingAddress
                print(email ?? "", firstName ?? "" , lastName ?? "" , phone ?? " ", billingAddress ?? "", shippingAddress ?? "")
                // Making request to server
                self.sendRequestPaymentToServer(nonce: tokenizedPayPalAccount.nonce, amount: "100.0")
            }
            else if let error = error {
                print(error.localizedDescription)
                // Handle error here...
            }
            else {
                // Buyer canceled payment approval print("Bauyer canceled payment approval")
            }
        }
    }
    
    func sendRequestPaymentToServer(nonce: String, amount: String) {
        
        let paymentURL = URL(string: "http://0.0.0.0:4567/checkouts")!
        var request = URLRequest(url: paymentURL)
      
        request.httpBody = "payment_method_nonce=\(nonce)&amount=\(amount)".data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) ->Void in
            guard let data = data else { print(error!.localizedDescription)
                return
            }
        
            guard let result = try? JSONSerialization.jsonObject(with: data, options: []) as?   [String: Any], let success = result["success"] as? Bool, success == true else {
                print("Successfully failed. Please check the transaction history.")
                return
            }
            print("Successfully charged. Thanks So Much :)")
        }.resume()
        
    }
}


extension FlowerDetailController : BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
}
extension FlowerDetailController : BTAppSwitchDelegate{
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target:
        BTAppSwitchTarget) {
        
    }
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
    
    }
    
}

