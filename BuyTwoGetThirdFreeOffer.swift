/// Third item free when you buy any two deodorants
class BuyTwoGetThirdFreeOffer :MultiBuyOffer {
    
    
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
        
            return  count >= 3
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
       
       total = stride(from: quantityPaid , to: filteredPro.count, by: 3).map{ filteredPro[$0] }
       
       for item in total {
           sum = sum + item
        }
       return sum
   }
    
    var quantityPaid: Int
    var quantityFree: Int
    var name: String
    var productIds : Set<Int>
    
    init(){
        name = "3 for 2 on Deodorants"
        productIds = [65,66];
        quantityPaid = 2
        quantityFree = 1
    }

}
