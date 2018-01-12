
<!-- README.md is generated from README.Rmd. Please edit that file -->
walmartAPI
==========

[![Travis build status](https://travis-ci.org/EmilHvitfeldt/walmartAPI.svg?branch=master)](https://travis-ci.org/EmilHvitfeldt/walmartAPI) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/walmartAPI)](https://cran.r-project.org/package=walmartAPI) ![downloads](http://cranlogs.r-pkg.org/badges/grand-total/walmartAPI)

The goal of walmartAPI is to give access to the API created by [walmartlabs](https://developer.walmartlabs.com/) to search products, locate stores etc etc.

To use this package you will need an API key which you can acquire by signing up on this website <https://developer.walmartlabs.com/member>.

Installation
------------

`walmartAPI` is available on CRAN and can be installed normally with `install.packages(tidygraph).` or you can install walmartAPI from github with:

``` r
install.packages("walmartAPI")

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
    #>   itemId name  msrp  sale… upc   cate… long… thum… prod… stan… mark… prod…
    #>    <int> <chr> <lgl> <dbl> <chr> <chr> <chr> <chr> <chr> <dbl> <lgl> <chr>
    #> 1 1.93e⁷ Inte… NA      170 0782… Toys… &lt;… http… http…     0 T     http…
    #> # ... with 3 more variables: availableOnline <lgl>, offerType <chr>,
    #> #   shippingPassEligible <lgl>

search in products using plain text

``` r
walmartAPI::searching("ipod", key = key)
```

    #> # A tibble: 10 x 15
    #>     itemId name   msrp sale… upc   cate… longDesc… thum… prod… stan… mark…
    #>      <int> <chr> <dbl> <dbl> <chr> <chr> <chr>     <chr> <chr> <dbl> <lgl>
    #>  1  4.26e⁷ Appl…   300   179 8884… Elec… IPOD TOU… http… http…     0 F    
    #>  2  4.26e⁷ Appl…   247   199 8884… Elec… IPOD TOU… http… http…     0 F    
    #>  3  4.97e⁷ Refu…   120   109 8135… Elec… &lt;ul&g… http… http…     0 F    
    #>  4  1.42e⁸ Appl…    NA   240 7059… Elec… Includes… http… http…     0 T    
    #>  5  4.49e⁷ Refu…    NA   185 8189… Elec… &lt;br&g… http… http…     0 F    
    #>  6  5.41e⁸ Appl…   450   299 8884… Elec… 2015 App… http… http…     0 F    
    #>  7  1.40e⁸ Unde…    NA   190 6464… Elec… &lt;ul&g… http… http…     0 T    
    #>  8  1.09e⁸ Refu…    NA   200 6361… Elec… Features… http… http…     0 T    
    #>  9  1.72e⁸ Appl…   350   255 7187… Elec… &lt;ul&g… http… http…     0 T    
    #> 10  1.12e⁸ Appl…    NA   300 7059… Elec… The new … http… http…     0 T    
    #> # ... with 4 more variables: productUrl <chr>, availableOnline <lgl>,
    #> #   offerType <chr>, shippingPassEligible <lgl>

and locate stores in your area

``` r
store_locator(city = "Houston", key = key)
```

    #> # A tibble: 86 x 12
    #>       no name  coun…   lon   lat stre… city  stat… zip   phon… sund… time…
    #>    <int> <chr> <chr> <dbl> <dbl> <chr> <chr> <chr> <chr> <chr> <lgl> <chr>
    #>  1  5959 Hous… US    -95.4  29.8 111 … Hous… TX    77007 (713… T     CST  
    #>  2  5612 Hous… US    -95.3  29.7 2391… Hous… TX    77023 (713… T     CST  
    #>  3  4526 Hous… US    -95.4  29.8 4412… Hous… TX    77022 (713… T     CST  
    #>  4  3640 Hous… US    -95.5  29.8 1118… Hous… TX    77055 (713… T     CST  
    #>  5  3584 Hous… US    -95.5  29.7 5405… Hous… TX    77081 (713… T     CST  
    #>  6  2718 Hous… US    -95.5  29.7 9555… Hous… TX    77096 (713… T     CST  
    #>  7  2066 Hous… US    -95.5  29.7 2727… Hous… TX    77063 (713… T     CST  
    #>  8  5094 Hous… US    -95.5  29.7 9700… Hous… TX    77096 (713… T     CST  
    #>  9  2257 Hous… US    -95.5  29.9 1348… Hous… TX    77040 (713… T     CST  
    #> 10  2724 Pasa… US    -95.2  29.7 1107… Pasa… TX    77506 (713… T     CST  
    #> # ... with 76 more rows
