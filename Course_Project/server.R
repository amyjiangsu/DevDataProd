library(ggvis)
library(dplyr)
library(RSQLite)
library(RSQLite.extfuns)

# Set up handles to database tables on app start
db <- src_sqlite("badlanguage.db")
BadLanguage  <- tbl(db, "swearwords")
all_words <- select(BadLanguage, Offensive_Level, Target_Level2, Words, Year, Frequency, Frequency_Book, FreqPerBook)

shinyServer(function(input, output, session) {
        
        # Filter the swear words, returning a data frame
        words <- reactive({
                # Due to dplyr issue #318, we need temp variables for input values
                minyear <- input$Year[1]
                maxyear <- input$Year[2]

                # Apply filters
                m <- all_words %>%
                        filter(
                                Year >= minyear,
                                Year <= maxyear
                        )
                
                
                if (input$target != "All") {
                        target <- paste0("%", input$target, "%")
                        m <- m %>% filter(Target_Level2 %like% target)
                }
                
                m <- as.data.frame(m)
        })
        
        # A reactive expression with the ggvis plot
        vis <- reactive({
                # Lables for axes
                xvar_name <- names(axis_x_vars)[axis_x_vars == input$xvar]
                yvar_name <- names(axis_y_vars)[axis_y_vars == input$yvar]
                
                # Normally we could do something like props(x = ~BoxOffice, y = ~Reviews),
                # but since the inputs are strings, we need to do a little more work.
                xvar <- prop("x", as.symbol(input$xvar))
                yvar <- prop("y", as.symbol(input$yvar))
        
                words %>%
                        group_by(Offensive_Level) %>%
                        ggvis(x = xvar, y = yvar, stroke = ~Offensive_Level, fill= ~Offensive_Level, fillOpacity:=0.5) %>%
                        add_axis("x", title = xvar_name, properties=axis_props(labels = list(angle = 45, align = "left")) ) %>%
                        add_axis("y", title = yvar_name) %>%
                        set_options(width = 600, height = 400)
        })
        
        vis %>% bind_shiny("plot1")
        output$mytable  <- renderDataTable({
                words()
        })
})
