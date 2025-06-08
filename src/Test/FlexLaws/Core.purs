module Test.FlexLaws.Core
  ( ClassTestSuite(..)
  , LawTest(..)
  , LawDescription(..)
  , NeedsArbitrary
  , NeedsCoarbitrary
  ) where

import Prelude
import Test.QuickCheck
  ( class Arbitrary
  , class Coarbitrary
  , class Testable
  , Gen
  )
import Type.Row (type (+))

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

type NeedsArbitrary a r = ( arbitrary :: Gen a | r )
type NeedsCoarbitrary a r = ( coarbitrary :: forall b. a -> Gen b -> Gen b | r )

-- | The description of a law, either
-- | as plain text to reproduce faithfully,
-- | or as two sides of an equation to format
-- | according to the end user's preference.
data LawDescription = Plain String | Equation String String
