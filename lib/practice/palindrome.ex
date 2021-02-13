defmodule Practice.Palindrome do
  def isPalindrome(str) do
    isPalindromeAcc(str, 0, String.length(str) - 1)
  end

  def isPalindromeAcc(str, left, right) do
    cond do
      # base case
      left >= right -> 
        true
      
      # str[left] === str[right]
      String.at(str, left) == 
      String.at(str, right) ->
        isPalindromeAcc(str, left + 1, right - 1)
      
      # else
      true ->
        false
    end
  end

end