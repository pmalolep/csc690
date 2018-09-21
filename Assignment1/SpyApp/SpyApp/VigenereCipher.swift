/************************************/
/* Author: Peter Malolepszy         */
/* File: VigenereCipher.swift       */
/* Project: SpyApp                  */
/* Class: CSC 690 Fall 2018 SFSU    */
/* Date: 9/20/2018                  */
/************************************/
import Foundation

/************************************/
/* -Vigenere Cipher-                */
/* Duplicates or trims secret to be */
/* the same length as the message,  */
/* then each character in the       */
/* message gets shifted by the      */
/* character in the secret of the   */
/* same index. A secret of 'b' is   */
/* shifted by 1, a secret of 'bc'   */
/* is shifted by 1 and 2 consecu-   */
/* tivly repeating.                 */
/************************************/

struct VigenereCipher: Cipher {
    
    func encode(_ plaintext: String, secret: String) -> String {
        
        let fullAlpha = "abcdefghijklmnopqrstuvwxyz1234567890 !@#$%^&*()_+-=[]\\{}|;':\",./<>?ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let alpha = Array(fullAlpha)
        
        var encoded = ""
        let secretArray = Array(secret)
        let messageArray = Array(plaintext)
        
        for messageIndex in 0..<messageArray.count{
            guard let positionA = alpha.index(of: messageArray[messageIndex]) else {
                return "input string contained character(s) outside of our scope"
            }
            let positionB = alpha.index(of: secretArray[messageIndex%secretArray.count])
            encoded += String(alpha[(positionA + (positionB ?? 0))%alpha.count])
        }
        
        return encoded
    }
    
    func decode(_ codedtext:String, secret:String)->String{
        
        let fullAlpha = "abcdefghijklmnopqrstuvwxyz1234567890 !@#$%^&*()_+-=[]\\{}|;':\",./<>?ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let alpha = Array(fullAlpha)
        
        var decoded = ""
        let secretArray = Array(secret)
        let messageArray = Array(codedtext)
        
        for messageIndex in 0..<messageArray.count{
            guard let positionA = alpha.index(of: messageArray[messageIndex]) else {
                return "input string contained character(s) outside of our scope"
            }
            let positionB = alpha.index(of: secretArray[messageIndex%secretArray.count])
            var positionC = (positionA - (positionB ?? 0))
            if positionC < 0{
                positionC += alpha.count
            }
            decoded += String(alpha[positionC])
        }
        
        return decoded
    }
}
