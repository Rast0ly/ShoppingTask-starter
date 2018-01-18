import XCTest

class C_MultibuyTests: XCTestCase {


    
    var offer : BuyOneGetOneFreeOffer!
    
    override func setUp() {
        super.setUp()
        offer = BuyOneGetOneFreeOffer()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        offer = nil
        super.tearDown()
    }

    // MARK: Multibuy Offer (BOGOF)
    func bogofApplies(){
        let offer = BuyOneGetOneFreeOffer()

        XCTAssertFalse(offer.appliesTo([P.coke]),"Offer doesn't apply to just one item")
        XCTAssertFalse(offer.appliesTo([P.🍾,P.🍾]),"Offer doesn't apply to wrong products")
        XCTAssertTrue(offer.appliesTo([P.coke,P.dietcoke]),"Offer applies to two different items, both on offer")
        XCTAssertTrue(offer.appliesTo([P.coke,P.dietcoke,P.dietcoke]),"Offer still applies to odd number of items")
    }
    
    func testBOGOFApplicable(){
        bogofApplies()
    }
    
    func testBOGOFEvenNumberOfProducts(){
        bogofApplies()
        var list = [P.coke, P.dietcoke, P.dietcoke, P.cokezero ]
        XCTAssertEqual(offer.discountFrom(list), 320, "BOGOF correct on even number of products")
        list.append(contentsOf: [P.coke, P.dietcoke, P.dietcoke, P.cokezero])
        XCTAssertEqual(offer.discountFrom(list), 720, "BOGOF correct with twice the products")
    }
    
    func testBOGOFOddNumberOfProducts(){
        bogofApplies()
        var list = [P.coke, P.dietcoke, P.dietcoke]
        XCTAssertEqual(offer.discountFrom(list), 200, "BOGOF correct on odd number of products")
        list = [P.coke, P.cokezero, P.coke]
        XCTAssertEqual(offer.discountFrom(list), 200, "BOGOF correct on odd number of products, one cheaper")
    }

    func testBOGOFAppliesFasterThanDiscount(){
        let testProducts = [P.coke, P.dietcoke, P.dietcoke, P.cokezero]
        XCTAssertTrue(Helper.shared.offer(offer, hasFasterAppliesMethodWith: testProducts),"BOGOFOffer 'appliesTo' method should be quicker than the 'discountFrom' method")
    }

}

class D_MultiBuyFurtherTests : XCTestCase {
    
    var offer : BuyTwoGetThirdFreeOffer!
    
    override func setUp() {
        super.setUp()
        offer = BuyTwoGetThirdFreeOffer()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        offer = nil
        super.tearDown()
    }
    
    // MARK: Multibuy offer (Deodorants)
    func deodorantApplies(){
        let offer = BuyTwoGetThirdFreeOffer()
        var list = [P.dove]
        XCTAssertFalse(offer.appliesTo(list),"not enough products, not enough deodorants")
        
        list.append(P.dove)
        XCTAssertFalse(offer.appliesTo(list),"not enough products, not enough deodorants")
        
        list.append(P.milk)
        XCTAssertFalse(offer.appliesTo(list),"enough products, not enough deodorants")
        
        list.append(P.lynx) //lynx (total of 3)
        XCTAssertTrue(offer.appliesTo(list),"enough deodorants")
    }
    
    func testBuyTwoGetThirdFreeApplies(){
        deodorantApplies()
    }
    
    func testBuyTwoGetThirdFree4Items(){
        deodorantApplies()
        let list = [P.dove, P.dove, P.lynx, P.lynx] //(Lynx 319, Dove 219)
        XCTAssertEqual(offer.discountFrom(list),219,"One of each price discounted");
    }
    
    func testBuyTwoGetThirdFree5Items(){
        deodorantApplies()
        var list = [P.lynx, P.lynx, P.dove, P.dove, P.dove]
        XCTAssertEqual(offer.discountFrom(list),219,"Buy two get third free correct with 5 items");
        list = [P.lynx, P.lynx, P.lynx, P.dove, P.dove]
        XCTAssertEqual(offer.discountFrom(list),319,"Buy two get third free correct with 5 items");
    }
    
    func testBuyTwoGetThirdFree6Items(){
        deodorantApplies()
        var list = [P.dove, P.dove, P.dove, P.lynx, P.lynx, P.lynx]
        XCTAssertEqual(offer.discountFrom(list),538,"One of each price discounted");
        list = [P.dove, P.dove, P.dove, P.dove, P.lynx, P.lynx]
        XCTAssertEqual(offer.discountFrom(list),438,"Two cheaper items discounted");
    }
    
    func testBuyTwoGetThirdFreeAppliesFasterThanDiscount(){
        let testProducts = [P.dove, P.dove, P.dove, P.lynx, P.lynx, P.lynx]
        XCTAssertTrue(Helper.shared.offer(offer, hasFasterAppliesMethodWith: testProducts), "B2G3F 'appliesTo' method should be quicker than its 'discountFrom' method")
    }
    
}
