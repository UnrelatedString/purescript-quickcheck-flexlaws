module Test.QuickCheck.FlexLaws.Data.Functor where

import Prelude

import Data.Function as F
import Effect (Effect)
import Effect.Console (log)
import Test.QuickCheck (quickCheck')
import Test.QuickCheck.Arbitrary (class Arbitrary, arbitrary)
import Test.QuickCheck.Gen (Gen)
import Test.QuickCheck.FlexLaws (A, B)
import Type.Proxy (Proxy)

-- | - Identity: `(<$>) id = id`
-- | - Composition: `(<$>) (f <<< g) = (f <$>) <<< (g <$>)`
checkFunctor
  :: forall f
  . Functor f
  => Arbitrary (f A)
  => Eq (f A)
  => Proxy f
  -> Effect Unit
checkFunctor _ = checkFunctorGen (arbitrary :: Gen (f A))

checkFunctorGen
  :: forall f
  . Functor f
  => Eq (f A)
  => Gen (f A)
  -> Effect Unit
checkFunctorGen gen = do
  log "Checking 'Identity' law for Functor"
  quickCheck' 1000 $ identity <$> gen

  log "Checking 'Composition' law for Functor"
  quickCheck' 1000 $ composition <$> gen

  where

  identity :: f A -> Boolean
  identity f = (F.identity <$> f) == F.identity f

  composition :: f A -> (B -> A) -> (A -> B) -> Boolean
  composition x f g = ((<$>) (f <<< g) x) == (((f <$> _) <<< (g <$> _)) x)
