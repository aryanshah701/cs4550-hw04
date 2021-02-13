defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    expr
    |> String.split(" ")
    |> infixToPostfix
    |> evaluatePostfixExpr
    |> stringToFloat
  end

  def evaluatePostfixExpr(postfixExpr) do
    postfixExpr
    |> String.split(" ")
    |> evaluatePostfixExprAcc([])
  end

  def evaluatePostfixExprAcc(listOfTerms, operandStack) do
    if Enum.empty?(listOfTerms) do
      # Entire expression has been evaluated so return result
      case operandStack do
        [result] -> result
        _ -> raise "Invalid expression: #{operandStack}"
      end

    else
      [curr | rest] = listOfTerms

      if !isOperator(curr) do
        # If curr is an operand add to to the stack and move on
        evaluatePostfixExprAcc(rest, [curr | operandStack])
    
      else
        # Else, evaluate the last two operands in the stack
        [secondOperand | restOperands] = operandStack
        [firstOperand | restOperands] = restOperands
        evaluatedValue = Float.to_string(evaluteSimpleExpression(firstOperand, secondOperand, curr))
        evaluatePostfixExprAcc(rest, [evaluatedValue | restOperands])
      end    
    end
  end

  # Evaluates a simple expression with 2 operands and 1 operator
  def evaluteSimpleExpression(first, second, op) do
    # Convert the first and second operands to floats
    first = stringToFloat(first)
    second = stringToFloat(second)

    case op do 
      "+" -> first + second
      "-" -> first - second
      "*" -> first * second
      "/" -> first / second
      true -> raise "Invalid Operator"   
    end
  end

  # Converts a string to a float
  def stringToFloat(strNum) do
    strNum |> String.trim |> Float.parse |> Tuple.to_list |> hd
  end

  # Converts and infix expression to a postfix expression
  def infixToPostfix(listOfTerms) do
    listOfTerms |> infixToPostfixAcc("", []) |> String.trim
  end

  # Accumalator to convert an infix expression to a postfix expression
  def infixToPostfixAcc(listOfTerms, result, operatorStack) do

    if Enum.empty?(listOfTerms) do
      # If end of list has been reached, return the result + remaining stack
      Enum.reduce(operatorStack, result, fn(op, acc) -> "#{acc} #{op}" end)

    else
      # If more of the expression remains
      [curr | rest] = listOfTerms

      cond do
        # If curr isn't an operator, add curr to result
        !isOperator(curr) ->
          infixToPostfixAcc(rest, "#{result} #{curr}", operatorStack)

        # If it is an operator and is of higher precendence than top of stack
        # then push onto stack
        Enum.empty?(operatorStack) || isHigherPrecendence(curr, operatorStack) ->
          infixToPostfixAcc(rest, result, [curr | operatorStack])

        # Else, if operator on top of stak is of higher precendence
        # then pop from the stack till curr is of highest precendence
        true ->
          {result, operatorStack} = adjustStack(result, operatorStack, curr)
          infixToPostfixAcc(rest, result, operatorStack)
      end
    end
  end

  # Checks if the given expression literal is an operator
  def isOperator(expressionLiteral) do
    expressionLiteral == "+" || expressionLiteral == "-" || expressionLiteral == "*" || expressionLiteral == "/"
  end

  # Pops from the operator stack till curr is of highest precendence
  def adjustStack(result, operatorStack, curr) do
    if Enum.empty?(operatorStack) || isHigherPrecendence(curr, operatorStack) do 
      {result, [curr | operatorStack]}
    else
      [first | rest] = operatorStack
      adjustStack("#{result} #{first}", rest, curr)
    end
  end

  # Checks if the given curr operator is of higher precendence
  # than the top of the stack
  def isHigherPrecendence(curr, [top | _rest]) do
    precedenceMap = %{"/" => 4, "*" => 3, "+" => 2, "-" => 1}
    currVal = precedenceMap[curr]
    topVal = precedenceMap[top]
    currVal > topVal
  end

end
