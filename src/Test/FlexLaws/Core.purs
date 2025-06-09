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
  , Result
  , Gen
  )

data RichResult -- jakl;ajg;lj;lkj i actually so want to spin this off into another fucking libtrarrrryyyyyy aahaaaaaaaaaaaaaaa with like its own fucked up version of Testable so it comes all the way back around to lambda arguments except maybe it's just a record and the variable namaes can even like.... i don;'t even know where i'm going with this but there needs to be like a GenShow that optionally includes seeds and for functions it's literally just the seed

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
  , test :: Record r -> Gen Result
  }

type NeedsArbitrary a r = ( arbitrary :: Gen a | r )
type NeedsCoarbitrary a r = ( coarbitrary :: forall b. a -> Gen b -> Gen b | r )
type NeedsArbitrary1 f r = ( arbitrary :: forall a. Arbitrary a => Gen (f a) | r )
type NeedsCoarbitrary1 f r = ( coarbitrary :: forall a b. Coarbitrary a => f a -> Gen b -> Gen b | r )

-- | The description of a law, either
-- | as plain text to reproduce faithfully,
-- | or as two sides of an equation to format
-- | according to the end user's preference.
data LawDescription = Plain String | Equation String String
