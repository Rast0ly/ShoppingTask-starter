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
    
    
    
    func totalOverTenPounds(products: [Product]) -> Int {
        var total = 0
        let sorted = products.sorted(by: {$0.price > $1.price })
        var coun = 0
        for product in sorted{
            if productIds.contains(product.id){
            coun += 1
            total += product.price
            if coun >=   productQuantity {
                break
                }
            }
        }
        return total
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
        let total = totalOverTenPounds(products: (purchases))
       
        return count >= productQuantity && total >= maxPrice
    }
       

    
    func discount(for purchases: [Product]) -> Int {
        
        var discount = 0
        var purchasesOnOffer = purchases.filter() { productIds.contains($0.id) }
        purchasesOnOffer.sort(by: {$0.price > $1.price })
        
        while purchasesOnOffer.count >= productQuantity{
            var totalPrice = 0
            
            
            for _ in 0..<productQuantity{
                let item = purchasesOnOffer.remove(at: 0)
                totalPrice += item.price
            }
           
            if totalPrice > maxPrice{
                discount += totalPrice - maxPrice
            }else{
                break
            }
        }
        return discount
    }
}




