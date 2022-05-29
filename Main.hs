module Main where 

import LexCalc 
import ParCalc 
import AbsCalc 
import Interpreter 
import ErrM


main = do 
  a <- getContents
  calc a
--   interact calc
  -- putStrLn ""

calc s =
  let Ok e = pProgram (myLexer s)
  in runprogram e