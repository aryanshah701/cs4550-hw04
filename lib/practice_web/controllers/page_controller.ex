defmodule PracticeWeb.PageController do
  use PracticeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def double(conn, %{"x" => x}) do
    try do
      {x, _} = Integer.parse(x)
      y = Practice.double(x)
      render conn, "double.html", x: x, y: y
    rescue
      _e -> render conn, "double.html", x: x, y: "Sorry, error"
    end
  end

  def calc(conn, %{"expr" => expr}) do
    try do
      y = Practice.calc(expr)
      render conn, "calc.html", expr: expr, y: y
    rescue
      _e -> 
        render conn, "calc.html", expr: expr, y: "Error"
    end
  end

  def factor(conn, %{"x" => x}) do
    try do
      {x, _rest} = Integer.parse(x)
      y = inspect(Practice.factor(x))
      render conn, "factor.html", x: x, y: y
    rescue
      _e -> 
        render conn, "factor.html", x: x, y: "Error"
    end
  end

  def palindrome(conn, %{"str" => str}) do
    if str do
      isPalindrome = Practice.palindrome(str)
      render conn, "palindrome.html", str: str, isPalindrome: isPalindrome
    else
      render conn, "palindrome.html", str: "", isPalindrome: true
    end
  end

end
