# gachilang

Produce output files and make:
bnfc -m Calc.cf --outputdir=./mess --haskell && (cd mess && make) && cp Main.hs mess/ && cp Interpreter.hs mess/

Create interpreter:
(cd mess && ghc --make Main.hs)

Clear mess directory:
(cd mess && rm -rf ./*)

Full create pipeline:
(cd mess && rm -rf ./*) && bnfc -m Calc.cf --outputdir=./mess --haskell && (cd mess && make) && cp Main.hs mess/ && cp Interpreter.hs mess/ && (cd mess && ghc --make Main.hs)

Run your program:
mess/Main < gachicode.aah 
