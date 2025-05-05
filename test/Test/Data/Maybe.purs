module Test.Data.Maybe where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import Test.QuickCheck.FlexLaws (A, checkLaws)
import Test.QuickCheck.FlexLaws.Control as Control
import Test.QuickCheck.FlexLaws.Data as Data
import Type.Proxy (Proxy(..))

checkMaybe ∷ Effect Unit
checkMaybe = checkLaws "Maybe" do
  Data.checkEq prxMaybe
  Data.checkOrd prxMaybe
  Data.checkBounded prxMaybe
  Data.checkEnum prxMaybe
  Data.checkSemigroup prxMaybe
  Data.checkMonoid prxMaybe
  Data.checkFunctor prx2Maybe
  Data.checkFunctorWithIndex prx2Maybe
  Data.checkFoldableFunctor prx2Maybe
  Control.checkApply prx2Maybe
  Control.checkApplicative prx2Maybe
  Control.checkAlt prx2Maybe
  Control.checkPlus prx2Maybe
  Control.checkAlternative prx2Maybe
  Control.checkBind prx2Maybe
  Control.checkMonad prx2Maybe
  Control.checkExtend prx2Maybe
  where
  prxMaybe = Proxy ∷ Proxy (Maybe A)
  prx2Maybe = Proxy ∷ Proxy Maybe
