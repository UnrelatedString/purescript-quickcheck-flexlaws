module Test.Data.Ordering where

import Prelude

import Effect (Effect)
import Test.QuickCheck.FlexLaws (checkLaws)
import Test.QuickCheck.FlexLaws.Data as Data
import Type.Proxy (Proxy(..))

checkOrdering ∷ Effect Unit
checkOrdering = checkLaws "Ordering" do
  Data.checkEq prxOrdering
  Data.checkOrd prxOrdering
  Data.checkBounded prxOrdering
  Data.checkEnum prxOrdering  
  Data.checkBoundedEnum prxOrdering
  Data.checkSemigroup prxOrdering
  where
  prxOrdering = Proxy ∷ Proxy Ordering
