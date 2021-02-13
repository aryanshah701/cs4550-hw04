defmodule Practice.Factor do
  def factor(x) do 
    factorAcc(x, []) |> Enum.sort
  end

  def factorAcc(x, loP) do
    if x === 1 do
      loP
    else
      primeFactor = getFirstPrimeFactor(x)
      factorAcc(div(x, primeFactor), [primeFactor | loP])
    end
  end

  def getFirstPrimeFactor(x) do 
    getFirstPrimeFactorAcc(x, 2)
  end

  def getFirstPrimeFactorAcc(x, curr) do
    cond do
      rem(x, curr) === 0 && isPrime(curr) ->
        curr
      true ->
        getFirstPrimeFactorAcc(x, curr + 1)
    end
  end

  def isPrime(nn) do
    # nn shouldnt be divisible by any number from 2 to nn - 1
    isPrimeAcc(nn, 2)
  end

  def isPrimeAcc(nn, curr) do
    cond do
      # reached the end
      curr > nn - 1 ->
        true
      # if nn is divisble by curr return false
      rem(nn, curr) === 0 ->
        false
      # if not, then go onto the next number
      true -> 
        isPrimeAcc(nn, curr + 1)
    end
  end

end