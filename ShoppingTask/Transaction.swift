class Transaction {
    
    var couponsEnabled = false
    var items = [Product]()
    
    func priceBeforeDiscounts() -> Int{
        
       var totalPrice = 0
        
        for product in items {
            let price = product.price
             
            totalPrice =  price + totalPrice
            
        }
        
        //sum up the price of all items
        return totalPrice
    }
    
    func discount() -> Int{
        
        let discounts = Discounter(couponsEnabled: couponsEnabled).offerDiscounts(list: items)
        var total = 0;
        for discount in discounts {
            total += discount.valueInPence;
        }
        return  total;
    }
    
    func finalPrice() -> Int{
        
        var ddp = 0
        
        ddp = priceBeforeDiscounts() - discount()
        
        return ddp
    }
    
    
}
