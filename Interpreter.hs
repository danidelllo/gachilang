module Interpreter where 
    
import AbsCalc


runprogram :: Program -> IO String
runprogram (PDef x) = do
    runstatement x
    return "1"

runstatement :: [Stm] -> IO ()
runstatement (x:xs) = case x of
  SExp y -> do
    runexpression y
    putStr ""
    runstatement xs
  PExp y -> do
    result <- runexpression y
    putStrLn $ show result
    runstatement xs
runstatement [] = putStr ""

runexpression :: Exp -> IO Integer
runexpression x = case x of 
  EAdd exp0 exp -> do
      e0 <- runexpression exp0
      e1 <- runexpression exp
      return $ e0 + e1
  ESub exp0 exp -> do
      e0 <- runexpression exp0
      e1 <- runexpression exp
      return $ e0 - e1
  EMul exp0 exp -> do
      e0 <- runexpression exp0
      e1 <- runexpression exp
      return $ e0 * e1
  EDiv exp0 exp -> do
      e0 <- runexpression exp0
      e1 <- runexpression exp
      return $ e0 `div` e1
  EInt n -> do
      return $ n
