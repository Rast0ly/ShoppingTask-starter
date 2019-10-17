class ReceiptPrinter {

    private var transaction : Transaction
    
    init(transaction: Transaction){
        self.transaction = transaction
    }
    
    private func receiptLine(description: String, price: Int, width: Int) -> String{
        
        var length = width - description.utf16.count
        
        let pounds = price / 100
        let pence = price % 100
        let penceString = pence < 10 ? "0\(pence)" : "\(pence)"
        let priceString = "£\(pounds).\(penceString)"
        length -= priceString.utf16.count
        
        var line = description
        for _ in 1...length {
            line += "."
        }
        line += priceString + "\n"
        return line
    }
    
    func print() -> String{
        
        let width = 34
        var receiptPrintOut = String();
        
        receiptPrintOut += "**********************************\n"
        receiptPrintOut += "***********Your Reciept***********\n\n"
        
        //all products
        for item in transaction.items {
            receiptPrintOut += receiptLine(description: item.name, price: item.price, width: width)
        }
        
        //sub total
        receiptPrintOut += "\n" + receiptLine(description: "Sub Total:", price: transaction.priceBeforeDiscounts(), width: width)
        
        //all discounts
        receiptPrintOut += "\n**********Offers applied**********\n"
        
        let offerApp = Discounter()
        let discountLines = offerApp.offerDiscounts(list: transaction.items)
        for line in discountLines {
            receiptPrintOut += receiptLine(description: line.name, price: line.valueInPence, width: width)
        }
        
        //discount total
        receiptPrintOut += "\n" + receiptLine(description: "You have saved:", price: transaction.discount(), width: width)
        
        receiptPrintOut += "\n**********************************\n"
        //final total
        receiptPrintOut += receiptLine(description: "Grand Total:", price: transaction.finalPrice(), width: width)
        receiptPrintOut += "**********************************"
        
        //Swift.print(receiptPrintOut)
        
        return receiptPrintOut;
    }
}
