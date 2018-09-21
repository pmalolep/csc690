/************************************/
/* Author: Peter Malolepszy         */
/* File: AlphanumericCipher.swift   */
/* Project: SpyApp                  */
/* Class: CSC 690 Fall 2018 SFSU    */
/* Date: 9/20/2018                  */
/************************************/
import Foundation

/************************************/
/* -Alphanumeric Cipher-            */
/* Encodes message by establishing  */
/* a restricted alphabet, modifying */
/* the message to conform to it,    */
/* then shifting characters up in   */
/* the alphabet index by the secret */
/* value.                           */
/************************************/
struct AlphanumericCipher: Cipher {
    
    func encode(_ plaintext: String, secret: String) -> String {
        
        
        let fullAlpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let alpha = Array(fullAlpha)
        var encoded = ""
        
        var messageText = plaintext.uppercased()
        messageText = messageText.components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined()
        
        let messageArray = Array(messageText)
        
        guard let offset = Int(secret) else {
            return "Secret must be a number for this cipher"
        }
        
        for messageIndex in 0..<messageArray.count{
            let positionA = alpha.index(of: messageArray[messageIndex])!
            encoded += String(alpha[(positionA+offset)%fullAlpha.count])
        }
        
        return encoded
    }
    
    func decode(_ codedtext:String, secret:String)->String{
        
        
        let fullAlpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let alpha = Array(fullAlpha)
        var decoded = ""
        
        var messageText = codedtext.uppercased()
        messageText = messageText.components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined()
        let messageArray = Array(messageText)
        guard let offset = Int(secret) else {
            return "Secret must be a number for this cipher"
        }
        
        for messageIndex in 0..<messageArray.count{
        
            var positionA = alpha.index(of: messageArray[messageIndex])!
            while (positionA - offset) < 0 { positionA += alpha.count }
            decoded += String(alpha[(positionA-offset)])
        }
        
        return decoded
    }
}
