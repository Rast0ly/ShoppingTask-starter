import XCTest

class I_ComplexSelectionTests: XCTestCase {
    
    var offer : GenericComplexSelectionOffer!
    
    override func setUp() {
        super.setUp()
        
        let pizzas = [P.meatPizza, P.veggiePizza, P.pepperoniPizza]
        let sides = [P.doughBalls, P.potatoWedges]
        let garlicBreads = [P.flatGarlicBread, P.garlicBread]
        let desserts = [P.cookies]
        
        let pizzaRule = (items: Set(pizzas.map({$0.id})), quantity: 2)
        let sidesRule = (items: Set(sides.map({$0.id})), quantity: 2)
        let garlicBreadRule = (items: Set(garlicBreads.map({$0.id})), quantity: 1)
        let dessertRule = (items: Set(desserts.map({$0.id})), quantity: 1)
        
        offer = GenericComplexSelectionOffer(name: "Winter Warmer", productIdGroupsAndQuantities: [pizzaRule, sidesRule, garlicBreadRule, dessertRule], maxPrice: 2099)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        offer = nil
        super.tearDown()
    }
    
    func offerApplies(){
        var items = [P.meatPizza, P.veggiePizza, P.doughBalls, P.doughBalls, P.garlicBread]
        XCTAssertFalse(offer.appliesTo(items))
        
        items.append(P.cookies)
        XCTAssertTrue(offer.appliesTo(items))
    }
    
    func testOfferApplies() {
        offerApplies()
    }
    
    func testdiscountOneInstanceOfOffer(){
        offerApplies()
        //1849 + 1799 + 499 + 499 + 400 + 349 = 5395 so discount 3296
        let items = [P.meatPizza, P.veggiePizza, P.doughBalls, P.doughBalls, P.garlicBread, P.cookies]
        XCTAssertEqual(offer.discountFrom(items), 3296)
    }
    
    func testdiscountTwoInstancesOfOffer(){
        offerApplies()
        //1849 + 1799 + 499 + 499 + 400 + 349 = 5395 so discount 3296 (twice)
        var items = [P.meatPizza, P.veggiePizza, P.doughBalls, P.doughBalls, P.garlicBread, P.cookies, P.meatPizza, P.veggiePizza, P.doughBalls, P.doughBalls, P.garlicBread, P.cookies]
        XCTAssertEqual(offer.discountFrom(items), 6592)
        
        //add meat pizza (cheapest veg disregarded, so discount raised by 50p)
        items.append(P.meatPizza)
        XCTAssertEqual(offer.discountFrom(items), 6642)
        
    }
    
    
}

