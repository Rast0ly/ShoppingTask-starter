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
        XCTAssertFalse(offer.appliesTo([P.coke]),"Half Price offer not applicable on Coke")//1.75l Coca-Cola 200p
        XCTAssertTrue(offer.appliesTo([P.🍾]),"Half price offer applicable to wine") // 499p)
        XCTAssertTrue(offer.appliesTo([P.🍾,P.coke]),"Half price offer applicable when Wine included in list") //Wine and Coke
    }
    
    func testHalfPriceApplicable(){
        halfPriceApplicable()
    }
    
    func testHalfPrice(){
        halfPriceApplicable()
        XCTAssertEqual(offer.discountFrom([P.🍾]),249,"directly applied offer, 1 product")
        XCTAssertEqual(offer.discountFrom([P.🍾]),249,"directly applied offer, 1 product, second time (checks for ivar use")
        var list = [P.🍾] // 499p
        XCTAssertEqual(offer.discountFrom(list),249, "Half Price discount applied (1 product)")
        list.append(P.🍷) //  299p
        XCTAssertEqual(offer.discountFrom(list),398, "Half Price discount applied (2 products)")
        list.append(P.🍷) //  299p
        XCTAssertEqual(offer.discountFrom(list),547, "Half Price discount applied (3 products)")
    }
    
    
    func testHalfPriceSomeIneligibleProducts(){
        halfPriceApplicable()
        let list = [P.🍾, P.chicken, P.📰] // 499p, 450p, 120
        XCTAssertEqual(offer.discountFrom(list),249, "Half Price discount applied only to eligible products")
    }
    
    func testHalfPriceAppliesFasterThanDiscount(){
        let testProducts = [P.🍾,P.🍾,P.🍾,P.🍾]
        XCTAssertTrue(Helper.shared.offer(offer, hasFasterAppliesMethodWith: testProducts), "HalfPriceOffer 'appliesTo' method should be quicker than its 'discountFrom' method")
    }
    

}
