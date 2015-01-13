library(ggvis)

# For dropdown menu
actionLink <- function(inputId, ...) {
        tags$a(href='javascript:void',
               id=inputId,
               class='action-button',
               ...)
}

shinyUI(fluidPage(
        titlePanel("Swear Word Analysis using Google NGram Data"),
        fluidRow(
                column(3,
                       wellPanel(
                               h4("Filter"),
                               sliderInput("Year", "Year", 1500, 2009, value = c(1970, 2009)),
                               selectInput("target", "Target of the insult",
                                           c("All", "Arabian", "Asian", "Black", "Caucasian", "Chinese", "Coward", 
                                             "fat people", "German", "Homosexual", "Idiot", "Irish", "Italian", "Japanese", 
                                             "Jewish", "Lesbian", "Loser", "men idiot", "men lowlife", "men promiscuous", 
                                             "mess up", "Mexican", "Nonsense", "Other", "Pakistani", "Russian", "Swearing", 
                                             "Women", "women lowlife", "women promiscuous")
                               )
                       ),
                       wellPanel(
                               selectInput("xvar", "X-axis variable", axis_x_vars, selected = "Offensive_Level"),
                               selectInput("yvar", "Y-axis variable", axis_y_vars, selected = "Frequency")
                
                       )
                ),
                column(9,
                       tabsetPanel(
                               tabPanel("Plot", ggvisOutput("plot1")),  
                               tabPanel("Table", dataTableOutput('mytable')),
                               tabPanel("Documentation", includeHTML("BadLanguageAnalysis.html"))
                       )
                )
        )
))