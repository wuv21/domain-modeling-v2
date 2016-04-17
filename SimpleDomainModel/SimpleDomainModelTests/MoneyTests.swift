//
//  MoneyTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

import SimpleDomainModel

//////////////////
// MoneyTests
//
class MoneyTests: XCTestCase {
  
  let tenUSD = Money(amount: 10, currency: "USD")
  let twelveUSD = Money(amount: 12, currency: "USD")
  let fiveGBP = Money(amount: 5, currency: "GBP")
  let fifteenEUR = Money(amount: 15, currency: "EUR")
  let fifteenCAN = Money(amount: 15, currency: "CAN")
 
//  Description tests
    func testDescriptions() {
        XCTAssert(tenUSD.description == "USD10")
        XCTAssert(twelveUSD.description == "USD12")
        XCTAssert(fiveGBP.description == "GBP5")
        XCTAssert(fifteenEUR.description == "EUR15")
        XCTAssert(fifteenCAN.description == "CAN15")
    }
    
//  Double extension tests
    func testDoubleExtension() {
        let sample = 10.0;
        XCTAssert(sample.USD().amount == 10)
        XCTAssert(sample.USD().currency == "USD")
        
        XCTAssert(sample.GBP().amount == 5)
        XCTAssert(sample.GBP().currency == "GBP")
        
        XCTAssert(sample.EUR().amount == 15)
        XCTAssert(sample.EUR().currency == "EUR")
        
        XCTAssert(sample.CAN().amount == 12)
        XCTAssert(sample.CAN().currency == "CAN")
    }
    
//  Mathematics protocol tests
    func testAddGBPandUSD() {
        let total = fiveGBP + tenUSD
        XCTAssert(total.amount == 10)
        XCTAssert(total.currency == "GBP")
    }
    
    func testAddUSDandUSD() {
        let total = tenUSD + tenUSD
        XCTAssert(total.amount == 20)
        XCTAssert(total.currency == "USD");
    }
    
    func testAddCANandUSD() {
        let total = fifteenCAN + twelveUSD
        XCTAssert(total.description == "CAN30")
    }
    
    func testAddEURandUSD() {
        let total = fifteenEUR + tenUSD
        XCTAssert(total.description == "EUR30")
    }
    
    func testMinusUSDandUSD() {
        let total = tenUSD - tenUSD
        XCTAssert(total.description == "USD0")
    }
    
    func testMinusGBPandUSD() {
        let total = fiveGBP - (tenUSD + tenUSD)
        XCTAssert(total.description == "GBP-5")
    }
    
    func testMinusCANandUSD() {
        let total = fifteenCAN - twelveUSD
        XCTAssert(total.description == "CAN0")
    }
    
    func testMinusEURandUSD() {
        let total = fifteenEUR - tenUSD
        XCTAssert(total.description == "EUR0")
    }
    
    

//  Previous tests and new description tests
  func testCanICreateMoney() {
    let oneUSD = Money(amount: 1, currency: "USD")
    XCTAssert(oneUSD.amount == 1)
    XCTAssert(oneUSD.currency == "USD")
    XCTAssert(oneUSD.description == "USD1")
    
    let tenGBP = Money(amount: 10, currency: "GBP")
    XCTAssert(tenGBP.amount == 10)
    XCTAssert(tenGBP.currency == "GBP")
    XCTAssert(tenGBP.description == "GBP10")
  }
  
  func testUSDtoGBP() {
    let gbp = tenUSD.convert("GBP")
    XCTAssert(gbp.currency == "GBP")
    XCTAssert(gbp.amount == 5)
    XCTAssert(gbp.description == "GBP5")
  }
  func testUSDtoEUR() {
    let eur = tenUSD.convert("EUR")
    XCTAssert(eur.currency == "EUR")
    XCTAssert(eur.amount == 15)
    XCTAssert(eur.description == "EUR15")
  }
  func testUSDtoCAN() {
    let can = twelveUSD.convert("CAN")
    XCTAssert(can.currency == "CAN")
    XCTAssert(can.amount == 15)
    XCTAssert(can.description == "CAN15");
  }
  func testGBPtoUSD() {
    let usd = fiveGBP.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
    XCTAssert(usd.description == "USD10");
  }
  func testEURtoUSD() {
    let usd = fifteenEUR.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
    XCTAssert(usd.description == "USD10");
  }
  func testCANtoUSD() {
    let usd = fifteenCAN.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 12)
    XCTAssert(usd.description == "USD12");
  }
  
  func testUSDtoEURtoUSD() {
    let eur = tenUSD.convert("EUR")
    let usd = eur.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
    XCTAssert(tenUSD.description == usd.description);
  }
  func testUSDtoGBPtoUSD() {
    let gbp = tenUSD.convert("GBP")
    let usd = gbp.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
    XCTAssert(tenUSD.description == usd.description)
  }
  func testUSDtoCANtoUSD() {
    let can = twelveUSD.convert("CAN")
    let usd = can.convert("USD")
    XCTAssert(twelveUSD.amount == usd.amount)
    XCTAssert(twelveUSD.currency == usd.currency)
    XCTAssert(twelveUSD.description == usd.description)
  }
  
  func testAddUSDtoUSD() {
    let total = tenUSD.add(tenUSD)
    XCTAssert(total.amount == 20)
    XCTAssert(total.currency == "USD")
    XCTAssert(total.description == "USD20")
  }
  
  func testAddUSDtoGBP() {
    let total = tenUSD.add(fiveGBP)
    XCTAssert(total.amount == 10)
    XCTAssert(total.currency == "GBP")
    XCTAssert(total.description == "GBP10")
  }
}

