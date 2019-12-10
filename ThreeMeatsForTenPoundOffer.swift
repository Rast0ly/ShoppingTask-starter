///Three meats for a maximum of £10 🍗🍗🍗 
class ThreeMeatsForTenPoundOffer : CappedOffer{

    var name: String
    var productIds : Set<Int>
    var maxPrice: Int
    var productQuantity : Int
    
    init(){
        name = "Three meats for £10"
        productIds = [301,302,303,304,305,306]
        maxPrice = 1000
        productQuantity = 3
    }
    
    func timesIdAppearsInProductList(products: [Product]) -> Int {
              var count = 0
              for product in products {
                  if productIds.contains(product.id)  {
                      count += 1
                  }
              }
              return count
          }
    
    func totalOverTenPounds(products: [Product]) -> Int {
        var total = 0
        for product in products{
            if productIds.contains(product.price){
                 total += Int(Double(product.price) >= maxPrice
        }
        }
        
        
        return 0
    }
        
    func applies(to purchases: [Product]) -> Bool {
        
        let count = timesIdAppearsInProductList(products: purchases)
        
            return  count >= 3
        
    }
    
    func discount(for purchases: [Product]) -> Int {
        return 0
    }
}
//sort by price order then have it go though the list and make every 3rd item free if the total of the 3 items is over 10 quid.
