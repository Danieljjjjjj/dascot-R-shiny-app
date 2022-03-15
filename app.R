library(shiny)
library(shiny)
library(dplyr)
library(DT)
library(ggplot2)
library(shinydashboard)
library(plotly)



#install.packages("data.table")
#library("data.table")
#install.packages("data.table", dependencies=TRUE)

#Read data
breed_traits <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/breed_traits.csv')
print(breed_traits)
trait_description <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/trait_description.csv')
print(trait_description)
breed_rank_all <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/breed_rank.csv')
print(breed_rank_all)


ui <- fluidPage(
    
    titlePanel("Dog breed visualisation app"),
    fluidRow(
        
        column(3,
               h3("Buttons"),
               actionButton("action", "Action"),
               br(),
               br(), 
               submitButton("Submit")),
        
        column(3, 
               checkboxGroupInput("checkGroup", 
                                  h3("Checkbox group"), 
                                  choices = list("select_breed_traits" = 1, 
                                                 "select_trait_description" = 2, 
                                                 "select_breed_rank" = 3),
                                  selected = 1)),
        
    ),
    
    sidebarLayout(
        
        sidebarPanel(
            h4("Options"),
            # selector for dog breed
            selectInput(
                inputId = "select_dog breed",
                label = "Select dog breed",
                choices = c(
                    "All",
                    "Retrievers (Labrador)",
                    "French Bulldogs",
                    "Retrievers (Golden)",
                    "Bulldogs",
                    "Poodles",
                    "Beagles",
                    "Rottweilers",
                    "Pointers",
                    "Dachshunds"
                ),
                selected = "All",
                multiple = TRUE
            ),
            # selector for dog trait
            selectInput(
                inputId = "select_dog_trait",
                label = "Select dog trait",
                choices = c(
                    "All",
                    "Affectionate With Family",
                    "Good With Young Children",
                    "Good With Other Dogs",
                    "Shedding Level",
                    "Coat Grooming Frequency",
                    "Drooling Level",
                    "Coat Type",
                    "Coat Length",
                    "Openness To Strangers",
                    "Playfulness Level",
                    "Watchdog/Protective Nature",
                    "Adaptability Level",
                    "Trainability Level",
                    "Energy Level",
                    "Barking Level",
                    "Mental Stimulation Needs"
                ), 
                selected = "All",
                multiple = FALSE
            ),
            # selector for dog breed
            selectInput(
                inputId = "select_trait_description",
                label = "Select trait description",
                choices = c(
                    "All",
                    "Trait_1",
                    "Trait_2"
                    
                ),
                selected = "All",
                multiple = TRUE
            ),
            # selector for breed_rank
            selectInput(
                inputId = "select_breed_rank",
                label = "Select breed rank",
                choices = c(
                    "All",
                    "2013 Rank",
                    "2014 Rank",
                    "2015 Rank",
                    "2016 Rank",
                    "2017 Rank",
                    "2018 Rank",
                    "2019 Rank",
                    "2020 Rank"
                    
                ),
                selected = "All",
                multiple = TRUE
            ),
            #sliders
            column(5, 
                   sliderInput("slider1", h3("traits"),
                               min = 1, max = 5, value = 2)),
            
            
            column(6, 
                   sliderInput("slider1", h3("description"),
                               min = 1, max = 5, value = 2)),
            
            
            column(5,
                   sliderInput("slider1", h3("rank"),
                               min = 2013, max = 2020, value = 2016)),
            
        ),
        
        mainPanel(
            # epicurve goes here
            plotOutput("dog_trait_epicurve"),
            br(),
            hr(),
            p("Welcome to the Dog breed visualisation app!To use this app, manipulate the widgets on the side to change the epidemic curve according to your preferences! To download a high quality image of the plot you've created,
              you can also download it with the download button. To see the raw data, use the raw data tab for an interactive form of the table. The data dictionary is as follows"),
            tags$ul(
                tags$li(tags$b("Dog breed"), " - the different names of dog breeds available"),
                tags$li(tags$b("breed_traits"), " - the di fferent traits of the dogs"),
                tags$li(tags$b("trait_description"), " - the descriptions of specific traits"),
                tags$li(tags$b("breed_rank"), " - the rank "),
                
            )
            
        ),

        
    )
)

# Sidebar with a slider input for number of bins 
sidebarLayout(
    sidebarPanel(
        sliderInput("bins",
                    "Number of bins:",
                    min = 1,
                    max = 50,
                    value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        plotOutput(outputId = "plot")
    )
)

# Server Function
server <- function(input, output) {
    output$plot <- renderPlot({
        dotPlot(s2c(paste(input$select_trait_description, collapse = "")),s2c(paste(input$select_trait_description)))
    })
    
}
# App 
shinyApp(ui = ui, server = server)


