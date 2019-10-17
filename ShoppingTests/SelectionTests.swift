import XCTest

class H_SelectionTests: XCTestCase {

    var offer : DineInFor2For10PoundsOffer!
    
    override func setUp() {
        super.setUp()
        offer = DineInFor2For10PoundsOffer()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        offer = nil
        super.tearDown()
    }

    func dineInApplies(){
        var list = [P.🍗,P.mushrooms,P.chocPudding] //(no wine)
        XCTAssertFalse(offer.applies(to: list))
        list.append(P.mushrooms)
        XCTAssertFalse(offer.applies(to: list)) //enough pruducts, but not correct
        list.append(P.🍾)
        XCTAssertTrue(offer.applies(to: list))
    }
    
    func testDineInFor2For10PoundsApplies(){
        dineInApplies()
    }
    
    func testDineInFor2For10Pounds(){
        dineInApplies()
        var products = [P.🍷,P.🍗,P.mushrooms,P.chocPudding] //(299 + 299 + 300 + 399 = 1297
        XCTAssertEqual(offer.discount(for: products), 297)
        products.append(P.porkChops) //replaces chicken drumsticks, 51p more expensive
        XCTAssertEqual(offer.discount(for: products), 348)
        
        var manyProducts =  [P.🍷,P.🍗,P.mushrooms,P.chocPudding]
        for _ in 1...99 {
            manyProducts.append(contentsOf: [P.🍷,P.🍗,P.mushrooms,P.chocPudding])
        }
        XCTAssertEqual(offer.discount(for: manyProducts), 29700)
    }
    
    func testMultipleInstancesOfOffer(){
        //300, 300, 350, 299, 399, 299, 299, 299 = 2545
        var products = [P.mushrooms, P.mushrooms, P.porkChops, P.🍗, P.chocPudding, P.profiteroles, P.🍷, P.🍷]
        XCTAssertEqual(offer.discount(for:products), 545)
        products.append(P.🍗) //valid item, but cheaper so no price change
        XCTAssertEqual(offer.discount(for:products), 545)
        products.append(P.tiramisu) //499 replaces profiteroles (299)
        XCTAssertEqual(offer.discount(for:products), 745)
        products.append(P.coke) //irrelevant, no change
        XCTAssertEqual(offer.discount(for:products), 745)
    }

}



