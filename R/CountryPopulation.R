#' Graph a country's population over time
#'
#' Uses the WorldPopulation data set to find country and graph its population
#' from 1950 to 2020. Will produce an error if country name not found.
#'
#' @param country Country name
#' @return a graph of the input country's population from 1950 to 2020
#' @examples
#' CountryPopulation('Iraq')
#' CountryPopulation('United States of America')
#' @export
CountryPopulation <- function(country){
  if(!any(str_detect(WorldPopulation$CountryName, country))){
    stop('Country not found.')
  }

  CountryPop <- WorldPopulation %>%
    filter(str_detect(WorldPopulation$CountryName, country)) %>%
    pivot_longer(`1950`:`2020`, names_to = 'Year', values_to = 'Population')

  CountryGraph <- ggplot(CountryPop, aes(x = Year, y = Population)) +
    geom_point() +
    labs(title = paste(country, 'Population from 1950 to 2020')) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, size = 6))

  return(CountryGraph)
}
