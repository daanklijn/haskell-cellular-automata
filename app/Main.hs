{-# LANGUAGE BlockArguments #-}

module Main where

import Lib
import Control.Concurrent
import Numeric (showIntAtBase)
import Data.Char (intToDigit)

clearScreen = putStr "\ESC[2J"

extendTo8 s = if length s == 8 then s else extendTo8("0"++s)

getRule n = reverse (extendTo8(numberToBinary n))

applyRule :: Int -> String -> String
applyRule number input = [getRule(number) !! binaryToNumber(input)]

numberToBinary :: Int -> String
numberToBinary n = showIntAtBase 2 intToDigit n ""

binaryToNumber :: String -> Int
binaryToNumber [] = 0
binaryToNumber (x : xs) = (read [x] :: Int) + 2 * binaryToNumber xs

applyRules :: Int -> String -> String
applyRules rule [] = []
applyRules rule (a : b : c : d) = (applyRule rule ([a]++[b]++[c])) ++ applyRules rule ([b]++[c]++d)
applyRules rule (a : b : d) = [] 

convertSymbol '0' = ' '
convertSymbol '1' = '■'

convertRow [] = []
convertRow (x : xs) = [convertSymbol(x)] ++ convertRow(xs)

printRow row = putStrLn(convertRow(row))

addZeros :: String -> String
addZeros list = ['0'] ++ list ++ ['0']

cellularAutomation :: Int -> String -> IO()
cellularAutomation rule row = do 
  let nextRow = applyRules rule (addZeros(row))
  printRow nextRow
  threadDelay 200000
  cellularAutomation rule nextRow

main :: IO ()
main = do
  clearScreen
  putStrLn "Welcome to cellular automata!\nWhich rule would you like to use?"
  rule <- getLine
  cellularAutomation (read rule) "000000000000000000000000000000000100000000000000000000000000000"