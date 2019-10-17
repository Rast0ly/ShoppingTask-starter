
import XCTest

class X_ExtensionTests: XCTestCase {
    
    
    func testDicount(){
        
        let offer = B2G2F()
        let products = [P.dove,P.dove,P.dove,P.dove,P.dove,P.dove,P.dove,P.dove]
        let fullPrice = products.reduce(0) {$0 + $1.price}
        let discount = fullPrice / 2;
        XCTAssertEqual(discount, offer.discount(for:Array(products)))
        
        
    }
}
