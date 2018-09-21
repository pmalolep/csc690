/************************************/
/* Author: Peter Malolepszy         */
/* File: TranspositionCipher.swift  */
/* Project: SpyApp                  */
/* Class: CSC 690 Fall 2018 SFSU    */
/* Date: 9/20/2018                  */
/************************************/
import Foundation

/************************************/
/* -Transposition Cipher-           */
/* Encodes message by reversing the */
/* alphabet and then acting as a    */
/* rotational cipher.               */
/************************************/

struct TranspositionCipher: Cipher {
    
    func encode(_ plaintext: String, secret: String) -> String {
        
        let fullAlpha = "abcdefghijklmnopqrstuvwxyz1234567890 !@#$%^&*()_+-=[]\\{}|;':\",./<>?ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let alpha = Array(fullAlpha)
        
        var encoded = ""
        let messageArray = Array(plaintext)
        guard let secretOffset = Int(secret) else {
            return "Secret must be a number for this cipher"
        }
        
        for messageIndex in 0..<messageArray.count{
            guard let positionA = alpha.index(of: messageArray[messageIndex]) else {
                return "Input contains unknown character(s)"
            }
            var offset = alpha.count - secretOffset - positionA - 1
            while offset < 0 { offset += alpha.count }
            encoded += String(alpha[offset])
        }
        
        return encoded
    }
    
    func decode(_ codedtext:String, secret:String)->String{
        
        
        let fullAlpha = "abcdefghijklmnopqrstuvwxyz1234567890 !@#$%^&*()_+-=[]\\{}|;':\",./<>?ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let alpha = Array(fullAlpha)
        
        var encoded = ""
        let messageArray = Array(codedtext)
        guard let secretOffset = Int(secret) else {
            return "Secret must be a number for this cipher"
        }
        
        for messageIndex in 0..<messageArray.count{
            guard let positionA = alpha.index(of: messageArray[messageIndex]) else {
                return "Input contains unknown character(s)"
            }
            var offset = alpha.count - secretOffset - positionA - 1
            while offset < 0 { offset += alpha.count }
            encoded += String(alpha[offset])
        }
        
        return encoded
    }
}
