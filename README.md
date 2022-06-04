# gachilang

Coding in gachilang is ~300$~ FREE for boys next door!

Sample gachilang program:
```
300$

cum 1 and 2 fucking 3 o`

billy is 1337 o`
vanh is 2.28 o`

cum billy and vanh o`
```

More info to be added to [wiki](https://github.com/danidelllo/gachilang/wiki) soon

## Download and code! :
Get binaries for interpreter from [release page](https://github.com/danidelllo/gachilang/releases)

- Put binaries in current directory or modify PATH variable
- Modify gachicode.aah or create new .aah file
- Run your program:
  - Windows: `./gachii< gachicode.aah`
  - Linux: `./gachii< gachicode.aah`

## Development installation:
Main tutorial (requires tricks on Windows, see below): https://github.com/BNFC/bnfc#installation

### Prerequisites
Windows:
- Download from https://github.com/BNFC/bnfc/releases
- Set PATH variable to the binary directory
- Install Haskell tools https://www.haskell.org/ghcup/
- Install alex `cabal install alex`
- Install happy `cabal install happy`
- Add alex and happy to PATH (`C:/cabal/bin` on Windows)
- Install Chocolatey https://chocolatey.org/install#individual
- Install make `choco install make`

Linux:
TODO

### Running on Windows:

Produce output files and make:
`bnfc -m Calc.cf --outputdir=./mess --haskell && (cd mess && make && cd ..) && copy .\Main.hs mess\ /Y && copy Interpreter.hs mess\ /Y`

Create interpreter:
`(cd mess && ghc --make Main.hs && cd ..)`

Clear mess directory:
`(cd mess && del /S /Q .\* && cd ..)`

Full create pipeline:
`(cd mess && del /S /Q .\* && cd ..) && bnfc -m Calc.cf --outputdir=./mess --haskell && (cd mess && make && cd ..) && copy .\Main.hs mess\ /Y && copy Interpreter.hs mess\ /Y && (cd mess && ghc --make Main.hs && cd ..)`

Run your program:
`mess\Main < gachicode.aah`

### Running on Linux:

Produce output files and make:
`bnfc -m Calc.cf --outputdir=./mess --haskell && (cd mess && make) && cp Main.hs mess/ && cp Interpreter.hs mess/`

Create interpreter:
`(cd mess && ghc --make Main.hs)`

Clear mess directory:
`(cd mess && rm -rf ./*)`

Full create pipeline:
`(cd mess && rm -rf ./*) && bnfc -m Calc.cf --outputdir=./mess --haskell && (cd mess && make) && cp Main.hs mess/ && cp Interpreter.hs mess/ && (cd mess && ghc --make Main.hs)`

Run your program:
`mess/Main < gachicode.aah`
