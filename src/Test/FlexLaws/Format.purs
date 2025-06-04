module Test.FlexLaws.Format
  ( equate
  ) where

import Prelude
import Test.FlexLaws.Core
  ( LawDescription(..)
  )

-- | Format equation `LawDescription`s with the given separator
-- | while returning plain ones verbatim.
equate :: String -> LawDescription -> String
equate equals (Equation a b) = a <> " " <> equals <> " " <> b
equate _ (Plain desc) = desc
