# check that if country not found in data frame, error is produced
test_that('Incorrect country produces error.', {
  expect_error(CountryPopulation('South Canada'))
  expect_error(CountryPopulation('UnitedStatesofAmerica'))
  expect_error(CountryPopulation('Arizona'))
})
