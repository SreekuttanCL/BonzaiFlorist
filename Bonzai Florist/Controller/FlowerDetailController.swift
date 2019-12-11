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
import AVFoundation

class FlowerDetailController: UIViewController {
    
    var braintreeClient: BTAPIClient!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var btnPurchase: UIButton!
    
    var selectedPhoto: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        braintreeClient = BTAPIClient(authorization: "sandbox_7b8pgrqn_qmh7f4hs9jh6zms4")
        
        btnPurchase.roundedButton()
        
        //Setting Nav bar title
        self.navigationItem.title = "Photo Detail"
        
        //setting the titleLabel
        titleLabel.text = selectedPhoto?.title ?? "Description..."
        
        //downloading images
        downloadImage(imageURL: (self.selectedPhoto?.url!)!)
        
        self.textToSpeech(textToSay: "The price of \(selectedPhoto?.title) is 10 dollars")
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
        
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
             payPalDriver.viewControllerPresentingDelegate = self
             payPalDriver.appSwitchDelegate = self // Optional
             
             // Specify the transaction amount here. "2.32" is used in this example.
             let request = BTPayPalRequest(amount: "2.32")
             request.currencyCode = "CAD" // Optional; see BTPayPalRequest.h for more options

             payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
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
                    
                    let alert = UIAlertController(title: "Sucessful", message: "Order placed sucessfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"Ok" , style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                    self.textToSpeech(textToSay: "Order Placed sucessfully")
                 } else if let error = error {
                     // Handle error here...
                 } else {
                     // Buyer canceled payment approval
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
    
    func textToSpeech( textToSay: String){
        // Line 1. Create an instance of AVSpeechSynthesizer.
        let speechSynthesizer = AVSpeechSynthesizer()
        // Line 2. Create an instance of AVSpeechUtterance and pass in a String to be spoken.
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: textToSay)
        //Line 3. Specify the speech utterance rate. 1 = speaking extremely the higher the values the slower speech patterns. The default rate, AVSpeechUtteranceDefaultSpeechRate is 0.5
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 4.0
        // Line 4. Specify the voice. It is explicitly set to English here, but it will use the device default if not specified.
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        // Line 5. Pass in the urrerance to the synthesizer to actually speak.
            speechSynthesizer.speak(speechUtterance)
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

