This is the source code for my course project on https://amyjiangsu.shinyapps.io/DevDataProduct/. 

The data is in SQL lite database.  To run it locally, you'll need to install the latest versions of ggvis, Shiny, and dplyr, as well as RSQLite.

```{r}
# Install devtools 1.4 if needed
if (!require('devtools') || packageVersion('devtools') < 1.4) install.packages('devtools')

devtools::install_github(c('rstudio/ggvis', 'rstudio/shiny', 'hadley/dplyr'))

install.packages(c('RSQLite', 'RSQLite.extfuns'))
```
