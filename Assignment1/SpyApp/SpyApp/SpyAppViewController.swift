/************************************/
/* Author: Peter Malolepszy         */
/* File: SpyAppViewController.swift */
/* Project: SpyApp                  */
/* Class: CSC 690 Fall 2018 SFSU    */
/* Date: 9/20/2018                  */
/************************************/
import UIKit

class SpyAppViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var secret: UITextField!
    @IBOutlet weak var output: UITextView!
    
    let factory = CipherFactory()
    var cipher: Cipher?

    @IBAction func encodedButtonPressed(_ sender: UIButton) {
        let plaintext = input.text!
        let secret = self.secret.text!

        if let cipher = self.cipher {
            output.text = cipher.encode(plaintext, secret: secret)
        } else {
            output.text = "No cipher selected"
        }
    }
    
    @IBAction func decodeButtonPressed(_ sender: UIButton) {
        
        let codedText = input.text!
        let secret = self.secret.text!
        
        if let cipher = self.cipher{
            output.text = cipher.decode(codedText,secret:secret)
        } else {
            output.text = "No cipher selected"
        }
    }
    
    @IBAction func cipherButtonPressed(_ sender: UIButton) {
        guard
            let buttonLable = sender.titleLabel,
            let buttonText = buttonLable.text
        else {
            output.text = "No button or no button text"
            return
        }
        cipher = factory.cipher(for: buttonText)
    }
}

