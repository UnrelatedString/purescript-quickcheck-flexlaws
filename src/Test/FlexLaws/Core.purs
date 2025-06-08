module Test.FlexLaws.Core
  ( ClassTestSuite(..)
  , LawTest(..)
  , LawDescription(..)
  , Arb
  , Coarb
  ) where

import Prelude
import Test.QuickCheck
  ( class Arbitrary
  , class Coarbitrary
  , class Testable
  , Gen
  )

-- | A suite of tests corresponding to the laws of a class,
-- | for a given type.
newtype ClassTestSuite :: forall k. Row Type -> k -> Type
newtype ClassTestSuite r a = ClassTestSuite
  { className :: String
  , laws :: Array (LawTest r a)
  }

-- | A single law test for a given type,
-- | expecting arbitrarily many named context arguments
-- | shared by all law tests in a class suite.
newtype LawTest :: forall k. Row Type -> k -> Type
newtype LawTest r a = LawTest
  { lawName :: String
  , lawDescription :: LawDescription
  , test :: forall b. (forall p. Testable p => p -> b) -> Record r -> b
  }

type Arb a r = ( gen :: Gen a | r )
type Coarb a r = ( cogen :: forall b. Arbitrary b => Gen (a -> b) | Arb a r ) -- and... what if I need an a->a... do I seriously want to do a THIRD one for that... what do I even call it aaaa

-- | The description of a law, either
-- | as plain text to reproduce faithfully,
-- | or as two sides of an equation to format
-- | according to the end user's preference.
data LawDescription = Plain String | Equation String String
