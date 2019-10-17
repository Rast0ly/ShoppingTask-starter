import XCTest

class B_DiscountedPriceTests: XCTestCase {

    var offer : HalfPriceOffer!
    
    override func setUp() {
        super.setUp()
        offer = HalfPriceOffer()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        offer = nil
        super.tearDown()
    }

    // MARK: DiscountedPrice Offer (Half price)
    
    func halfPriceApplicable(){
        XCTAssertFalse(offer.applies(to: [P.coke]),"Half Price offer not applicable on Coke")//1.75l Coca-Cola 200p
        XCTAssertTrue(offer.applies(to:[P.🍾]),"Half price offer applicable to wine") // 499p)
        XCTAssertTrue(offer.applies(to:[P.🍾,P.coke]),"Half price offer applicable when Wine included in list") //Wine and Coke
        XCTAssertTrue(offer.applies(to:[P.coke, P.🍾]),"Half price offer applicable when Wine is not first in the list") //Coke and Wine
    }
    
    func testHalfPriceApplicable(){
        halfPriceApplicable()
    }
    
    func testHalfPrice(){
        halfPriceApplicable()
        XCTAssertEqual(offer.discount(for:[P.🍾]),249,"directly applied offer, 1 product")
        var list = [P.🍾] // 499p
        XCTAssertEqual(offer.discount(for:list),249, "second time (checks for ivar use")
        list.append(P.🍷) //  299p
        XCTAssertEqual(offer.discount(for:list),398, "Half Price discount applied (2 products)")
        list.append(P.🍷) //  299p
        XCTAssertEqual(offer.discount(for:list),547, "Half Price discount applied (3 products)")
    }
    
    
    func testHalfPriceSomeIneligibleProducts(){
        halfPriceApplicable()
        let list = [P.🍾, P.chicken, P.📰] // 499p, 450p, 120
        XCTAssertEqual(offer.discount(for:list),249, "Half Price discount applied only to eligible products")
    }
    

    

}
