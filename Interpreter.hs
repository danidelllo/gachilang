module Interpreter where 
    
import AbsCalc
import Data.Map (Map)
import qualified Data.Map as Map

-- Defined possible data types for output
data RType = RTInteger Integer | RTDouble Double

instance Show RType where
    show (RTInteger x) = show x
    show (RTDouble x) = show x

-- Overrides arithmetic
gachiAdd :: RType -> RType -> RType
gachiAdd (RTInteger x) (RTDouble y) = RTDouble ((fromIntegral x) + y)
gachiAdd (RTDouble x) (RTInteger y) = RTDouble (x + (fromIntegral y))
gachiAdd (RTInteger x) (RTInteger y) = RTInteger (x + y)
gachiAdd (RTDouble x) (RTDouble y) = RTDouble (x + y)

gachiSub :: RType -> RType -> RType
gachiSub (RTInteger x) (RTDouble y) = RTDouble ((fromIntegral x) - y)
gachiSub (RTDouble x) (RTInteger y) = RTDouble (x - (fromIntegral y))
gachiSub (RTInteger x) (RTInteger y) = RTInteger (x - y)
gachiSub (RTDouble x) (RTDouble y) = RTDouble (x - y)

gachimult :: RType -> RType -> RType
gachimult (RTInteger x) (RTDouble y) = RTDouble ((fromIntegral x) * y)
gachimult (RTDouble x) (RTInteger y) = RTDouble (x * (fromIntegral y))
gachimult (RTInteger x) (RTInteger y) = RTInteger (x * y)
gachimult (RTDouble x) (RTDouble y) = RTDouble (x * y)

gachidiv :: RType -> RType -> RType
gachidiv (RTInteger x) (RTDouble y) = RTDouble ((fromIntegral x) / y)
gachidiv (RTDouble x) (RTInteger y) = RTDouble (x / (fromIntegral y))
gachidiv (RTInteger x) (RTInteger y) = RTDouble ((fromIntegral x) / (fromIntegral y))
gachidiv (RTDouble x) (RTDouble y) = RTDouble (x / y)


-- Variable manipulation
-- TODO: add double
addVar :: String -> Type -> RType -> Map String RType -> Map String RType
addVar name TInt (RTInteger value) vars = Map.insert name (RTInteger value) vars
addVar name TDbl (RTDouble value) vars = Map.insert name (RTDouble value) vars

fetchVar :: String -> Map String RType -> RType
fetchVar name map = if Map.member name map
          then (Map.findWithDefault (RTInteger 1) name map)
          else error "No such variable"

sameType :: RType -> RType -> Bool
sameType (RTInteger _) (RTInteger _) = True
sameType (RTDouble _) (RTDouble _) = True
sameType _ _ = False

updateVar :: String -> RType -> Map String RType -> Map String RType
updateVar name new_val map = do
    let current_var = fetchVar name map
    if sameType current_var new_val
        then Map.insert name new_val map
        else
            error "No such variable or wrong type"

-- Invokes each statement of the program in turn
runprogram :: Program -> IO String
runprogram (PDef x) = do
    runstatement x Map.empty
    return "1"

-- Processes each statement by invoking expression processing
-- TODO: fix returns of updated variables
runstatement :: [Stm] -> Map String RType -> IO (Map String RType)
runstatement (x:xs) vars = case x of
  SExec y -> do
    (result, new_vars) <- runexpression y vars
    putStr ""
    new_new_vars <- runstatement xs new_vars
    return new_new_vars
  SPrint y -> do
    (result, new_vars) <- runexpression y vars
    putStrLn $ show result
    new_new_vars <- runstatement xs new_vars
    return new_new_vars
-- TODO: Check that variable does not exist with same name
  SDecl (Dec t (Ident name)) y -> do
    (result, new_vars) <- runexpression y vars
    new_new_vars <- runstatement xs (addVar name t result new_vars)
    return new_new_vars
runstatement [] vars = do
    putStr ""
    return vars

-- Processes each experssion
runexpression :: Exp -> Map String RType -> IO (RType, Map String RType)
runexpression x vars = case x of 
  EAdd exp0 exp -> do
      (e0, e0vars) <- runexpression exp0 vars
      (e1, e1vars) <- runexpression exp e0vars
      return $ ((gachiAdd e0 e1), e1vars)
  ESub exp0 exp -> do
      (e0, e0vars) <- runexpression exp0 vars
      (e1, e1vars) <- runexpression exp e0vars
      return $ ((gachiSub e0 e1), e1vars)
  EMul exp0 exp -> do
      (e0, e0vars) <- runexpression exp0 vars
      (e1, e1vars) <- runexpression exp e0vars
      return $ ((gachimult e0 e1), e1vars)
  EDiv exp0 exp -> do
      (e0, e0vars) <- runexpression exp0 vars
      (e1, e1vars) <- runexpression exp e0vars
      return $ ((gachidiv e0 e1), e1vars)
  EInt n -> do
      return $ ((RTInteger n), vars)
  EDbl n -> do
      return $ ((RTDouble n), vars)
  EVar (Ident ident) -> do
      return $ (fetchVar ident vars, vars)
  EAss (Ident ident) exp -> do
      (res, new_vars) <- runexpression exp vars
      let new_new_vars = updateVar ident res new_vars
      return $ (res, new_new_vars)