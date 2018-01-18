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

    func threeMeatsApplies(){
        let offer = ThreeMeatsForTenPoundOffer()
        XCTAssertFalse(offer.appliesTo([P.📰,P.📰,P.📰]))
        XCTAssertFalse(offer.appliesTo([P.mince,P.📰,P.mince]))
        XCTAssertTrue(offer.appliesTo([P.mince,P.mince,P.mince])) // 3 x beef mince (£15)
        XCTAssertFalse(offer.appliesTo([P.🍗,P.🍗,P.🍗,P.🍗,P.🍗,P.🍗,P.🍗]),"Valid products but not expensive enough to trigger offer")
    }
    
    func testThreeMeatsApplicable(){
        threeMeatsApplies()
    }
    
    func testThreeMeatForTenPoundsFiveItems(){
        threeMeatsApplies()
        var list = [P.smokedBacon,P.unsmokedBacon,P.chicken,P.mince,P.porkChops] //  400p, 400p, 450p, 500p, 350p
        XCTAssertEqual(offer.discountFrom(list), 350, "Meat discount calculated correctly with 5 items")
        list = [P.smokedBacon,P.unsmokedBacon,P.🍗]
        XCTAssertEqual(offer.discountFrom(list),99, "3 items over £10, last under £3.33")
    }
    
    func testThreeMeatForTenPoundsCheapItems(){
        threeMeatsApplies()
        var list = [P.🍗,P.🍗,P.🍗] //299,299,299
        XCTAssertEqual(offer.discountFrom(list), 0, "No discount / increase in price with low price meat")
        list = ([P.🍗,P.🍗,P.🍗,P.🍗,P.🍗,P.🍗,P.🍗,P.🍗,P.🍗,P.🍗]) //299 x many
        XCTAssertEqual(offer.discountFrom(list), 0, "No discount / increase in price with lots of cheap meat")
        list.append(contentsOf: [P.unsmokedBacon, P.smokedBacon, P.chicken]) //400, 400, 450
        XCTAssertEqual(offer.discountFrom(list), 250, "Discount with second set of meat")
    }
    
    func testThreeMeatForTenPoundsManyItems(){
        threeMeatsApplies()
        var list = [Product]()
        for _ in 1...100{
            list.append(P.smokedBacon) //Smoked Bacon 6 pack   400p
            list.append(P.unsmokedBacon) //Unsmoked Bacon 6 pack 400p
            list.append(P.chicken) //Chicken Breasts 400g  450p
        }
        XCTAssertEqual(offer.discountFrom(list),25000, "Meat discount calculated correctly with 300 items")
        
        list.append(P.chicken) //Chicken Breasts 400g  450p
        XCTAssertEqual(offer.discountFrom(list),25050, "Meat discount calculated correctly with 301 items")
    }
    
    func testBuyTwoGetThirdFreeAppliesFasterThanDiscount(){
        let testProducts = [P.smokedBacon,P.unsmokedBacon,P.chicken,P.mince,P.porkChops, P.chocPudding]
        XCTAssertTrue(Helper.shared.offer(offer, hasFasterAppliesMethodWith: testProducts), "B2G3F 'appliesTo' method should be quicker than its 'discountFrom' method")
    }
    

}
