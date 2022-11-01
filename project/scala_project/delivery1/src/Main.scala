object Task1 extends App 
{
  val sumArray = (array: Array[Int]) =>
  {
    var sum: Int = 0
    for (i <- 0 to array.length - 1)
      sum += array(i)

    sum
  }

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
  
  var numbers: Array[Int] = new Array(50)
  for(i <- 0 to 49)
    numbers(i) = i + 1

  println(sumArray(numbers))
  println(sumArrayRecursive(numbers))
  
  for (n <- 0 to 10)
    println(fibonacciRecursive(n))

  for(i <- 0 to 49) 
  { 
    print(numbers(i))
    print(", ")
  }
  println("")
  println("Task 1 is done")
}

