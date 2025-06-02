module Test.QuickCheck.FlexLaws.Core
  ( FlexSuite
  , Checker
  , Config
  , ClassSuite
  , LawTest
  , runClassSuite
  , checkLaws
  , vanilla
  , A
  , B
  , C
  , D
  , E
  ) where

import Prelude
import Data.Enum (class Enum, class BoundedEnum)
import Data.Traversable (for_)
import Effect (Effect)
import Effect.Console (log)
import Test.QuickCheck
  ( class Arbitrary
  , class Coarbitrary
  , class Testable
  , quickCheck'
  )

-- don't even need ReaderT! just the function monad
-- ...except no that would just discard the monadic stuff it's supposed to be doing ;_;

type FlexSuite :: forall k. k -> Type
type FlexSuite a = forall m. Monad m => SuiteContext m -> m Unit

data SuiteContext m = SuiteContext String (Config m)

type Config m =
  { typeSuite :: String -> m Unit -> m Unit
  , classSuite :: { typeName :: String, className :: String } -> m Unit -> m Unit
  , lawTest ::
    { typeName :: String
    , className :: String
    , lawName :: String
    , lawDescription :: String
    }
    -> Checker (m Unit)
  }

type Checker a = forall p. Testable p => p -> a

data ClassSuite = ClassSuite String (Array LawTest)

data LawTest = LawTest String String (forall a. Checker a -> a)

-- ...I hope inference doesn't kill me if I try just using (#) in front of everything

runClassSuite :: forall a. ClassSuite -> FlexSuite a
runClassSuite (ClassSuite className laws) (SuiteContext typeName config) = do
  config.classSuite { typeName, className } do
    for_ laws \(LawTest lawName lawDescription invertedExistentialTestable) ->
      config.lawTest { typeName, className, lawName, lawDescription } #
        invertedExistentialTestable

-- | A `Config` emulating the behavior of `quickcheck-laws`.
vanilla :: Config Effect
vanilla =
  { typeSuite: \typeName laws -> do
    log $ "\n\nChecking laws of " <> typeName <> " instances...\n"
    laws
  , classSuite: const identity
  , lawTest: \info predicate -> do
    log $ "Checking '" <> info.lawName <> "' law for " <> info.className
    quickCheck' 1000 law
  }

-- | Factory for `Config`s that produce a flat grouping of tests by class.
shallowClasses
  :: forall m n
  . { suite :: String -> m Unit -> m Unit
    , test :: String -> n -> m Unit
    , check :: Checker n
    }
  -> Config m
shallowClasses { suite, test, check } =
  { typeSuite: const identity
  , classSuite: (\{ typeName, className }
      -> suite (className <> " " <> typeName <> " laws"))
  , lawTest: (\( lawName, lawDescription )
      -> test (lawName <> " law: " <> lawDescription)
         <<< check)
  }

checkLaws :: String -> Effect Unit -> Effect Unit
checkLaws typeName laws = do
  log $ "\n\nChecking laws of " <> typeName <> " instances...\n"
  laws

-- TODO: unironically bring back my HeavenlyStems enum for this because
-- Ordering is, uh, a liiiitttttttttle small for comfort
-- -- like yeah it does mean you're all but guaranteed to hit edge cases but
-- actually yeah no this should just straight up be polymorphic like
-- if you're making this whole framework why NOT cover all your bases yknow
-- also maybe days of the week instead of heavenly stems lol.

newtype A = A Ordering

derive newtype instance arbitraryA :: Arbitrary A
derive newtype instance boundedA :: Bounded A
derive newtype instance enumA :: Enum A
derive newtype instance boundedEnumA :: BoundedEnum A
derive newtype instance coarbitraryA :: Coarbitrary A
derive newtype instance eqA :: Eq A
derive newtype instance ordA :: Ord A
derive newtype instance semigroupA :: Semigroup A
instance monoidA :: Monoid A where mempty = A EQ

newtype B = B Ordering

derive newtype instance arbitraryB :: Arbitrary B
derive newtype instance boundedB :: Bounded B
derive newtype instance enumB :: Enum B
derive newtype instance boundedEnumB :: BoundedEnum B
derive newtype instance coarbitraryB :: Coarbitrary B
derive newtype instance eqB :: Eq B
derive newtype instance ordB :: Ord B
derive newtype instance semigroupB :: Semigroup B
instance monoidB :: Monoid B where mempty = B EQ

newtype C = C Ordering

derive newtype instance arbitraryC :: Arbitrary C
derive newtype instance boundedC :: Bounded C
derive newtype instance enumC :: Enum C
derive newtype instance boundedEnumC :: BoundedEnum C
derive newtype instance coarbitraryC :: Coarbitrary C
derive newtype instance eqC :: Eq C
derive newtype instance ordC :: Ord C
derive newtype instance semigroupC :: Semigroup C
instance monoidC :: Monoid C where mempty = C EQ

newtype D = D Ordering

derive newtype instance arbitraryD :: Arbitrary D
derive newtype instance boundedD :: Bounded D
derive newtype instance enumD :: Enum D
derive newtype instance boundedEnumD :: BoundedEnum D
derive newtype instance coarbitraryD :: Coarbitrary D
derive newtype instance eqD :: Eq D
derive newtype instance ordD :: Ord D
derive newtype instance semigroupD :: Semigroup D
instance monoidD :: Monoid D where mempty = D EQ

newtype E = E Ordering

derive newtype instance arbitraryE :: Arbitrary E
derive newtype instance boundedE :: Bounded E
derive newtype instance enumE :: Enum E
derive newtype instance boundedEnumE :: BoundedEnum E
derive newtype instance coarbitraryE :: Coarbitrary E
derive newtype instance eqE :: Eq E
derive newtype instance ordE :: Ord E
derive newtype instance semigroupE :: Semigroup E
instance monoidE :: Monoid E where mempty = E EQ
