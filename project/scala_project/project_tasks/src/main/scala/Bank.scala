class Bank(val allowedAttempts: Integer = 3) {

    private val transactionsQueue: TransactionQueue = new TransactionQueue()
    private val processedTransactions: TransactionQueue = new TransactionQueue()

    def addTransactionToQueue(from: Account, to: Account, amount: Double): Unit = {
      //Create the new transaction object
      val transaction = new Transaction(transactionsQueue,
                                        processedTransactions,
                                        from,
                                        to,
                                        amount,
                                        allowedAttempts)

      //Put the transaction object in the queue
      transactionsQueue.push(transaction)
      
      //Spawn a thread that calls the processedTransactions
      val thread = new Thread {
        override def run() {
          processTransactions
        }
      }

      //Start the thread
      thread.start()
    }
                                                // TODO
                                                // project task 2
                                                // create a new transaction object and put it in the queue
                                                // spawn a thread that calls processTransactions

    private def processTransactions: Unit = {
      //Pop the transaction from the queue
      val transaction: Transaction = transactionsQueue.pop
      //transaction.run()
      //Spawn a thread that executes the transaction
      val thread = new Thread {
        override def run() {
          transaction.run()
        }
      }

      //Start the thread
      thread.start()

      //We sync while checking the value of the transaction status
      if (transaction synchronized {transaction.status == TransactionStatus.PENDING}) { //The transaction is pending
        transactionsQueue.push(transaction) //Still working, add back in queue
        processTransactions //Call again and check the queue
      }
      else { //The transaction is done, either failed or succeeded
        processedTransactions.push(transaction)
      }
    }
                                                // TODO
                                                // project task 2
                                                // Function that pops a transaction from the queue
                                                // and spawns a thread to execute the transaction.
                                                // Finally do the appropriate thing, depending on whether
                                                // the transaction succeeded or not

    def addAccount(initialBalance: Double): Account = {
        new Account(this, initialBalance)
    }

    def getProcessedTransactionsAsList: List[Transaction] = {
        processedTransactions.iterator.toList
    }

}
