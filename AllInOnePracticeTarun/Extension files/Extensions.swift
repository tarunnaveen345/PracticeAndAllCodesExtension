//
//  Extensions.swift
//
//  Created by tarun naveen on 11/05/18.
//  Copyright © 2018 tarun naveen. All rights reserved.
//

import UIKit
import MapKit




///////////////////   UIView related funcs   //////////////////////////////////

extension UIView
{
    
    func setCornerRadiusForView() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
    }
    
}


///////////////////   UIColor  related funcs   //////////////////////////////////


extension UIColor
{
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue:      CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}




///////////////////   UIViewController related funcs   ///////////////////////////

extension UIViewController{
    
//     Firebase UID getting
//    func userUID()->String
//    {
//        let uid = Auth.auth().currentUser?.uid
//        return uid!
//    }
    
    
    func isConnectedToInternet() -> Bool {
        let hostname = "google.com"
        let hostinfo = gethostbyname2(hostname, AF_INET6)//AF_INET6
        if hostinfo != nil
        {
            return true // internet available
        }
        return false // no internet
    }
    
    func presentAlertWithOkay(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func presentConectionLossAlert() {
       
        let alertController = UIAlertController(title: "Can't Connect", message: "Check your network and try again.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showLoadingIndicator()
    {
       
    }
    func dismissLoadingIndicator()
    {
       
    }
    
    
    
    func addStringWithSpace(string:String) -> String
    {
        
        return  "\(" ")\(string)"
    }
    
    func getOnPostRequest(urlString:String,params:Dictionary<String,String>, completion:()->())
    {
        
//        let params = ["username":"john", "password":"123456"] as Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
               // print(json)
               }
            catch
            {
                print("error")
             }
        })
        
        task.resume()
    }
    
    
    func getOnGetRequest(urlString:String, completionHandler: @escaping (Dictionary<String, Any>)-> Void ) 
    {

        
        
        //        let params = ["username":"john", "password":"123456"] as Dictionary<String, String>
        var dic : Dictionary<String, Any> = Dictionary<String, Any>()
//        var request = URLRequest(url: URL(string: urlString)!)
//        request.httpMethod = "GET"
//       // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        let session = URLSession.shared
//        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//            print(response)
//            do {
////                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
//                dic = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
//               // print(dic)
//            }
//            catch
//            {
//                print("error")
//            }
//        })
//
//        task.resume()
        
        //create the url with NSURL
        let url = URL(string: urlString)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        let request = URLRequest(url: url)
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    dic = json
                    completionHandler(json)
                    
                }
                

                
                
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
        
        
    }
    
    
    
    
    
    ///////////// firebase notification triggering  //////////////////////////
    
    func triggerNotification(token:String,title:String){
        
        if self.isConnectedToInternet()
        {
            let url = URL(string: "https://fcm.googleapis.com/fcm/send")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.setValue("key=AAAACpMg6Rk:APA91bFktmmVkyuSgPCBItc52fdHlI9GS0KOT4oDNEz6IzXxmCAnVFnhTRpHHj0ZF7JBr0PslHcyzpYbMUPrBRm847AW3oNd4Ve3_tt__7P26BhdcjUMODJtcrh0fCSNTXh_qlugwTHv", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            let notData: [String: Any] = [
                "to" : token as Any,
                "notification": [
                    "title" : title,
                    "body"  : "not body",
                    "icon"  : "not icon"
                ],
                ]
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: notData, options: []) else {
                return
            }
            request.httpBody = httpBody
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
            }
            task.resume()
            
            
            
        }
        else
        {
            self.presentConectionLossAlert()
            
        }
        
        
    }
    
    
    
    
    
    

    func showAlertWhenNetworkLoss(withTitle title: String, andMsg msg: String ,completionHandler: @escaping (_ action: Bool)-> Void) {
        //  KRProgressHUD.dismiss()
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Retry", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            
            completionHandler(true)
            
            alert.dismiss(animated: true) {() -> Void in }
            

            
            // retry action
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            alert.dismiss(animated: true) {() -> Void in }
        })
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true) {() -> Void in }
    }

    
    
    
    
    
    
    
    
    
}






///////////////////   UITextfield related funcs   /////////////////////////////////




extension UITextField {
    
    // adding image as like inbuild
    
    func addImageOnLeftView(image:UIImage){
        
        self.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 23, height: 23))
        imageView.image = image
        self.leftView = imageView
        
    }
    
    
    
    
    func setCornerRadiusForTF() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
        
    }
    
    func isTextFieldIsEmpty() -> Bool {
        let whitespace = CharacterSet.whitespacesAndNewlines
        
        if  (self.text?.trimmingCharacters(in: whitespace).count ?? 0) == 0
        {
            //                showAlert(withTitle: "Email id  is empty", andMsg: "White spaces are not allowed.")
            return true
        }
        else
        {
            return false
        }
        
        
    }
    
    
    // for number pad to keyboard
    
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        //          let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Done", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            //                UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
    
}





///////////////////   UIViewController related funcs   ///////////////////////////



extension MKMapView
{
    func fitAllMarkers(shouldIncludeCurrentLocation: Bool) {
        
        if !shouldIncludeCurrentLocation
        {
            showAnnotations(annotations, animated: false)
        }
        else
        {
            var zoomRect = MKMapRectNull
            
            let point = MKMapPointForCoordinate(userLocation.coordinate)
            let pointRect = MKMapRectMake(point.x, point.y, 0, 0)
            zoomRect = MKMapRectUnion(zoomRect, pointRect)
            
            for annotation in annotations {
                
                let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
                let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0)
                
                if (MKMapRectIsNull(zoomRect)) {
                    zoomRect = pointRect
                } else {
                    zoomRect = MKMapRectUnion(zoomRect, pointRect)
                }
            }
            
            setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsetsMake(8, 8, 8, 8), animated: true)
        }
    }
}



///////////////////   UILabel related funcs   ///////////////////////////////////



extension UILabel {
    
    func imageWithTextOnLeft(image:UIImage,text:String)
    {
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = image
        //Set bound to reposition
        //  let imageOffsetY:CGFloat = -5.0;
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        //Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        //Initialize mutable string
        let completeText = NSMutableAttributedString(string: " ")
        //Add image to mutable string
        completeText.append(attachmentString)
        //Add your text to mutable string
        let  textAfterIcon = NSMutableAttributedString(string: " "+text)
        completeText.append(textAfterIcon)
        self.textAlignment = .left;
        self.attributedText = completeText;
    }
    
    
    func imageWithTextOnLeftForLocation(image:UIImage,text:String)
    {
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = image
        //Set bound to reposition
        //  let imageOffsetY:CGFloat = -5.0;
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        //Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        //Initialize mutable string
        let completeText = NSMutableAttributedString(string: " ")
        //Add image to mutable string
        completeText.append(attachmentString)
        //Add your text to mutable string
        let  textAfterIcon = NSMutableAttributedString(string: " "+text)
        completeText.append(textAfterIcon)
        self.textAlignment = .left;
        self.attributedText = completeText;
    }
    
    func imageWithText(image:UIImage,text:String)
    {
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = image
        //Set bound to reposition
        //  let imageOffsetY:CGFloat = -5.0;
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height)
        //Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        //Initialize mutable string
        let completeText = NSMutableAttributedString(string: " ")
        //Add image to mutable string
        completeText.append(attachmentString)
        //Add your text to mutable string
        let  textAfterIcon = NSMutableAttributedString(string: " "+text)
        completeText.append(textAfterIcon)
        self.textAlignment = .left;
        self.attributedText = completeText;
    }
    
    
    
    
}















