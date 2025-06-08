module Test.FlexLaws.Data.Eq
  ( eqSuite
  ) where

import Prelude

import Test.FlexLaws.Core
  ( ClassTestSuite(..)
  , LawTest(..)
  , LawDescription(..)
  , Arb
  )

eqSuite :: forall a r. Eq a => ClassTestSuite (Arb a r) a
eqSuite = ClassTestSuite
  { className: "Eq"
  , laws:
    [ LawTest
      { lawName: "Reflexivity"
      , lawDescription: Equation "x" "x"
      , test: \qc { gen } ->
      }
    ]
  }
