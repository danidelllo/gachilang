# gachilang

Installation:
Main tutorial: https://github.com/BNFC/bnfc#installation

Windows:
- Download from https://github.com/BNFC/bnfc/releases
- Set path variable to the binary
- Install Haskell tools https://www.haskell.org/ghcup/
- cabal install alex
- cabal install happy
- add above to PATH (C:/cabal/bin)
- Install Chocolatey https://chocolatey.org/install#individual
- Run choco install make

Linux:
TODO

------------------------- Running on Windows:

Produce output files and make:
bnfc -m Calc.cf --outputdir=./mess --haskell && (cd mess && make && cd ..) && copy .\Main.hs mess\ /Y && copy Interpreter.hs mess\ /Y

Create interpreter:
(cd mess && ghc --make Main.hs && cd ..)

Clear mess directory:
(cd mess && del /S /Q .\* && cd ..)

Full create pipeline:
(cd mess && del /S /Q .\* && cd ..) && bnfc -m Calc.cf --outputdir=./mess --haskell && (cd mess && make && cd ..) && copy .\Main.hs mess\ /Y && copy Interpreter.hs mess\ /Y && (cd mess && ghc --make Main.hs && cd ..)

Run your program:
mess\Main < gachicode.aah

------------------------- Running on Linux:

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
