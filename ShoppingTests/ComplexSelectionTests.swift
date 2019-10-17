import XCTest

class I_ComplexSelectionTests: XCTestCase {
    
    var offer : WinterWarmerOffer!
    
    override func setUp() {
        super.setUp()
        offer = WinterWarmerOffer()
    }
    
    override func tearDown() {
        offer = nil
        super.tearDown()
    }
    
    func offerApplies(){
        
        let notEnoughPizzas = [P.meatPizza, P.cookies, P.doughBalls, P.doughBalls, P.garlicBread]
        XCTAssertFalse(offer.applies(to: notEnoughPizzas))
        
        var items = [P.meatPizza, P.veggiePizza, P.doughBalls, P.doughBalls, P.garlicBread]
        XCTAssertFalse(offer.applies(to: items))
        
        items.append(P.cookies)
        XCTAssertTrue(offer.applies(to: items))
        
        items.append(contentsOf: [P.meatPizza, P.veggiePizza, P.doughBalls, P.doughBalls, P.garlicBread, P.cookies])
        
        XCTAssertTrue(offer.applies(to: items))
    }
    
    func testOfferApplies() {
        offerApplies()
    }
    
    func testdiscountOneInstanceOfOffer(){
        offerApplies()
        //1849 + 1799 + 499 + 499 + 400 + 349 = 5395 so discount 3296
        var items = [P.meatPizza, P.veggiePizza, P.doughBalls, P.doughBalls, P.garlicBread, P.cookies]
        XCTAssertEqual(offer.discount(for:items), 3296)
        
        items.append(contentsOf: [P.veggiePizza, P.veggiePizza, P.doughBalls, P.doughBalls])//extra pizza and sides,
        XCTAssertEqual(offer.discount(for:items), 3296)
    }
    
    
    
    func testdiscountTwoInstancesOfOffer(){
        offerApplies()
        //1849 + 1799 + 499 + 499 + 400 + 349 = 5395 so discount 3296 (twice)
        var items = [P.meatPizza, P.veggiePizza, P.doughBalls, P.doughBalls, P.garlicBread, P.cookies, P.meatPizza, P.veggiePizza, P.doughBalls, P.doughBalls, P.garlicBread, P.cookies]
        XCTAssertEqual(offer.discount(for:items), 6592)
        
        //add meat pizza (cheapest veg disregarded, so discount raised by 50p)
        items.append(P.meatPizza)
        XCTAssertEqual(offer.discount(for:items), 6642)
    }
    

    
}

