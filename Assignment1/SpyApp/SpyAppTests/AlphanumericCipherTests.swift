/****************************************/
/* Author: Peter Malolepszy             */
/* File: AlphanumericCipherTests.swift  */
/* Project: SpyApp                      */
/* Class: CSC 690 Fall 2018 SFSU        */
/* Date: 9/20/2018                      */
/****************************************/
import XCTest
@testable import SpyApp

class AlphanumericCipherTests: XCTestCase{
    var cipher: Cipher!
    
    override func setUp(){
        super.setUp()
        
        cipher = AlphanumericCipher()
    }
    
    func test_oneCharacterStringMapsToSelf(){
        let plaintext = "a"
        
        let result = cipher.encode(plaintext, secret: "0")
        
        XCTAssertEqual("A",result)
    }
    
    func test_nonNumericInputforSecret(){
        let result = cipher.encode("message",secret:"nonNumericString")
        
        XCTAssertEqual(result, "Secret must be a number for this cipher")
    }
    
    func test_unknownCharactersInInput(){
        
        let message = "message~"
        let result = cipher.encode(message,secret: "0")
        
        XCTAssertEqual(result, "MESSAGE")
    }
    
    func test_basicEncription(){
        let message = "789"
        let result = cipher.encode(message, secret: "3")
        
        XCTAssertEqual(result, "ABC")
    }
    
    func test_basicDecription(){
        let message = "abc"
        let result = cipher.decode(message, secret: "3")
        
        XCTAssertEqual(result, "789")
    }
}
