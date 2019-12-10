///Buy one get one free on varients of Coca-Cola
class BuyOneGetOneFreeOffer : MultiBuyOffer {

    var name: String
    var productIds : Set<Int>
    var quantityPaid: Int
    var quantityFree: Int

    init(){
        name = "2 for 1 on Coca-Cola"
        productIds = [401,402,403];
        quantityPaid = 1
        quantityFree = 1
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
    
    func applies(to purchases: [Product]) -> Bool {
        let count = timesIdAppearsInProductList(products: purchases)
        return  count > 1
    }
        
        
    
    
    func discount(for purchases: [Product]) -> Int {
        var filteredPro = [Int]()
        var total = [Int]()
        var sum = 0
        
        
        
        for purchase in purchases{
            if productIds.contains(purchase.id){
                filteredPro.append(purchase.price)
            }
        }
        filteredPro = filteredPro.sorted(by: { $0 > $1 })
        
        total = stride(from: 1, to: filteredPro.count, by: 2 ).map{filteredPro[$0] }
        
        for item in total{
            
            sum = sum + item
            }
            
        
        
        
        return sum
    }


}

