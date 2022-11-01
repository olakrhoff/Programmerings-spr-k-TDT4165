import java.util.concurrent.atomic.AtomicInteger
import scala.concurrent.duration._
import scala.concurrent.Await
import scala.concurrent.Future
import scala.concurrent.ExecutionContext.Implicits.global

object Task1and2 extends App 
{
  //Task 1 b
  val sumArray = (array: Array[Int]) =>
  {
    var sum: Int = 0
    for (i <- 0 to array.length - 1)
      sum += array(i)

    sum
  }

  //Task 1 c
  def sumArrayRecursive(array: Array[Int]): Int =
  {
    if (array.length == 0)
    {
      0
    }
    else
    {
      array.head + sumArrayRecursive(array.tail)
    }
  }

  //Task 1 d
  //F_0 = 0
  //F_1 = 1
  //F_N = F_(N-1) + F_(N-2)
  def fibonacciRecursive(nth: Int): BigInt =
  {
    if (nth < 2)
    {
      nth
    }
    else
    {
      fibonacciRecursive(nth - 1) + fibonacciRecursive(nth - 2)
    }
  }

  println("Starting task 1")

  //Task 1 a
  var numbers: Array[Int] = new Array(50)
  for(i <- 0 to 49)
    numbers(i) = i + 1

  for(i <- 0 to 49) 
  { 
    print(numbers(i))
    print(", ")
  }

  //Task 1 b
  println(sumArray(numbers))
  //Task 1 c
  println(sumArrayRecursive(numbers))
  
  for (n <- 0 to 10)
    println(fibonacciRecursive(n))

  println("")
  println("Task 1 is done")
  println("--------------------------------")
  println("Starting task 2") 


  //Task 2 a
  def threadFunction(func: () => Unit): Thread =
  {
    new Thread
    {
      override def run()
      {
        func()
      }
    }
  }
  
  var thread1 = threadFunction(() => println("Function called"))

  thread1.start()
  thread1.join()

  //Task 2 b
  private var counter: Int = 0
  def increaseCounter(): Unit = 
  {
    counter += 1
  }

  def printCounter() =
  {
    print("Counter is equal to: ")
    println(counter)
  }
  
  threadFunction(increaseCounter).start
  threadFunction(increaseCounter).start
  var t1 = threadFunction(printCounter)
  t1.start
  t1.join

  //Task 2 c
  private var atomicCounter: AtomicInteger = new AtomicInteger
  def safeIncreaseCounter(): Integer =
  {
    atomicCounter.incrementAndGet
  }

  def printAtomicCounter(): Unit =
  {
    print("Atomic counter: ")
    println(atomicCounter.get)
  }

  threadFunction(safeIncreaseCounter).start
  threadFunction(safeIncreaseCounter).start
  var t2 = threadFunction(printAtomicCounter)
  t2.start
  t2.join

  //Task 2 d
  object ResourceA
  {
    lazy val someValue = 123
    lazy val someDependetValue = ResourceB.someDependetValue
  }
  
  object ResourceB {
    lazy val someDependetValue = ResourceA.someValue
  }
  
  object DeadLock
  {
    def deadlockFunction =
    {
      val result = Future.sequence(Seq(
        Future
        {
          ResourceA.someDependetValue
        },
        Future
        {
          ResourceB.someDependetValue
        }
      ))
      Await.result(result, 5.second)
    }
  }
  DeadLock.deadlockFunction

  println("Task 2 is done")
}

