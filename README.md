
<!-- README.md is generated from README.Rmd. Please edit that file -->
walmartAPI
==========

[![Travis build status](https://travis-ci.org/EmilHvitfeldt/walmartAPI.svg?branch=master)](https://travis-ci.org/EmilHvitfeldt/walmartAPI)

The goal of walmartAPI is to give access to the API created by [walmartlabs](https://developer.walmartlabs.com/) to search products, locate stores etc etc.

To use this package you will need an API key which you can acquire by signing up on this website <https://developer.walmartlabs.com/member>.

Installation
------------

You can install walmartAPI from github with:

``` r
# install.packages("devtools")
devtools::install_github("EmilHvitfeldt/walmartAPI")
```

Examples
--------

This package provides a handful for functionalities. We are able to look up a specific product based on an ID.

``` r
library(tidyverse)
library(walmartAPI)

key <- "************************"

walmartAPI::lookup(id = 19336123, key = key)
```

    #> # A tibble: 1 x 15
    #>     itemId                                               name   msrp
    #>      <int>                                              <chr>  <dbl>
    #> 1 19336123 Intex Krystal Clear Saltwater System 15,000 Gallon 299.99
    #> # ... with 12 more variables: salePrice <dbl>, upc <chr>,
    #> #   categoryPath <chr>, longDescription <chr>, thumbnailImage <chr>,
    #> #   productTrackingUrl <chr>, standardShipRate <dbl>, marketplace <lgl>,
    #> #   productUrl <chr>, availableOnline <lgl>, offerType <chr>,
    #> #   shippingPassEligible <lgl>

search in products using plain text

``` r
walmartAPI::search("ipod", key = key)
```

    #> # A tibble: 10 x 15
    #>       itemId
    #>        <int>
    #>  1  42608125
    #>  2  42608121
    #>  3  22288784
    #>  4 541357139
    #>  5  49802795
    #>  6  54203936
    #>  7  50689211
    #>  8  12510108
    #>  9 173544522
    #> 10 172440769
    #> # ... with 14 more variables: name <chr>, msrp <dbl>, salePrice <dbl>,
    #> #   upc <chr>, categoryPath <chr>, longDescription <chr>,
    #> #   thumbnailImage <chr>, productTrackingUrl <chr>,
    #> #   standardShipRate <dbl>, marketplace <lgl>, productUrl <chr>,
    #> #   availableOnline <lgl>, offerType <chr>, shippingPassEligible <lgl>

and locate stores in your area

``` r
store_locator(city = "Houston", key = key)
```

    #> # A tibble: 86 x 12
    #>       no                                name country       lon      lat
    #>    <int>                               <chr>   <chr>     <dbl>    <dbl>
    #>  1  5959                     Houston Walmart      US -95.40132 29.77282
    #>  2  5612         Houston Walmart Supercenter      US -95.31293 29.71622
    #>  3  4526         Houston Walmart Supercenter      US -95.37707 29.82985
    #>  4  3640         Houston Walmart Supercenter      US -95.46515 29.78876
    #>  5  3584         Houston Walmart Supercenter      US -95.46501 29.72305
    #>  6  2718                     Houston Walmart      US -95.45750 29.67688
    #>  7  2066         Houston Walmart Supercenter      US -95.51169 29.73549
    #>  8  5094 Houston Walmart Neighborhood Market      US -95.49547 29.67444
    #>  9  2257         Houston Walmart Supercenter      US -95.50908 29.85391
    #> 10  2724        Pasadena Walmart Supercenter      US -95.21038 29.69344
    #> # ... with 76 more rows, and 7 more variables: streetAddress <chr>,
    #> #   city <chr>, stateProvCode <chr>, zip <chr>, phoneNumber <chr>,
    #> #   sundayOpen <lgl>, timezone <chr>
