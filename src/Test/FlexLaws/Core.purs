module Test.QuickCheck.FlexLaws.Core
  ( ClassTestSuite(..)
  , LawTest(..)
  , LawDescription(..)
  ) where

import Prelude
import Test.QuickCheck
  ( class Arbitrary
  , class Coarbitrary
  , class Testable
  )

-- | A suite of tests corresponding to the laws of a class.
newtype ClassTestSuite a = ClassTestSuite
  { className :: String
  , laws :: Array (LawTest a)
  }

-- | A single law test.
newtype LawTest a = LawTest
  { lawName :: String
  , lawDescription :: LawDescription
  , test :: a -> (forall b. (forall p. Testable p => p -> b) -> b)
  }

-- | The description of a law, either
-- | as plain text to reproduce faithfully,
-- | or as two sides of an equation to format
-- | according to the end user's preference.
data LawDescription = Plain String | Equation String String
