import exceptions._
import scala.collection.mutable.Queue

object TransactionStatus extends Enumeration {
  val SUCCESS, PENDING, FAILED = Value
}

class TransactionQueue {

    // TODO
    // project task 1.1
    // Add datastructure to contain the transactions
    
    private val queue = Queue[Transaction]() //A queue of transactions


    // Remove and return the first element from the queue
    def pop: Transaction = {
      this.synchronized { //Ensure sync on this object
        queue.dequeue //Return the value first in the queue
      }
    }

    // Return whether the queue is empty
    def isEmpty: Boolean = {
      this.synchronized {
        queue.isEmpty
      }
    }

    // Add new element to the back of the queue
    def push(t: Transaction): Unit = {
      this.synchronized {
        queue.enqueue(t)
      }
    }

    // Return the first element from the queue without removing it
    def peek: Transaction = {
      this.synchronized {
        queue.head
      }
    }

    // Return an iterator to allow you to iterate over the queue
    def iterator: Iterator[Transaction] = {
      this.synchronized {
        queue.iterator
      } 
    }
}

class Transaction(val transactionsQueue: TransactionQueue,
                  val processedTransactions: TransactionQueue,
                  val from: Account,
                  val to: Account,
                  val amount: Double,
                  val allowedAttemps: Int) extends Runnable {

  var status: TransactionStatus.Value = TransactionStatus.PENDING
  var attempt = 0

  override def run: Unit = {

      def doTransaction() = {
          // TODO - project task 3
          // Extend this method to satisfy requirements.
          //from withdraw amount
          //to deposit amount
          if (from.withdraw(amount).isLeft) { //The withdraw was successful
            if (to.deposit(amount).isLeft) { //The deposit was successful
              status = TransactionStatus.SUCCESS   
            }
            else //Deposit failed, need to reverse withdraw
            {
              from.deposit(amount) //This should always work if we just withdrew it.
            }
          }

          if (status == TransactionStatus.PENDING) { //If we are still pending, this means we did not succeed
            attempt += 1 //Need to increment attempt, since it failed
            
            if (attempt >= allowedAttemps) { //We have reached our maximum number of attempts
              status = TransactionStatus.FAILED
            }
          }
      }

      // TODO - project task 3
      // make the code below thread safe
      if (status == TransactionStatus.PENDING) {
        //Put the code in a sync block to sync it
        this.synchronized {
          doTransaction
          Thread.sleep(50) // you might want this to make more room for
                           // new transactions to be added to the queue
        }
      }



    }
}
