module Test.Prim.String where

import Prelude

import Effect (Effect)
import Test.QuickCheck.FlexLaws (checkLaws)
import Test.QuickCheck.FlexLaws.Data as Data
import Type.Proxy (Proxy(..))

checkString ∷ Effect Unit
checkString = checkLaws "String" do
  Data.checkEq prxString
  Data.checkOrd prxString
  Data.checkSemigroup prxString
  Data.checkMonoid prxString
  where
  prxString = Proxy ∷ Proxy String
