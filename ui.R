# ui.R
library(shiny)

shinyUI(fluidPage(
    titlePanel("Choose Predictors in Linear Model for mtcars Dataset"),

    sidebarLayout(
        sidebarPanel(
            helpText("Choose Predictors for Miles/(US) gallon (mpg)"),
            
            checkboxGroupInput("checkGroup", 
                          label = h3("Predict mpg from:"), 
                          choices = list("Number of cylinders (cyl)" = "cyl",
                                         "Displacement [cu.in.] (disp)" = "disp",
                                         "Gross horsepower (hp)" = "hp",
                                         "Rear axle ratio (drat)" = "drat",
                                         "Weight [lb/1000] (wt)" = "wt",
                                         "1/4 mile time (qsec)" = "qsec",
                                         "V/S (vs)" = "vs",
                                         "Transmission (am)" = "am",
                                         "Number of forward gears (gear)" = "gear",
                                         "Number of carburetors (carb)" = "carb"
                          ),
                          selected = "cyl")
#             fluidRow(
#                 
#                 column(3,
#                        actionButton("clearList", label = "clear list")
#                 )
#                 
#             )
        ),
        
        mainPanel(
            tabsetPanel("Choose output", selected="Help",
                tabPanel("Summary", verbatimTextOutput("summary")), 
                tabPanel("Anova", 
                         fluidRow(
                             tableOutput("anova"),
                             strong(textOutput("formula"))                 
                         )),
                tabPanel("Plots", plotOutput("plot")), 
                tabPanel("Help", 
                         fluidRow(
                             h1('How to use'),
                             tags$ul(
                                 tags$li('choose a tab'),
                                 tags$li('tick the predictor variables you want to use in your model
                                         in the sidebar on the left (all, if none is chosen)')),
                             p('Start by clicking e.g. on the tab', code('Summary')),
                             h2("What you'll see"),
                             p("What is shown in the tabs is updated immediately when the set of predictors changes."),
                             tags$ul(
                                 tags$li(code('Summary'),br(),"the summary of the fitted linear model"),
                                 tags$li(code('Anova'), br(), "the output of anova for the fitted linear model"),
                                 tags$li(code('Plots'), br(), "plots of the residuals for the fitted linear model and mpg vs. predicted mpg
                                         (both sorted according to true mpg in mtcars)"),
                                 tags$li(code('Help'), br(), "this text")),
                             p(strong("Start exploring and enjoy!"))
                         )))
        )
    )

))