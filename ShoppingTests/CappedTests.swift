import XCTest

class E_CappedTests: XCTestCase {

    var offer : ThreeMeatsForTenPoundOffer!
    
    override func setUp() {
        super.setUp()
        offer = ThreeMeatsForTenPoundOffer()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        offer = nil
        super.tearDown()
    }

    func applies(){
        let offer = ThreeMeatsForTenPoundOffer()
        XCTAssertFalse(offer.applies(to: [P.📰,P.📰,P.📰]))
        XCTAssertFalse(offer.applies(to: [P.mince,P.📰,P.mince]))
        XCTAssertTrue(offer.applies(to: [P.mince,P.mince,P.mince])) // 3 x beef mince (£15)
        XCTAssertTrue(offer.applies(to: [P.porkChops, P.porkChops,P.🍗,P.porkChops, P.porkChops, P.🍗]))
        XCTAssertFalse(offer.applies(to: [P.🍗,P.🍗,P.🍗,P.🍗,P.🍗,P.🍗,P.🍗]),"Valid products but not expensive enough to trigger offer")
    }
    
    func testApplicable(){
        applies()
    }
    
    func testFiveItems(){
        applies()
        var list = [P.smokedBacon,P.unsmokedBacon,P.chicken,P.mince,P.porkChops] //  400p, 400p, 450p, 500p, 350p
        XCTAssertEqual(offer.discount(for:list), 350, "Meat discount calculated correctly with 5 items")
        list = [P.smokedBacon,P.unsmokedBacon,P.🍗]
        XCTAssertEqual(offer.discount(for:list),99, "3 items over £10, last under £3.33")
    }
    
    func testCheapItems(){
        applies()
        var list = [P.🍗,P.🍗,P.🍗] //299,299,299
        XCTAssertEqual(offer.discount(for:list), 0, "No discount / increase in price with low price meat")
        list = ([P.🍗,P.🍗,P.🍗,P.🍗,P.🍗,P.🍗,P.🍗,P.🍗,P.🍗,P.🍗]) //299 x many
        XCTAssertEqual(offer.discount(for:list), 0, "No discount / increase in price with lots of cheap meat")
        list.append(contentsOf: [P.unsmokedBacon, P.smokedBacon, P.chicken]) //400, 400, 450
        XCTAssertEqual(offer.discount(for:list), 250, "Discount with second set of meat")
    }
    
    func testManyItems(){
        applies()
        var list = [Product]()
        for _ in 1...100{
            list.append(P.smokedBacon) //Smoked Bacon 6 pack   400p
            list.append(P.unsmokedBacon) //Unsmoked Bacon 6 pack 400p
            list.append(P.chicken) //Chicken Breasts 400g  450p
        }
        XCTAssertEqual(offer.discount(for:list),25000, "Meat discount calculated correctly with 300 items")
        
        list.append(P.chicken) //Chicken Breasts 400g  450p
        XCTAssertEqual(offer.discount(for:list),25050, "Meat discount calculated correctly with 301 items")
    }
    
    func testMixCheapAndExpensive(){
        XCTAssertEqual(offer.discount(for:[P.🍗,P.🍗,P.🍗,P.mince,P.mince,P.mince]),500,"Should apply to mince")
        
        XCTAssertEqual(offer.discount(for:[P.🍗,P.mince,P.🍗,P.🍗,P.mince,P.🍗]),299,"Should apply to 2 mince and 1 chicken")
        XCTAssertEqual(offer.discount(for:[P.porkChops, P.porkChops,P.🍗,P.porkChops, P.porkChops, P.🍗]),50)
    }
    

    

}
