
<!-- README.md is generated from README.Rmd. Please edit that file -->

# walmartAPI

[![Travis build
status](https://travis-ci.org/EmilHvitfeldt/walmartAPI.svg?branch=master)](https://travis-ci.org/EmilHvitfeldt/walmartAPI)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/walmartAPI)](https://cran.r-project.org/package=walmartAPI)
![downloads](http://cranlogs.r-pkg.org/badges/grand-total/walmartAPI)

The goal of **walmartAPI** is to give access to the API created by
[walmartlabs](https://developer.walmartlabs.com/) to search products,
locate stores etc etc.

To use this package you will need an API key which you can acquire by
signing up on this website <https://developer.walmartlabs.com/member>.

## Installation

**walmartAPI** is available on CRAN and can be installed normally with
`install.packages(tidygraph).` or you can install **walmartAPI** from
github with:

``` r
install.packages("walmartAPI")

# install.packages("devtools")
devtools::install_github("EmilHvitfeldt/walmartAPI")
```

## Examples

This package provides a handful for functionalities. We are able to look
up a specific product based on an ID.

``` r
library(tidyverse)
library(walmartAPI)

key <- "************************"

walmartAPI::lookup(id = 19336123, key = key)
```

    #> # A tibble: 1 x 15
    #>   itemId name   msrp salePrice upc   categoryPath longDescription
    #>    <int> <chr> <dbl>     <dbl> <chr> <chr>        <chr>          
    #> 1 1.93e7 Inte…  300.      200. 0782… Toys/Outdoo… &lt;br&gt;&lt;…
    #> # ... with 8 more variables: thumbnailImage <chr>,
    #> #   productTrackingUrl <chr>, standardShipRate <dbl>, marketplace <lgl>,
    #> #   productUrl <chr>, availableOnline <lgl>, offerType <chr>,
    #> #   shippingPassEligible <lgl>

search in products using plain text

``` r
walmartAPI::searching("ipod", key = key)
```

    #> # A tibble: 10 x 15
    #>    itemId name   msrp salePrice upc   categoryPath longDescription
    #>     <int> <chr> <dbl>     <dbl> <chr> <chr>        <chr>          
    #>  1 4.26e7 Appl… 247      189    8884… Electronics… &lt;b&gt;&lt;b…
    #>  2 5.41e8 Appl…  NA      299    8884… Electronics… 2015 Apple Inc…
    #>  3 4.26e7 Appl… 300.     190.   8884… Electronics… IPOD TOUCH 16G…
    #>  4 5.42e7 Appl… 185.     173.   1903… Electronics… &lt;ul class=&…
    #>  5 4.61e7 Appl… 297      289    8884… Electronics… IPOD TOUCH 64G…
    #>  6 5.27e7 iPod…  30.0     12.0  7429… Electronics… &lt;ul&gt;&lt;…
    #>  7 4.65e7 iPod…  30.0      6.99 7136… Electronics… iPod Touch 6 C…
    #>  8 8.68e8 Appl…  NA      370.   7087… Electronics… &lt;ul&gt;&lt;…
    #>  9 1.26e8 Appl…  NA      190.   7056… Electronics… &lt;ul&gt;&lt;…
    #> 10 1.40e8 Unde…  NA      220    6464… Electronics… &lt;ul&gt;&lt;…
    #> # ... with 8 more variables: thumbnailImage <chr>,
    #> #   productTrackingUrl <chr>, standardShipRate <dbl>, marketplace <lgl>,
    #> #   productUrl <chr>, availableOnline <lgl>, offerType <chr>,
    #> #   shippingPassEligible <lgl>

and locate stores in your area

``` r
store_locator(city = "Houston", key = key)
```

    #> # A tibble: 86 x 12
    #>       no name  country   lon   lat streetAddress city  stateProvCode zip  
    #>    <int> <chr> <chr>   <dbl> <dbl> <chr>         <chr> <chr>         <chr>
    #>  1  5959 Hous… US      -95.4  29.8 111 Yale St   Hous… TX            77007
    #>  2  5612 Hous… US      -95.3  29.7 2391 S Waysi… Hous… TX            77023
    #>  3  4526 Hous… US      -95.4  29.8 4412 North F… Hous… TX            77022
    #>  4  3640 Hous… US      -95.5  29.8 1118 Silber … Hous… TX            77055
    #>  5  3584 Hous… US      -95.5  29.7 5405 South R… Hous… TX            77081
    #>  6  2718 Hous… US      -95.5  29.7 9555 S Post … Hous… TX            77096
    #>  7  2066 Hous… US      -95.5  29.7 2727 Dunvale… Hous… TX            77063
    #>  8  5094 Hous… US      -95.5  29.7 9700 Hillcro… Hous… TX            77096
    #>  9  2257 Hous… US      -95.5  29.9 13484 Northw… Hous… TX            77040
    #> 10  2724 Pasa… US      -95.2  29.7 1107 Shaver … Pasa… TX            77506
    #> # ... with 76 more rows, and 3 more variables: phoneNumber <chr>,
    #> #   sundayOpen <lgl>, timezone <chr>
