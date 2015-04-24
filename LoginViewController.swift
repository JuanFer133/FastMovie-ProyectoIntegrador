//
//  LoginViewController.swift
//  FastMovie
//
//  Created by JuanFer on 16/04/15.
//  Copyright (c) 2015 JuanFer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailtextbox: UITextField!
    @IBOutlet weak var contraseñatextbox: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func entrar(sender: AnyObject)  {
        
        if(emailtextbox.text.isEmpty || contraseñatextbox.text.isEmpty){
            MensajedeAlerta("Todos los campos son requeridos");
            return
        }
        
        //conexion a la base de datos
        var correo = emailtextbox.text
        var contraseña = contraseñatextbox.text
        var id = ""
        
        
        let  json = "{\"user\":{\"email\":\"\(correo)\",\"password\":\"\(contraseña)\"}}"
        
        println(json.dataUsingEncoding(NSUTF8StringEncoding))
        
        let URL: NSURL = NSURL(string: "https://murmuring-oasis-5413.herokuapp.com/login")!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:URL)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = json.dataUsingEncoding(NSUTF8StringEncoding);
        var error:NSError?;
        var response:NSURLResponse?;
        
        var urlData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        if (urlData != nil) {

           let res = response as! NSHTTPURLResponse!;
            //NSLog("Response code: %ld", res.statusCode);
            if (res.statusCode >= 200 && res.statusCode < 300)
            {
                var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                
                NSLog("Response ==> %@", responseData);
                
                var error: NSError?
                
                let jsonData:NSDictionary! = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as? NSDictionary
                
                if(jsonData != nil){
                    dispatch_async(dispatch_get_main_queue(), {
                        id = jsonData["id"] as! String
                    
                    })
                }
                
                let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                
               
                
                //[jsonData[@"success"] integerValue];
                
                NSLog("Success: %ld", success);
                
                if(success == 1)
                {
                    //id = jsonData["id"] as! String
                    NSLog("Sign Up SUCCESS");
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    var error_msg:NSString
                    
                    if jsonData["error_message"] as? NSString != nil {
                        error_msg = jsonData["error_message"] as! NSString
                    } else {
                        error_msg = "Unknown Error"
                    }
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign Up Failed!"
                    alertView.message = error_msg as String
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                    
                }
                
                println(id)
            }
        
        }
        
        //self.dismissViewControllerAnimated(true, completion: nil)
        
        /*
         let  json = "{\"user\":{\"email\":\"\(correo)\",\"password\":\"\(contraseña)\"}}"
        
         println(json.dataUsingEncoding(NSUTF8StringEncoding))
            
        let URL: NSURL = NSURL(string: "https://murmuring-oasis-5413.herokuapp.com/login")!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:URL)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
        request.HTTPBody = json.dataUsingEncoding(NSUTF8StringEncoding);
        var error:NSError?;
        var response:NSURLResponse?;
        
        NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        if (error != nil) {
            
            self.MensajedeAlerta("Email o Contraseña incorrecto")
            let res = response as! NSHTTPURLResponse!;
            
            NSLog("Response code: %ld", res.statusCode);
            
        }else{
            
            println("la respuesta es " + String(stringInterpolationSegment: response))
            
        }
       
        self.dismissViewControllerAnimated(true, completion: nil)
    */
    }
        
    func MensajedeAlerta(mensaje:String){
        var miAlerta = UIAlertController(title: "Alerta", message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        miAlerta.addAction(okAction)
        self.presentViewController(miAlerta, animated: true, completion: nil)
        
        
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        textField.resignFirstResponder()
    }
    
    func dataOfJson(url: String) -> NSArray{
    
        var data = NSData(contentsOfURL: NSURL(string: url)!)
        return (NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray)
    }
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "mostrarcompra" {
            let acompra = segue.destinationViewController as! CompraViewController
            
        }

    }
    */
    
}