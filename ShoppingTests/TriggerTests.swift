import XCTest

class F_TriggerTests: XCTestCase {

    var offer : FreeWaterWithNewspaperOffer!
    
    override func setUp() {
        super.setUp()
        offer = FreeWaterWithNewspaperOffer()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        offer = nil
        super.tearDown()
    }

    // MARK: Simple Trigger Offer
    func waterApplies(){
        let offer = FreeWaterWithNewspaperOffer()
        XCTAssertFalse(offer.appliesTo([P.smokedBacon]))
        XCTAssertFalse(offer.appliesTo([P.smokedBacon, P.smokedBacon])) //2 bacon
        XCTAssertFalse(offer.appliesTo([P.💧]))
        XCTAssertFalse(offer.appliesTo([P.💧,P.💧]))
        XCTAssertFalse(offer.appliesTo([P.📰]))
        XCTAssertFalse(offer.appliesTo([P.📰,P.📰]))
        XCTAssertTrue(offer.appliesTo([P.📰,P.💧]))
        XCTAssertTrue(offer.appliesTo([P.💧,P.📰]))
    }
    
    
    func testWaterApplicable(){
        waterApplies()
    }
    
    
    func testTwoWaterWithOnePaper(){
        waterApplies()
        let list = [P.💧,P.📰,P.💧]
        XCTAssertEqual(offer.discountFrom(list) ,P.💧.priceInPence * 1, "1 x water correctly discounted")
    }
    
    func testMoreWatersThanPapers(){
        waterApplies()
        var list = [P.📰,P.📰,P.💧,P.💧,P.💧]
        XCTAssertEqual(offer.discountFrom(list),P.💧.priceInPence * 2, "2 x water correctly discounted")
        list = [P.📰,P.📰,P.📰,P.💧,P.💧,P.💧,P.💧,P.💧,P.💧]
        XCTAssertEqual(offer.discountFrom(list),P.💧.priceInPence * 3, "3 x water correctly discounted")
    }
    
    func testMorePapersThanWaters(){
        waterApplies()
        var list =  [P.📰,P.📰,P.📰,P.💧,P.💧]
        XCTAssertEqual(offer.discountFrom(list),P.💧.priceInPence * 2, "2 x water correctly discounted")
        
        list = [P.📰,P.📰,P.📰,P.📰,P.📰,P.📰,P.📰,P.💧]
        XCTAssertEqual(offer.discountFrom(list),P.💧.priceInPence, "2 x water correctly discounted")
    }
    
    func testWaterAppliesFasterThanDiscount(){
        let testProducts = [P.📰,P.📰,P.📰,P.📰,P.📰,P.📰,P.📰,P.💧]
        XCTAssertTrue(Helper.shared.offer(offer, hasFasterAppliesMethodWith: testProducts), "B2G3F 'appliesTo' method should be quicker than its 'discountFrom' method")
    }
}


class G_TriggerFurtherTests: XCTestCase {

    var offer : FreeSoftenerWithDetergentOffer!
    
    override func setUp() {
        super.setUp()
        offer = FreeSoftenerWithDetergentOffer()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        offer = nil
        super.tearDown()
    }
    
    // MARK: More complex trigger Offer (detergent/softeners)
    

    func softenerApplies(){
        let justDetergents = [P.persil, P.ariel]
        XCTAssertFalse(FreeSoftenerWithDetergentOffer().appliesTo(justDetergents), "Offer not valid only on detergents")
        
        let justSofteners = [P.comfortSoftener,P.genericSoftener]
        XCTAssertFalse(FreeSoftenerWithDetergentOffer().appliesTo(justSofteners), "Offer not valid only on softeners")
        
        let detergentAndSoftener = [P.ariel, P.comfortSoftener]
        XCTAssertTrue(FreeSoftenerWithDetergentOffer().appliesTo(detergentAndSoftener), "Offer valid only on detergent and softener")
        
        XCTAssertTrue(FreeSoftenerWithDetergentOffer().appliesTo(detergentAndSoftener.reversed()), "Offer valid only on softener and detergent")
    }
    
    func testSoftenerApplicabilityOnlyOneProductType(){
        softenerApplies()
    }
    
    
    func testCheapSoftenerDetergentDiscount(){
        softenerApplies()
        let list = [P.persil, P.comfortSoftener, P.genericSoftener]
        XCTAssertEqual(offer.discountFrom(list), 429, "Softener Discount - one of each");
    }
    
    func testSoftenerDetergentDiscount(){
        softenerApplies()
        var list =  [P.persil, P.ariel, P.comfortSoftener, P.genericSoftener]
        XCTAssertEqual(offer.discountFrom(list), 828, "Softener Discount - one of each");
        
        //extra detergent
        list.append(P.persil)
        XCTAssertEqual(offer.discountFrom(list), 828, "Softener Discount - one more detergent");
        
        list.append(contentsOf: [P.ariel, P.comfortSoftener, P.genericSoftener])
        XCTAssertEqual(offer.discountFrom(list), 1656, "Softener Discount - two of each plus");
        
        list.append(P.comfortSoftener)
        XCTAssertEqual(offer.discountFrom(list), 1686, "Softener Discount - two of each plus one extra comfort");
        
        list = [P.premiumSoftener, P.genericSoftener, P.ariel]
        XCTAssertEqual(offer.discountFrom(list), 1200, "Softener Discount - more expensive softener");
        
    }
    
    func testSoftenerDetergentDiscountOneQualifyingProduct(){
        softenerApplies()
        let list = [P.persil, P.genericSoftener, P.comfortSoftener]
        XCTAssertEqual(offer.discountFrom(list), 429, "Softner discount with one qualifying product");

    }
    
    func testSoftenerAppliesFasterThanDiscount(){
        let testProducts = [P.ariel, P.comfortSoftener, P.genericSoftener]
        XCTAssertTrue(Helper.shared.offer(offer, hasFasterAppliesMethodWith: testProducts), "B2G3F 'appliesTo' method should be quicker than its 'discountFrom' method")
    }

}
