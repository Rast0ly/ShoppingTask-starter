import XCTest

class C_MultibuyTests: XCTestCase {
    var offer : BuyOneGetOneFreeOffer!
    
    override func setUp() {
        super.setUp()
        offer = BuyOneGetOneFreeOffer()
    }
    
    override func tearDown() {
        offer = nil
        super.tearDown()
    }

    func bogofApplies(){

        XCTAssertFalse(offer.applies(to: [P.coke]),"Offer doesn't apply to just one item")
        XCTAssertFalse(offer.applies(to: [P.🍾,P.🍾]),"Offer doesn't apply to wrong products")
        XCTAssertFalse(offer.applies(to: [P.🍾,P.coke]),"Offer needs two valid items to apply")
        XCTAssertTrue(offer.applies(to: [P.coke,P.dietcoke]),"Offer applies to two different items, both on offer")
        XCTAssertTrue(offer.applies(to: [P.coke,P.dietcoke,P.dietcoke]),"Offer still applies to odd number of items")
        XCTAssertTrue(offer.applies(to: [P.🍾,P.🍾,P.chicken, P.coke, P.coke]),"Cokes not at start of list")
    }
    
    func testBOGOFApplicable(){
        bogofApplies()
    }
    
    func testBOGOFEvenNumberOfProducts(){
        bogofApplies()
        var list = [P.coke, P.dietcoke, P.dietcoke, P.cokezero ]
        XCTAssertEqual(offer.discount(for:list), 320, "BOGOF correct on even number of products")
        
        list = [P.cokezero, P.coke, P.dietcoke, P.dietcoke]
        XCTAssertEqual(offer.discount(for:list), 320, "Reordered products")
        
        list = [P.🍾,P.🍾,P.chicken,P.cokezero, P.coke, P.dietcoke, P.dietcoke]
        XCTAssertEqual(offer.discount(for:list), 320, "Extra invalid items at start")
        
        list.append(contentsOf: [P.coke, P.dietcoke, P.dietcoke, P.cokezero])
        XCTAssertEqual(offer.discount(for:list), 720, "BOGOF correct with twice the products")
    }
    
    func testBOGOFOddNumberOfProducts(){
        bogofApplies()
        var list = [P.coke, P.dietcoke, P.dietcoke]
        XCTAssertEqual(offer.discount(for:list), 200, "BOGOF correct on odd number of products")
        list = [P.coke, P.cokezero, P.coke]
        XCTAssertEqual(offer.discount(for:list), 200, "BOGOF correct on odd number of products, one cheaper")
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
        XCTAssertFalse(offer.applies(to: list),"not enough products, not enough deodorants")
        
        list.append(P.dove)
        XCTAssertFalse(offer.applies(to: list),"not enough products, not enough deodorants")
        
        list.append(P.milk)
        XCTAssertFalse(offer.applies(to: list),"enough products, not enough deodorants")
        
        list.append(P.lynx) //lynx (total of 3)
        XCTAssertTrue(offer.applies(to: list),"enough deodorants")
    }
    
    func testBuyTwoGetThirdFreeApplies(){
        deodorantApplies()
    }
    
    func testBuyTwoGetThirdFree4Items(){
        deodorantApplies()
        var list = [P.dove, P.dove, P.lynx, P.lynx] //(Lynx 319, Dove 219)
        XCTAssertEqual(offer.discount(for:list),219,"One of each price discounted");
        
        list = [P.lynx, P.lynx, P.dove, P.dove] //reordered
        XCTAssertEqual(offer.discount(for:list),219,"above, reordered");
    }
    
    func testBuyTwoGetThirdFree5Items(){
        deodorantApplies()
        var list = [P.lynx, P.lynx, P.dove, P.dove, P.dove]
        XCTAssertEqual(offer.discount(for:list),219,"Buy two get third free correct with 5 items");
        list = [P.lynx, P.lynx, P.lynx, P.dove, P.dove]
        XCTAssertEqual(offer.discount(for:list),319,"Buy two get third free correct with 5 items");
    }
    
    func testBuyTwoGetThirdFree6Items(){
        deodorantApplies()
        var list = [P.dove, P.dove, P.dove, P.lynx, P.lynx, P.lynx]
        XCTAssertEqual(offer.discount(for:list),538,"One of each price discounted");
        list = [P.dove, P.dove, P.dove, P.dove, P.lynx, P.lynx]
        XCTAssertEqual(offer.discount(for:list),438,"Two cheaper items discounted");
    }
 
}
