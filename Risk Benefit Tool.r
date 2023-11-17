library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(ggplot2)
library(tidyverse)
library(data.table)
library(ggthemes)
library(collapsibleTree)
library(shinycssloaders)
library(rintrojs)
library(shinyBS)
library(shinyWidgets)
library(shinythemes)
library(DT)
library(dplyr)
library(ggpattern)
library(cowplot)

#library(shinyTable)
options(scipen = 999)


ui <- shinyUI(fluidPage(
  
  dashboardPage(
    skin = "purple",
    
    dashboardHeader(
      tags$li(
        class = "dropdown",
        tags$style(".main-header {max-height: 200px; 
                      font-size:24px; 
                      font-weight:bold; 
                      line-height:24px;}")
      ),
      title = HTML(
        "<div style = 'vertical-align:middle'>
    <h1 style = color:#d9d9d9>Risk-Benefit Tool</h1>"),
      titleWidth = "90%"
      #shiny::HTML("<size:5>")
      
    ), # end dashboardHeader
    
    ## Sidebar ----
    dashboardSidebar(
      width = 200,
      sidebarMenu(
        tags$style(
          ".main-sidebar {float:top; margin-top:40px; padding-left:15px; padding-right:15px}"
        ),
        menuItem('Introduction', tabName = 'introduction', icon = icon('hand-holding-heart')),
        menuItem('Decision Tree', tabName = 'decisiontree', icon = icon('code-branch')),
        menuItem('Inputs', tabName = 'inputs', icon = icon('edit')),
        menuItem('Outputs', tabName = 'outputs', icon = icon('hand-sparkles'))
        )
        ),
    
    ##  Body -----
    
    dashboardBody(
      tags$style(HTML(".table>thead>tr>th {font-size: 16px!important;}"),
                 HTML(".table>tbody>tr>td {font-size: 14px!important;}")),
      fluidPage(
        tabItems(
          
          ## Introduction ----
          
          tabItem(tabName = 'introduction',
                  fluidRow(
                    style = "height:40px;"
                  ),
                  fluidRow(
                    column(1),
                    column(10,
                           shiny::HTML("<br><br><center><h2><em>Plasmodium vivax</em> radical cure risk benefit assessment tool</h2></center><br>"),
                           shiny::HTML("<center><h4>A decision-support framework to guide the selection of treatment regimens and delivery strategies</h4></center>")
                    ),
                    column(1)
                  ),
                  
                  fluidRow(
                    style = "height:50px;"),
                  
                  fluidRow(
                    column(1),
                    column(10,
                           shiny::HTML("<p>In Latin American and the Caribbean (LAC) and South-East Asia (SEA), <em>Plasmodium vivax</em> (<em>P. vivax</em>)
                           is the dominant parasite species, accounting for most of all malaria cases. Unlike <em>P. falciparum</em>, <em>P. vivax</em> has 
                           the ability to remain latent in liver-stage (hypnozoites) and can cause relapses for weeks to years. Targeting the hypnozoite is a central
                           strategy in <em>P. vivax</em> control and elimination. In LAC, the first-line treatment recommended for <em>P. vivax</em> is chloroquine (CQ),
                           a 3 day treatment course for blood stage infection, and the 8-aminoquinoline primaquine (PQ), a 7 to 14 day treatment course 
                           for liver-stages. There are several challenges that have limited safe and effective use of PQ. First, there are adherence 
                           issues associated with the long treatment courses for PQ. Second, even with complete adherence, a quarter to a third of 
                           patients will experience relapses in the months following treatment. Finally, the use of 8-aminolines is associated with 
                           potentially life-threatening hemolysis in individuals with underlying defiency of glucose 6 phosphate dehydrogenase (G6PD).
                           <br>
                           <br>
                           In recent years, new tools have been developed to improve the safety and effectiveness of radical cure. It has recently been shown that
                           alternative radical cure approaches, such as double dose primaquine, are more efficatious than the standard PQ regimens. Shorter PQ courses
                           and single dose tafenoquine (TQ, also an 8-aminoquinoline) can address adherence issues associated with the long 7- to 14- day course of standard
                           PQ regimens. Also, point-of-care testing for G6PD deficiency is also now available to facilitate safe administration of PQ and TQ. Finally,
                           while not a new strategy, there has been increased interest and support for supervision of treatment to improve adherence and provide pharmacovigilance.
                           <br>
                           <br>
                           It is anticipated that there will be different treatment regimens for <em>P. vivax</em> . Different delivery approaches will also be available regard to provision of supervised or unsupervised 
                           treatment, and quantitative G6PD testing vs. no G6PD test. Policy decisions need to consider that different treatment schemes will have different 
                           risks and benefits.
                           <br>
                           <br>
                           This risk benefit assessement tool, developed by United States President’s Malaria Initiative (PMI) Impact Malaria (IM) in collaboration with Pan 
                           American Health Organization (PAHO), aims to support decision-making regarding safe and optimal effectiveness of radical cure treatment at the 
                           national and subnational levels. The tool is not intended to provide a specific recommendation regarding the optimal treatment regimen in a 
                           particular setting. Rather, it is intended to inform the decision-making process, which will ultimately take into consideration factors not 
                           considered in this tool, e.g. cost, health system capacity, strength of available data as relevant to the local setting. The tool utilizes a 
                           decision tree model approach to consider all possible pathways outcomes for recurrences associated with 11 different treatment schemes. The 
                           exercise requires that programs collect relevant input data, and then enter these data into a Shiny App. Default inputs are provided, based 
                           on available data from the region, and these inputs can be changed if other inputs are better representing the site of interest. The tool then 
                           calculates the anticipated number of recurrences. For a given site, the tool also enables stakeholders to utilize two different schemes and compare 
                           the number of anticipated recurrences if the treatment schemes are used at different levels or proportions. Output data for each treatment regimen
                           and delivery strategy are populated in a table and autogenerated graphs, allowing ease of comparison.  The Risk Benefit Tool refers to this Shiny 
                           App tool and an accompanying narrative document, which should always be used together. The Shiny App tool application is available on the website
                           for 25 hours per month. If usage has been exceeded, you may download the <a href=‘https://github.com/XueWuUCSF/Risk-Benefit-Tool’> R code</a> to run the App directly on your device. If you have 
                           any questions about the tool,you can contact: <i>xue.wu@ucsf.edu</i>. The narrative document can be accessed at [insert URL].</p>")
                    ),
                    column(1)
                  )),
          
          ## Decision Tree ----
          
          tabItem(tabName = 'decisiontree',
                  fluidRow(
                    style = "height:40px;"),
                  fluidRow(
                    column(2),
                    column(8,
                           shiny::HTML("<br><br><center> <h2>Decision Tree</h2> </center><br>")
                    )),
                  fluidRow(
                    column(3),
                    column(8,
                           shiny::HTML("<h4>Click on each node to expand and follow each path</h4>"))
                  ),
                  br(),
                  fluidRow(
                    column(4,
                           shiny::HTML("<p>sd: standard dose &nbsp;&nbsp;&nbsp;dd: double dose</p>")),
                    column(4,
                           shiny::HTML("<p>PQ: Primaquine &nbsp;&nbsp;&nbsp;TQ: Tafenoquine</p>")),
                    column(4,
                           shiny::HTML("<p>NT: No Test &nbsp;&nbsp;&nbsp;QT: Quantitative Test</p>")),
                    br(),
                    column(4,
                           shiny::HTML("<p>unsv: unsupervised &nbsp;&nbsp;&nbsp;sv: supervised</p>")),
                    column(8,
                           shiny::HTML("<p>7: 7 days course &nbsp;&nbsp;&nbsp14: 14 days course &nbsp; &nbsp; &nbsp;8wks: 8 weeks course</p>"))
                  ),
                  tabBox(width = 12,
                         tabPanel(title = "sdPQ7+sv+NT",
                                  fluidPage(
                                    column(12, 
                                           collapsibleTreeOutput('sdPQ7.sv.NT', height='600px', width='100%') %>% withSpinner(color = "red")
                                    ) # close column
                                  ) # close fluid page
                         ), # close tabpanel
                         
                        tabPanel(title = "sdPQ7+unsv+QT",
                                  fluidPage(
                                    column(12, 
                                           collapsibleTreeOutput('sdPQ7.unsv.QT', height='600px', width='100%') %>% withSpinner(color = "red")
                                    ) # close column
                                  ) # close fluidpage
                         ), # close tabpanel
                         
                        tabPanel(title = "sdPQ7+sv+QT",
                                 fluidPage(
                                   column(12, 
                                          collapsibleTreeOutput('sdPQ7.sv.QT', height='600px', width='100%') %>% withSpinner(color = "red")
                                   ) # close column
                                 ) # close fluidpage
                        ), # close tabpanel
                        
                         tabPanel(title = "sdPQ14+unsv+NT",
                                  fluidPage(
                                    column(12, 
                                           collapsibleTreeOutput('sdPQ14.unsv.NT', height='600px', width='100%') %>% withSpinner(color = "red")
                                    ) # close column
                                  ) # close fluid page
                         ), # close tabpanel
                        
                        tabPanel(title = "sdPQ14+sv+NT",
                                 fluidPage(
                                   column(12, 
                                          collapsibleTreeOutput('sdPQ14.sv.NT', height='600px', width='100%') %>% withSpinner(color = "red")
                                   ) # close column
                                 ) # close fluid page
                        ), # close tabpanel
                         
                         tabPanel(title = "ddPQ14+sv+NT",
                                 fluidPage(
                                   column(12, 
                                          collapsibleTreeOutput('ddPQ14.sv.NT', height='600px', width='100%') %>% withSpinner(color = "red")
                                   ) # close column
                                 ) # close fluid page
                        ), # close tabpanel
                         
                         tabPanel(title = "ddPQ14+unsv+QT",
                                  fluidPage(
                                    column(12, 
                                           collapsibleTreeOutput('ddPQ14.unsv.QT', height='600px', width='100%') %>% withSpinner(color = "red")
                                    ) # close column
                                  ) # close fluidpage
                         ), # close tabpanel
                        
                        tabPanel(title = "ddPQ14+sv+QT",
                                 fluidPage(
                                   column(12, 
                                          collapsibleTreeOutput('ddPQ14.sv.QT', height='600px', width='100%') %>% withSpinner(color = "red")
                                   ) # close column
                                 ) # close fluidpage
                        ), # close tabpanel
                         
                        tabPanel(title = "TQ+sv+QT",
                                 fluidPage(
                                   column(12, 
                                          collapsibleTreeOutput('TQ.sv.QT', height='600px', width='100%') %>% withSpinner(color = "red")
                                   ) # close column
                                 ) # close fluidpage
                        ), # close tabpanel
                        
                        tabPanel(title = "PQ8wks+unsv+NT",
                                 fluidPage(
                                   column(12, 
                                          collapsibleTreeOutput('PQ8wks.unsv.NT', height='600px', width='100%') %>% withSpinner(color = "red")
                                   ) # close column
                                 ) # close fluid page
                        ), # close tabpanel
                        
                        tabPanel(title = "PQ8wks+sv+NT",
                                 fluidPage(
                                   column(12, 
                                          collapsibleTreeOutput('PQ8wks.sv.NT', height='600px', width='100%') %>% withSpinner(color = "red")
                                   ) # close column
                                 ) # close fluid page
                        ) # close tabpanel
                        
                  ) #close tabbox
                  
          ), # close Decision Tree
          
          ## Inputs ----
          tabItem(tabName = 'inputs',
                  fluidRow(
                    style = "height:40px;"),
                  fluidRow(
                    column(2),
                    column(8,
                           shiny::HTML("<br><br><center> <h2>Model Inputs</h2> </center><br>")
                    )),
                  fluidRow(
                    column(2),
                    column(8,
                           shiny::HTML("<h4>Change values to vary the model inputs</h4>"))
                  ),
                  fluidRow(
                    style = "height:15px;"),
                  
                  br(),
                  tabBox(width = 12, # put the header tabs for Inputs in here
                         tabPanel(title = "Epidemiology",
                                  fluidRow(
                                    style = "height:40px"),
                                  
                                  fluidPage(
                                    chooseSliderSkin("Flat", "purple"),
                                    column(6,
                                           fluidRow(
                                             column(12,
                                                    shiny::HTML("<h5>Country</h5>")
                                             )),
                                           textInput('country',
                                                     " ",
                                                     value = " "), # close country text input
                                           br(),
                                           fluidRow(
                                             column(12,
                                                    shiny::HTML("<h5>Number of <em>P.</em> vivax cases</h5>")
                                             )),
                                           numericInput('Num',
                                                        " ",
                                                        value = 10000,
                                                        min = 10,
                                                        max = 100000) # close patient numbers numeric input
                                           ), # close column
                                    column(6,
                                           fluidRow(
                                             column(12,
                                                    shiny::HTML("<h5>Percentage of male patients infected by <em>P.</em>vivax</h5>")
                                             )),
                                           flowLayout(
                                             sliderInput('P1.1.min',
                                                         'minimum',
                                                         value = 60,
                                                         min = 0,
                                                         max = 100,
                                                         step = 0.1,
                                                         post = "%"),  # close P1.1.min slider 
                                             sliderInput('P1.1.max',
                                                         'maximum',
                                                         value = 60,
                                                         min = 0,
                                                         max = 100,
                                                         step = 0.1,
                                                         post = "%")  # close P1.1.max slider
                                           ),  # close flowlayout
                                           br(),
                                           fluidRow(
                                             column(12,
                                                    shiny::HTML("<h5>Prevalence of G6PD deficiency</h5>")
                                             )),
                                           flowLayout(
                                             sliderInput('P2.1.min',
                                                         'minimum',
                                                         value = 0,
                                                         min = 0,
                                                         max = 100,
                                                         step = 0.1,
                                                         post = "%"),  # close P2.1.min slider
                                             sliderInput('P2.1.max',
                                                         'maximum',
                                                         value = 4.9,
                                                         min = 0,
                                                         max = 100,
                                                         step = 0.1,
                                                         post = "%")  # close P2.1.max slider
                                           ), 
                                           br(),
                                           fluidRow(
                                             column(12,
                                                    shiny::HTML("<h5>Hemolytic risk in the site</h5>")
                                             )),
                                           selectInput("Risk",
                                                       " ",
                                                       c("Low","High"))  # close selectInput
                                           ) # close column
                                    )  # close fluidPage
                                  ),   # close the general tabpanel
                         
                         tabPanel(title = "Scenarios",
                                  fluidRow(
                                    style = "height:40px"),
                                  fluidPage(
                                    chooseSliderSkin("Flat", "purple"),
                                    column(6,
                                           fluidRow(
                                             column(12,
                                                    shiny::HTML("<h5>Single treatment scenario</h5>")
                                             )),
                                           selectInput("Treatment",
                                                       " ",
                                                       c("All",
                                                         "Supervised + Quantitative Test",
                                                         "Unsupervised + Quantitative Test",
                                                         "Supervised + No Test",
                                                         "Unsupervised + No Test"))  # close selectInput
                                    ),  # close column
                                    
                                    column(6,
                                           fluidRow(
                                             column(12,
                                                    shiny::HTML("<h5>Two treatment scenarios</h5>")
                                             )),
                                           br(),
                                           fluidRow(
                                             column(12,
                                                    shiny::HTML("<h5>For those sites where different treatment scenarios might be used in different areas:</h5>")
                                                    )),
                                           fluidRow(
                                             column(12,
                                                    shiny::HTML("<h5>The proportion of population in area A</h5>")
                                             )),
                                           sliderInput('A',
                                                       ' ',
                                                       value = 50,
                                                       min = 0,
                                                       max = 100,
                                                       step = 0.1,
                                                       post = "%"),  # close A slider
                                           fluidRow(
                                             column(12,
                                                    shiny::HTML("<p style=font-size:1.5rem>Proportion in area B = 1 - Proportion in area A</p>"))
                                           ),   ## close fluidRow
                                           br(),
                                           fluidRow(
                                             column(12,
                                                    shiny::HTML("<h5>Treatment scenario in area A</h5>")
                                             )),
                                           selectInput("Treatment.A",
                                                       " ",
                                                       choices = c("All",
                                                                   "Supervised + Quantitative Test",
                                                                   "Unsupervised + Quantitative Test",
                                                                   "Supervised + No Test")),  # close pickerInput
                                           fluidRow(
                                             column(12,
                                                    shiny::HTML("<h5>Treatment scenario in area B</h5>")
                                             )),
                                           selectInput("Treatment.B",
                                                       " ",
                                                       choices = c("All",
                                                                   "Unsupervised + Quantitative Test",
                                                                   "Supervised + No Test",
                                                                   "Unsupervised + No Test"))  # close pickerInput
                                    )  # close column
                                    )  # close fluidPage
                                  ),   # close the epidemiology in low hemolytic risk regiontabpanel
                         
                         tabPanel(title = "Recurrence risk with supervision",
                                  fluidRow(
                                    style = "height:40px"),
                                  fluidPage(
                                    fluidRow(column(12,
                                                    shiny::HTML("<h5>Recurrence risk with supervised radical cure treatment course</h5>")
                                                    )),
                                    br(),
                                    column(6,
                                           sliderInput('P3.1',
                                                       'sdPQ7',
                                                       value = 24,
                                                       min = 0,
                                                       max = 100,
                                                       step = 0.1,
                                                       post = "%"),  # close P3.1 slider
                                           sliderInput('P3.3',
                                                       'ddPQ14',
                                                       value = 12.6,
                                                       min = 0,
                                                       max = 100,
                                                       step = 0.1,
                                                       post = "%"),  # close P3.3 slider
                                           sliderInput('P3.5',
                                                       'weekly PQ',
                                                       value = 24,
                                                       min = 0,
                                                       max = 100,
                                                       step = 0.1,
                                                       post = "%")  # close P3.5 slider
                                           ),   #  close column 1
                                    column(6,
                                           sliderInput('P3.2',
                                                       'sdPQ14',
                                                       value = 24,
                                                       min = 0,
                                                       max = 100,
                                                       step = 0.1,
                                                       post = "%"),  # close P3.2 slider
                                           sliderInput('P3.4',
                                                       'TQ',
                                                       value = 24,
                                                       min = 0,
                                                       max = 100,
                                                       step = 0.1,
                                                       post = "%")  # close P3.4 slider
                                           )    # close column 2
                                    )  # close fluidpage
                                  ), # close recurrences (supervision) tabpanel
                         
                         tabPanel(title = "Recurrence risk without supervision",
                                  fluidRow(
                                    style = "height:40px"),
                                  fluidPage(
                                    fluidRow(column(12,
                                                    shiny::HTML("<h5>Recurrence risk with unsupervised radical cure treatment course</h5>")
                                    )),
                                    br(),
                                    column(6,
                                           flowLayout(
                                             sliderInput('P3.6.min',
                                                         'sdPQ7 (minimum)',
                                                         value = 24.4,
                                                         min = 0,
                                                         max = 100,
                                                         step = 0.1,
                                                         post = "%"),  # close P4.6.min slider   
                                             
                                             sliderInput('P3.6.max',
                                                         'sdPQ7 (maximum)',
                                                         value = 36.1,
                                                         min = 0,
                                                         max = 100,
                                                         step = 0.1,
                                                         post = "%")  # close P4.6.max slider
                                           ),  # close flowlayout
                                           br(),
                                           flowLayout(
                                             sliderInput('P3.8.min',
                                                         'ddPQ14 (minimum)',
                                                         value = 16.1,
                                                         min = 0,
                                                         max = 100,
                                                         step = 0.1,
                                                         post = "%"),  # close P3.8.min slider   
                                             
                                             sliderInput('P3.8.max',
                                                         'ddPQ14 (maximum)',
                                                         value = 24.2,
                                                         min = 0,
                                                         max = 100,
                                                         step = 0.1,
                                                         post = "%")  # close P3.8.max slider
                                           )  # close flowlayout
                                           ),   #  close column 1
                                    
                                    column(6,
                                           flowLayout(
                                             sliderInput('P3.7.min',
                                                         'sdPQ14 (minimum)',
                                                         value = 24.4,
                                                         min = 0,
                                                         max = 100,
                                                         step = 0.1,
                                                         post = "%"),  # close P3.7.min slider   
                                             
                                             sliderInput('P3.7.max',
                                                         'sdPQ14 (maximum)',
                                                         value = 36.6,
                                                         min = 0,
                                                         max = 100,
                                                         step = 0.1,
                                                         post = "%")  # close P3.7.max slider
                                           ),  # close flowlayout
                                           br(),
                                           sliderInput('P3.9',
                                                       'weekly PQ',
                                                       value = 48,
                                                       min = 0,
                                                       max = 100,
                                                       step = 0.1,
                                                       post = "%")  # close P3.9 slider
                                    )    # close column 2
                                  )  # close fluidpage
                         ), # close recurrences (with unsupervision) tabpanel
                         
                         tabPanel(title = "Mean number of recurrences",
                                  fluidRow(
                                    style = "height:40px"),
                                  fluidPage(
                                    fluidRow(column(12,
                                                    shiny::HTML("<h5>Mean number of recurrences if there was at least one recurrence, for weekly PQ assume the same to sdPQ.</h5>")
                                                    )),
                                    br(),
                                    column(6,
                                           sliderInput('P3.10',
                                                       'sdPQ',
                                                       value = 1.23,
                                                       min = 0,
                                                       max = 100,
                                                       step = 0.01),  # close P3.10 slider
                                           br(),
                                           sliderInput('P3.11',
                                                       'ddPQ',
                                                       value = 0.41,
                                                       min = 0,
                                                       max = 100,
                                                       step = 0.01)  # close P3.11 slider
                                           ),   # close column 1 
                                    column(6,
                                           sliderInput('P3.12',
                                                       'TQ',
                                                       value = 1.23,
                                                       min = 0,
                                                       max = 100,
                                                       step = 0.01)  # close P3.12 slider
                                           )    # close column 2
                                    
                                    )  # close fluidpage
                                  
                         ) # close mean number of recurrences tabpanel
                         
                  )  # close tabBox
          ),   # close the inputs tabItem     
          
          ## Outputs ----
          
          ## Table ------
          tabItem(tabName = 'outputs',
                  fluidRow(
                    style = "height:35px;"),
                  fluidRow(
                    column(2),
                    column(8,
                           shiny::HTML("<br><br><center> <h2>Model Outputs</h2> </center><br>")
                    )),
                  br(),
                  fluidRow(
                    column(4,
                           shiny::HTML("<p>sd: standard dose &nbsp;&nbsp;&nbsp;dd: double dose</p>")),
                    column(4,
                           shiny::HTML("<p>PQ: Primaquine &nbsp;&nbsp;&nbsp;TQ: Tafenoquine</p>")),
                    column(4,
                           shiny::HTML("<p>NT: No Test &nbsp;&nbsp;&nbsp;QT: Quantitative Test</p>")),
                    br(),
                    column(4,
                           shiny::HTML("<p>unsv: unsupervised &nbsp;&nbsp;&nbsp;sv: supervised</p>")),
                    column(8,
                           shiny::HTML("<p>7: 7 days course &nbsp;&nbsp;&nbsp14: 14 days course &nbsp; &nbsp; &nbsp;8wks: 8 weeks course</p>"))
                  ),
                  tabBox(width = 12,
                         
                         tabPanel(title = "Figure - options for 1 treatment scenario",
                                  fluidRow(style = "height:60px"),
                                  fluidPage(
                                    fluidRow(style = "height:10px"),
                                    column(2),
                                    column(8,
                                           plotOutput("plot_1scenario")),  ## close column
                                    column(2)  
                                  )  ## close fluidPage
                         ), ## close options for 1 treatment scenario tabpanel
                         
                         tabPanel(title = "Table - options for 1 treatment scenario",
                                  fluidPage(
                                    fluidRow(style = "height:30px"),
                                    fluidRow(column(12,
                                                    dataTableOutput("table_1scenario"))  ## close column
                                    ),  ## close fluidRow
                                    br(),
                                    fluidRow(
                                      column(1),
                                      column(11,
                                             shiny::HTML("<p style=font-size:1.5rem>Recur: The number of recurrence.</p>"))
                                      )   ## close fluidRow
                                  )  ## close fluidPage
                         ), ## close Table tabpanel
                         
                         tabPanel(title = "Figure - options for 2 treatment scenarios",
                                  fluidPage(
                                    fluidRow(style = "height:10px"),
                                    fluidRow(column(12,
                                                    plotOutput("plot_2scenarios"))  ## close column
                                    )   ## close fluidRow
                                  )  ## close fluidPage
                         ), ## close options for 2 treatment scenarios tabpanel
                         
                         tabPanel(title = "Table - options for 2 treatment scenarios",
                                  fluidPage(
                                    fluidRow(style = "height:30px"),
                                    fluidRow(column(12,
                                                    dataTableOutput("table_2scenarios"))  ## close column
                                    ),  ## close fluidRow
                                    br(),
                                    fluidRow(
                                      column(1),
                                      column(11,
                                             shiny::HTML("<p style=font-size:1.5rem>A: Area A</p>"))
                                    ),   ## close fluidRow
                                    fluidRow(
                                      column(1),
                                      column(11,
                                             shiny::HTML("<p style=font-size:1.5rem>B: Area B</p>"))
                                    )   ## close fluidRow
                                    )  ## close fluidPage
                         ) ## close Table tabpanel
                         
                                 )  ## close tabbox
                        )  ## close output tabItems
          
          )                # close tabItems
      )                  # close dashboardBody
    )                  # close fluidpage
  )                  # close dashboardpage
)                  # close overall fluidpage
)                 # close shinyUI

server <- function(input, output) {
  
  #### Decision Tree Server -----
  
  Tree02 <- read_csv("~path/strategy2_sdPQ7_ob_NT.csv")
  Tree02[Tree02 =='.'] <- NA
  output$sdPQ7.sv.NT<-renderCollapsibleTree(collapsibleTree(Tree02, hierarchy = c("Gender","Treatment","Dose","Course","Observation","Recur"), 
                                                              root = "sdPQ7svNT",fill = "purple", zoomable = T, linkLength = 120))
  
  Tree03 <- read_csv("~path/strategy3_sdPQ7_unob_QT.csv")
  Tree03[Tree03 =='.'] <- NA
  output$sdPQ7.unsv.QT<-renderCollapsibleTree(collapsibleTree(Tree03, hierarchy = c("Gender","Test","TestResult","Treatment","Dose","Course","Observation","Recur"),
                                        root = "sdPQ7unsvQT",fill = "purple", zoomable = T, linkLength = 120))
  
  Tree04 <- read_csv("~path/strategy4_sdPQ7_ob_QT.csv")
  Tree04[Tree04 =='.'] <- NA
  output$sdPQ7.sv.QT<-renderCollapsibleTree(collapsibleTree(Tree04, hierarchy = c("Gender","Test","TestResult","Treatment","Dose","Course","Observation","Recur"),
                                                              root = "sdPQ7svQT",fill = "purple", zoomable = T, linkLength = 120))
  
  Tree05 <- read_csv("~path/strategy5_sdPQ14_unob_NT.csv")
  Tree05[Tree05 =='.'] <- NA
  output$sdPQ14.unsv.NT<-renderCollapsibleTree(collapsibleTree(Tree05, hierarchy = c("Gender","Treatment","Dose","Course","Observation","Recur"), 
                                          root = "sdPQ14unsvNT",fill = "purple", zoomable = T, linkLength = 120)) 
  
  Tree06 <- read_csv("~path/strategy6_sdPQ14_ob_NT.csv")
  Tree06[Tree06 =='.'] <- NA
  output$sdPQ14.sv.NT<-renderCollapsibleTree(collapsibleTree(Tree06, hierarchy = c("Gender","Treatment","Dose","Course","Observation","Recur"), 
                                                               root = "sdPQ14svNT",fill = "purple", zoomable = T, linkLength = 120)) 
  
  Tree08 <- read_csv("~path/strategy8_ddPQ14_ob_NT.csv")
  Tree08[Tree08 =='.'] <- NA
  output$ddPQ14.sv.NT<-renderCollapsibleTree(collapsibleTree(Tree08, hierarchy = c("Gender","Treatment","Dose","Course","Observation","Recur"), 
                                                               root = "ddPQ14svNT",fill = "purple", zoomable = T, linkLength = 120))
  
  Tree09 <- read_csv("~path/strategy9_ddPQ14_unob_QT.csv")
  Tree09[Tree09 =='.'] <- NA
  output$ddPQ14.unsv.QT<-renderCollapsibleTree(collapsibleTree(Tree09, hierarchy = c("Gender","Test","TestResult","Treatment","Dose","Course","Observation","Recur"),
                                         root = "ddPQ14unsvQT",fill = "purple", zoomable = T, linkLength = 120))
  
  Tree10 <- read_csv("~path/strategy10_ddPQ14_ob_QT.csv")
  Tree10[Tree10 =='.'] <- NA
  output$ddPQ14.sv.QT<-renderCollapsibleTree(collapsibleTree(Tree10, hierarchy = c("Gender","Test","TestResult","Treatment","Dose","Course","Observation","Recur"),
                                                               root = "ddPQ14svQT",fill = "purple", zoomable = T, linkLength = 120))
 
  Tree11 <- read_csv("~path/strategy11_TQ_ob_QT.csv")
  Tree11[Tree11 =='.'] <- NA
  output$TQ.sv.QT<-renderCollapsibleTree(collapsibleTree(Tree11, hierarchy = c("Gender","Test","TestResult","Treatment","Dose","Course","Observation","Recur"), 
                                                           root = "TQsvQT",fill = "purple", zoomable = T, linkLength = 120))
  
  Tree12 <- read_csv("~path/strategy12_PQ8wks_unob_NT.csv")
  Tree12[Tree12 =='.'] <- NA
  output$PQ8wks.unsv.NT<-renderCollapsibleTree(collapsibleTree(Tree12, hierarchy = c("Gender","Treatment","Dose","Course","Observation","Recur"), 
                                                                 root = "PQ8wksunsvNT",fill = "purple", zoomable = T, linkLength = 120)) 
  
  Tree13 <- read_csv("~path/strategy13_PQ8wks_ob_NT.csv")
  Tree13[Tree13 =='.'] <- NA
  output$PQ8wks.sv.NT<-renderCollapsibleTree(collapsibleTree(Tree13, hierarchy = c("Gender","Treatment","Dose","Course","Observation","Recur"), 
                                                               root = "PQ8wkssvNT",fill = "purple", zoomable = T, linkLength = 120))
  
  ## Model1: Table_1 scenario-----
  model1 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
     
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num    
    Num.Recur_sdPQ7svQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num    
    Num.Recur_ddPQ14svQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num  
    Num.Recur_TQsvQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num 
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num    
    Num.Recur_sdPQ7unsvQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num    
    Num.Recur_ddPQ14unsvQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num  
    Num.Recur_TQunsvQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num 
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.min <- P3.1 * P3.10 * Num
    Num.Recur_sdPQ7svNT.max <- P3.1 * P3.10 * Num
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.min <- P3.2 * P3.10 * Num
    Num.Recur_sdPQ14svNT.max <- P3.2 * P3.10 * Num
    
    # double dose PQ14 supervised no test
    Num.Recur_ddPQ14svNT.min <- P3.3 * P3.11 * Num
    Num.Recur_ddPQ14svNT.max <- P3.3 * P3.11 * Num
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.min <- P3.7.min * P3.10 * Num
    Num.Recur_sdPQ14unsvNT.max <- P3.7.max * P3.10 * Num
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num    
    Num.Recur_sdPQ7svQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num    
    Num.Recur_ddPQ14svQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num  
    Num.Recur_TQsvQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num 
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num    
    Num.Recur_sdPQ7unsvQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num    
    Num.Recur_ddPQ14unsvQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num  
    Num.Recur_TQunsvQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num 
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.min.high <- P3.1 * P3.10 * Num
    Num.Recur_sdPQ7svNT.max.high <- P3.1 * P3.10 * Num
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.min.high <- P3.2 * P3.10 * Num
    Num.Recur_sdPQ14svNT.max.high <- P3.2 * P3.10 * Num
    
    # weekly PQ supervised no test
    Num.Recur_wkPQsvNT.min.high <- P3.5 * P3.10 * Num
    Num.Recur_wkPQsvNT.max.high <- P3.5 * P3.10 * Num
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.min.high <- P3.7.min * P3.10 * Num
    Num.Recur_sdPQ14unsvNT.max.high <- P3.7.max * P3.10 * Num
    
    # weekly PQ unsupervised no test
    Num.Recur_wkPQunsvNT.min.high <- P3.9 * P3.10 * Num
    Num.Recur_wkPQunsvNT.max.high <- P3.9 * P3.10 * Num
    
    Risk = c("Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","High","High","High","High","High","High","High","High","High","High","High")
    Treatment = c("Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Unsupervised + No Test",
                  "Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Unsupervised + No Test","Unsupervised + No Test")
    Regimen = c("sdPQ7","ddPQ14","TQ","sdPQ7","ddPQ14","TQ","sdPQ7","sdPQ14","ddPQ14","sdPQ14","sdPQ7","ddPQ14","TQ","sdPQ7","ddPQ14","TQ","sdPQ7","sdPQ14","PQ8wks","sdPQ14","PQ8wks")
    Recur_mean = round(c(mean(c(Num.Recur_sdPQ7svQT.min,Num.Recur_sdPQ7svQT.max)),mean(c(Num.Recur_ddPQ14svQT.min,Num.Recur_ddPQ14svQT.max)),mean(c(Num.Recur_TQsvQT.min,Num.Recur_TQsvQT.max)),mean(c(Num.Recur_sdPQ7unsvQT.min,Num.Recur_sdPQ7unsvQT.max)),
                         mean(c(Num.Recur_ddPQ14unsvQT.min,Num.Recur_ddPQ14unsvQT.max)),mean(c(Num.Recur_TQunsvQT.min,Num.Recur_TQunsvQT.max)),mean(c(Num.Recur_sdPQ7svNT.min,Num.Recur_sdPQ7svNT.max)),mean(c(Num.Recur_sdPQ14svNT.min,Num.Recur_sdPQ14svNT.max)),
                         mean(c(Num.Recur_ddPQ14svNT.min,Num.Recur_ddPQ14svNT.max)),mean(c(Num.Recur_sdPQ14unsvNT.min,Num.Recur_sdPQ14unsvNT.max)),mean(c(Num.Recur_sdPQ7svQT.min.high,Num.Recur_sdPQ7svQT.max.high)),mean(c(Num.Recur_ddPQ14svQT.min.high,Num.Recur_ddPQ14svQT.max.high)),
                         mean(c(Num.Recur_TQsvQT.min.high,Num.Recur_TQsvQT.max.high)),mean(c(Num.Recur_sdPQ7unsvQT.min.high,Num.Recur_sdPQ7unsvQT.max.high)),mean(c(Num.Recur_ddPQ14unsvQT.min.high,Num.Recur_ddPQ14unsvQT.max.high)),mean(c(Num.Recur_TQunsvQT.min.high,Num.Recur_TQunsvQT.max.high)),
                         mean(c(Num.Recur_sdPQ7svNT.min.high,Num.Recur_sdPQ7svNT.max.high)),mean(c(Num.Recur_sdPQ14svNT.min.high,Num.Recur_sdPQ14svNT.max.high)),mean(c(Num.Recur_wkPQsvNT.min.high,Num.Recur_wkPQsvNT.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.min.high,Num.Recur_sdPQ14unsvNT.max.high)),
                         mean(c(Num.Recur_wkPQunsvNT.min.high,Num.Recur_wkPQunsvNT.max.high))),0)
    Recur_min = round(c(Num.Recur_sdPQ7svQT.min,Num.Recur_ddPQ14svQT.min,Num.Recur_TQsvQT.min,Num.Recur_sdPQ7unsvQT.min,Num.Recur_ddPQ14unsvQT.min,Num.Recur_TQunsvQT.min,Num.Recur_sdPQ7svNT.min,Num.Recur_sdPQ14svNT.min,Num.Recur_ddPQ14svNT.min,Num.Recur_sdPQ14unsvNT.min,Num.Recur_sdPQ7svQT.min.high,
                        Num.Recur_ddPQ14svQT.min.high,Num.Recur_TQsvQT.min.high,Num.Recur_sdPQ7unsvQT.min.high,Num.Recur_ddPQ14unsvQT.min.high,Num.Recur_TQunsvQT.min.high,Num.Recur_sdPQ7svNT.min.high,Num.Recur_sdPQ14svNT.min.high,Num.Recur_wkPQsvNT.min.high,Num.Recur_sdPQ14unsvNT.min.high,Num.Recur_wkPQunsvNT.min.high),0)
    Recur_max = round(c(Num.Recur_sdPQ7svQT.max,Num.Recur_ddPQ14svQT.max,Num.Recur_TQsvQT.max,Num.Recur_sdPQ7unsvQT.max,Num.Recur_ddPQ14unsvQT.max,Num.Recur_TQunsvQT.max,Num.Recur_sdPQ7svNT.max,Num.Recur_sdPQ14svNT.max,Num.Recur_ddPQ14svNT.max,Num.Recur_sdPQ14unsvNT.max,Num.Recur_sdPQ7svQT.max.high,
                        Num.Recur_ddPQ14svQT.max.high,Num.Recur_TQsvQT.max.high,Num.Recur_sdPQ7unsvQT.max.high,Num.Recur_ddPQ14unsvQT.max.high,Num.Recur_TQunsvQT.max.high,Num.Recur_sdPQ7svNT.max.high,Num.Recur_sdPQ14svNT.max.high,Num.Recur_wkPQsvNT.max.high,Num.Recur_sdPQ14unsvNT.max.high,Num.Recur_wkPQunsvNT.max.high),0)
    
    TT <- data.frame(Risk,Treatment,Regimen,Recur_mean,Recur_min,Recur_max)
    
    if (input$Risk != "All") {
      TT <- TT[TT$Risk == input$Risk,]
    }
    
    if (input$Treatment != "All") {
      TT <- TT[TT$Treatment == input$Treatment,]
    }
    
    results <- list(Risk = Risk,
                    Treatment = Treatment,
                    Regimen = Regimen,
                    Recur_mean = Recur_mean,
                    Recur_min = Recur_min,
                    Recur_max = Recur_max,
                    TT = TT)
    
  })# Close model1

  ## Model2: Table_2 scenarios-----
  model2 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * A    
    Num.Recur_sdPQ7svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * A
    
    Num.Recur_sdPQ7svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * B    
    Num.Recur_sdPQ7svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * B
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * A    
    Num.Recur_ddPQ14svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * A
    
    Num.Recur_ddPQ14svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * B    
    Num.Recur_ddPQ14svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * B
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B 
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * A    
    Num.Recur_sdPQ7unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * A
    
    Num.Recur_sdPQ7unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * B     
    Num.Recur_sdPQ7unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * B 
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * A   
    Num.Recur_ddPQ14unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * A
    
    Num.Recur_ddPQ14unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * B     
    Num.Recur_ddPQ14unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * B 
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQunsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQunsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B   
    Num.Recur_TQunsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B  
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.A.min <- P3.1 * P3.10 * Num * A
    Num.Recur_sdPQ7svNT.A.max <- P3.1 * P3.10 * Num * A
    
    Num.Recur_sdPQ7svNT.B.min <- P3.1 * P3.10 * Num * B
    Num.Recur_sdPQ7svNT.B.max <- P3.1 * P3.10 * Num * B
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.A.min <- P3.2 * P3.10 * Num * A
    Num.Recur_sdPQ14svNT.A.max <- P3.2 * P3.10 * Num * A
    
    Num.Recur_sdPQ14svNT.B.min <- P3.2 * P3.10 * Num * B
    Num.Recur_sdPQ14svNT.B.max <- P3.2 * P3.10 * Num * B
    
    # double dose PQ14 supervised no test
    Num.Recur_ddPQ14svNT.A.min <- P3.3 * P3.11 * Num * A
    Num.Recur_ddPQ14svNT.A.max <- P3.3 * P3.11 * Num * A
    
    Num.Recur_ddPQ14svNT.B.min <- P3.3 * P3.11 * Num * B
    Num.Recur_ddPQ14svNT.B.max <- P3.3 * P3.11 * Num * B
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.A.min <- P3.7.min * P3.10 * Num * A
    Num.Recur_sdPQ14unsvNT.A.max <- P3.7.max * P3.10 * Num * A
    
    Num.Recur_sdPQ14unsvNT.B.min <- P3.7.min * P3.10 * Num * B
    Num.Recur_sdPQ14unsvNT.B.max <- P3.7.max * P3.10 * Num * B
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.A.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * A     
    Num.Recur_sdPQ7svQT.A.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * A
    
    Num.Recur_sdPQ7svQT.B.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * B      
    Num.Recur_sdPQ7svQT.B.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * B
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.A.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * A    
    Num.Recur_ddPQ14svQT.A.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * A
    
    Num.Recur_ddPQ14svQT.B.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * B    
    Num.Recur_ddPQ14svQT.B.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * B
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.A.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQsvQT.A.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A
    
    Num.Recur_TQsvQT.B.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQsvQT.B.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.A.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * A   
    Num.Recur_sdPQ7unsvQT.A.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * A
    
    Num.Recur_sdPQ7unsvQT.B.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * B   
    Num.Recur_sdPQ7unsvQT.B.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * B
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.A.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * A    
    Num.Recur_ddPQ14unsvQT.A.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * A
    
    Num.Recur_ddPQ14unsvQT.B.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * B    
    Num.Recur_ddPQ14unsvQT.B.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * B
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.A.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQunsvQT.A.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQunsvQT.B.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQunsvQT.B.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B 
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.A.min.high <- P3.1 * P3.10 * Num * A
    Num.Recur_sdPQ7svNT.A.max.high <- P3.1 * P3.10 * Num * A
    
    Num.Recur_sdPQ7svNT.B.min.high <- P3.1 * P3.10 * Num * B
    Num.Recur_sdPQ7svNT.B.max.high <- P3.1 * P3.10 * Num * B
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.A.min.high <- P3.2 * P3.10 * Num * A
    Num.Recur_sdPQ14svNT.A.max.high <- P3.2 * P3.10 * Num * A
    
    Num.Recur_sdPQ14svNT.B.min.high <- P3.2 * P3.10 * Num * B
    Num.Recur_sdPQ14svNT.B.max.high <- P3.2 * P3.10 * Num * B
    
    # weekly PQ supervised no test
    Num.Recur_wkPQsvNT.A.min.high <- P3.5 * P3.10 * Num * A
    Num.Recur_wkPQsvNT.A.max.high <- P3.5 * P3.10 * Num * A
    
    Num.Recur_wkPQsvNT.B.min.high <- P3.5 * P3.10 * Num * B
    Num.Recur_wkPQsvNT.B.max.high <- P3.5 * P3.10 * Num * B
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.A.min.high <- P3.7.min * P3.10 * Num * A
    Num.Recur_sdPQ14unsvNT.A.max.high <- P3.7.max * P3.10 * Num * A
    
    Num.Recur_sdPQ14unsvNT.B.min.high <- P3.7.min * P3.10 * Num * B
    Num.Recur_sdPQ14unsvNT.B.max.high <- P3.7.max * P3.10 * Num * B
    
    # weekly PQ unsupervised no test
    Num.Recur_wkPQunsvNT.A.min.high <- P3.9 * P3.10 * Num * A
    Num.Recur_wkPQunsvNT.A.max.high <- P3.9 * P3.10 * Num * A
    
    Num.Recur_wkPQunsvNT.B.min.high <- P3.9 * P3.10 * Num * B
    Num.Recur_wkPQunsvNT.B.max.high <- P3.9 * P3.10 * Num * B
    
    Risk = c("Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","Low",
             "High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High","High")
    A = c("Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test",
          "Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + No Test","Supervised + No Test","Supervised + No Test",
          "Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test",
          "Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test",
          "Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test")
    A_Regimen = c("sdPQ7","sdPQ7","sdPQ7","ddPQ14","ddPQ14","ddPQ14","TQ","TQ","TQ","sdPQ7","sdPQ7","sdPQ7","ddPQ14","ddPQ14","ddPQ14","TQ","TQ","TQ","sdPQ7","ddPQ14","TQ","sdPQ7","sdPQ7","sdPQ7","ddPQ14","ddPQ14","ddPQ14","TQ","TQ","TQ","sdPQ7","ddPQ14","TQ","sdPQ7","sdPQ14","ddPQ14",
                  "sdPQ7","sdPQ7","sdPQ7","ddPQ14","ddPQ14","ddPQ14","TQ","TQ","TQ","sdPQ7","sdPQ7","sdPQ7","ddPQ14","ddPQ14","ddPQ14","TQ","TQ","TQ","sdPQ7","sdPQ7","ddPQ14","ddPQ14","TQ","TQ","sdPQ7","sdPQ7","sdPQ7","ddPQ14","ddPQ14","ddPQ14","TQ","TQ","TQ","sdPQ7","sdPQ7","ddPQ14","ddPQ14","TQ","TQ","sdPQ7","sdPQ7","sdPQ14","sdPQ14","PQ8wks","PQ8wks")
    A_mean = round(c(mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),
                     mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),
                     mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),
                     mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.A.min,Num.Recur_sdPQ7svNT.A.max)),mean(c(Num.Recur_sdPQ14svNT.A.min,Num.Recur_sdPQ14svNT.A.max)),mean(c(Num.Recur_ddPQ14svNT.A.min,Num.Recur_ddPQ14svNT.A.max)),
                     mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high)),mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high)),mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high)),
                     mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high)),mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high)),mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high)),
                     mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high)),mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high)),mean(c(Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.max.high)),mean(c(Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.max.high)),mean(c(Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.max.high)),
                     mean(c(Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.max.high)),mean(c(Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.max.high)),mean(c(Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.max.high)),mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high)),mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high)),mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high)),mean(c(Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.max.high)),mean(c(Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.max.high)),mean(c(Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.max.high)),
                     mean(c(Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.max.high)),mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high)),mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high)),mean(c(Num.Recur_sdPQ7svNT.A.min.high,Num.Recur_sdPQ7svNT.A.max.high)),mean(c(Num.Recur_sdPQ7svNT.A.min.high,Num.Recur_sdPQ7svNT.A.max.high)),mean(c(Num.Recur_sdPQ14svNT.A.min.high,Num.Recur_sdPQ14svNT.A.max.high)),mean(c(Num.Recur_sdPQ14svNT.A.min.high,Num.Recur_sdPQ14svNT.A.max.high)),mean(c(Num.Recur_wkPQsvNT.A.min.high,Num.Recur_wkPQsvNT.A.max.high)),mean(c(Num.Recur_wkPQsvNT.A.min.high,Num.Recur_wkPQsvNT.A.max.high))),0)
    A_min = round(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.min,Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.min,Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.min,Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.min,Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.min,Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.min,
                    Num.Recur_sdPQ7svQT.A.min,Num.Recur_ddPQ14svQT.A.min,Num.Recur_TQsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_TQunsvQT.A.min,Num.Recur_sdPQ7svNT.A.min,Num.Recur_sdPQ14svNT.A.min,Num.Recur_ddPQ14svNT.A.min,
                    Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.min.high,Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.min.high,
                    Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.min.high,
                    Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.min.high,Num.Recur_sdPQ7svNT.A.min.high,Num.Recur_sdPQ7svNT.A.min.high,Num.Recur_sdPQ14svNT.A.min.high,Num.Recur_sdPQ14svNT.A.min.high,Num.Recur_wkPQsvNT.A.min.high,Num.Recur_wkPQsvNT.A.min.high),0)
    A_max = round(c(Num.Recur_sdPQ7svQT.A.max,Num.Recur_sdPQ7svQT.A.max,Num.Recur_sdPQ7svQT.A.max,Num.Recur_ddPQ14svQT.A.max,Num.Recur_ddPQ14svQT.A.max,Num.Recur_ddPQ14svQT.A.max,Num.Recur_TQsvQT.A.max,Num.Recur_TQsvQT.A.max,Num.Recur_TQsvQT.A.max,Num.Recur_sdPQ7svQT.A.max,Num.Recur_sdPQ7svQT.A.max,Num.Recur_sdPQ7svQT.A.max,Num.Recur_ddPQ14svQT.A.max,Num.Recur_ddPQ14svQT.A.max,Num.Recur_ddPQ14svQT.A.max,Num.Recur_TQsvQT.A.max,Num.Recur_TQsvQT.A.max,Num.Recur_TQsvQT.A.max,
                    Num.Recur_sdPQ7svQT.A.max,Num.Recur_ddPQ14svQT.A.max,Num.Recur_TQsvQT.A.max,Num.Recur_sdPQ7unsvQT.A.max,Num.Recur_sdPQ7unsvQT.A.max,Num.Recur_sdPQ7unsvQT.A.max,Num.Recur_ddPQ14unsvQT.A.max,Num.Recur_ddPQ14unsvQT.A.max,Num.Recur_ddPQ14unsvQT.A.max,Num.Recur_TQunsvQT.A.max,Num.Recur_TQunsvQT.A.max,Num.Recur_TQunsvQT.A.max,Num.Recur_sdPQ7unsvQT.A.max,Num.Recur_ddPQ14unsvQT.A.max,Num.Recur_TQunsvQT.A.max,Num.Recur_sdPQ7svNT.A.max,Num.Recur_sdPQ14svNT.A.max,Num.Recur_ddPQ14svNT.A.max,
                    Num.Recur_sdPQ7svQT.A.max.high,Num.Recur_sdPQ7svQT.A.max.high,Num.Recur_sdPQ7svQT.A.max.high,Num.Recur_ddPQ14svQT.A.max.high,Num.Recur_ddPQ14svQT.A.max.high,Num.Recur_ddPQ14svQT.A.max.high,Num.Recur_TQsvQT.A.max.high,Num.Recur_TQsvQT.A.max.high,Num.Recur_TQsvQT.A.max.high,Num.Recur_sdPQ7svQT.A.max.high,Num.Recur_sdPQ7svQT.A.max.high,Num.Recur_sdPQ7svQT.A.max.high,Num.Recur_ddPQ14svQT.A.max.high,Num.Recur_ddPQ14svQT.A.max.high,Num.Recur_ddPQ14svQT.A.max.high,Num.Recur_TQsvQT.A.max.high,Num.Recur_TQsvQT.A.max.high,Num.Recur_TQsvQT.A.max.high,
                    Num.Recur_sdPQ7svQT.A.max.high,Num.Recur_sdPQ7svQT.A.max.high,Num.Recur_ddPQ14svQT.A.max.high,Num.Recur_ddPQ14svQT.A.max.high,Num.Recur_TQsvQT.A.max.high,Num.Recur_TQsvQT.A.max.high,Num.Recur_sdPQ7unsvQT.A.max.high,Num.Recur_sdPQ7unsvQT.A.max.high,Num.Recur_sdPQ7unsvQT.A.max.high,Num.Recur_ddPQ14unsvQT.A.max.high,Num.Recur_ddPQ14unsvQT.A.max.high,Num.Recur_ddPQ14unsvQT.A.max.high,Num.Recur_TQunsvQT.A.max.high,Num.Recur_TQunsvQT.A.max.high,Num.Recur_TQunsvQT.A.max.high,Num.Recur_sdPQ7unsvQT.A.max.high,Num.Recur_sdPQ7unsvQT.A.max.high,Num.Recur_ddPQ14unsvQT.A.max.high,
                    Num.Recur_ddPQ14unsvQT.A.max.high,Num.Recur_TQunsvQT.A.max.high,Num.Recur_TQunsvQT.A.max.high,Num.Recur_sdPQ7svNT.A.max.high,Num.Recur_sdPQ7svNT.A.max.high,Num.Recur_sdPQ14svNT.A.max.high,Num.Recur_sdPQ14svNT.A.max.high,Num.Recur_wkPQsvNT.A.max.high,Num.Recur_wkPQsvNT.A.max.high),0)
    B = c("Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test",
          "Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test",
          "Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test",
          "Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Supervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test",
          "Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test","Unsupervised + No Test")
    B_Regimen = c("sdPQ7","ddPQ14","TQ","sdPQ7","ddPQ14","TQ","sdPQ7","ddPQ14","TQ","sdPQ7","sdPQ14","ddPQ14","sdPQ7","sdPQ14","ddPQ14","sdPQ7","sdPQ14","ddPQ14","sdPQ14","sdPQ14","sdPQ14","sdPQ7","sdPQ14","ddPQ14","sdPQ7","sdPQ14","ddPQ14","sdPQ7","sdPQ14","ddPQ14","sdPQ14","sdPQ14","sdPQ14","sdPQ14","sdPQ14","sdPQ14",
                  "sdPQ7","ddPQ14","TQ","sdPQ7","ddPQ14","TQ","sdPQ7","ddPQ14","TQ","sdPQ7","sdPQ14","PQ8wks","sdPQ7","sdPQ14","PQ8wks","sdPQ7","sdPQ14","PQ8wks","sdPQ14","PQ8wks","sdPQ14","PQ8wks","sdPQ14","PQ8wks","sdPQ7","sdPQ14","PQ8wks","sdPQ7","sdPQ14","PQ8wks","sdPQ7","sdPQ14","PQ8wks","sdPQ14","PQ8wks","sdPQ14","PQ8wks","sdPQ14","PQ8wks","sdPQ14","PQ8wks","sdPQ14","PQ8wks","sdPQ14","PQ8wks")
    B_mean = round(c(mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)),mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)),mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)),
                     mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),
                     mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),
                     mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),
                     mean(c(Num.Recur_sdPQ7unsvQT.B.min.high,Num.Recur_sdPQ7unsvQT.B.max.high)),mean(c(Num.Recur_ddPQ14unsvQT.B.min.high,Num.Recur_ddPQ14unsvQT.B.max.high)),mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high)),mean(c(Num.Recur_sdPQ7unsvQT.B.min.high,Num.Recur_sdPQ7unsvQT.B.max.high)),mean(c(Num.Recur_ddPQ14unsvQT.B.min.high,Num.Recur_ddPQ14unsvQT.B.max.high)),mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high)),mean(c(Num.Recur_sdPQ7unsvQT.B.min.high,Num.Recur_sdPQ7unsvQT.B.max.high)),mean(c(Num.Recur_ddPQ14unsvQT.B.min.high,Num.Recur_ddPQ14unsvQT.B.max.high)),mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high)),
                     mean(c(Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ7svNT.B.max.high)),mean(c(Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_sdPQ14svNT.B.max.high)),mean(c(Num.Recur_wkPQsvNT.B.min.high,Num.Recur_wkPQsvNT.B.max.high)),mean(c(Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ7svNT.B.max.high)),mean(c(Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_sdPQ14svNT.B.max.high)),mean(c(Num.Recur_wkPQsvNT.B.min.high,Num.Recur_wkPQsvNT.B.max.high)),mean(c(Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ7svNT.B.max.high)),mean(c(Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_sdPQ14svNT.B.max.high)),mean(c(Num.Recur_wkPQsvNT.B.min.high,Num.Recur_wkPQsvNT.B.max.high)),
                     mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),mean(c(Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ7svNT.B.max.high)),mean(c(Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_sdPQ14svNT.B.max.high)),mean(c(Num.Recur_wkPQsvNT.B.min.high,Num.Recur_wkPQsvNT.B.max.high)),
                     mean(c(Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ7svNT.B.max.high)),mean(c(Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_sdPQ14svNT.B.max.high)),mean(c(Num.Recur_wkPQsvNT.B.min.high,Num.Recur_wkPQsvNT.B.max.high)),mean(c(Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ7svNT.B.max.high)),mean(c(Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_sdPQ14svNT.B.max.high)),mean(c(Num.Recur_wkPQsvNT.B.min.high,Num.Recur_wkPQsvNT.B.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),
                     mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high))),0)
    B_min = round(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_TQunsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_TQunsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_TQunsvQT.B.min,Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.min,Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.min,Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.min,
                    Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.min,Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.min,Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.min,Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.min,
                    Num.Recur_sdPQ7unsvQT.B.min.high,Num.Recur_ddPQ14unsvQT.B.min.high,Num.Recur_TQunsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.B.min.high,Num.Recur_ddPQ14unsvQT.B.min.high,Num.Recur_TQunsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.B.min.high,Num.Recur_ddPQ14unsvQT.B.min.high,Num.Recur_TQunsvQT.A.min.high,Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_wkPQsvNT.B.min.high,Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_wkPQsvNT.B.min.high,Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_wkPQsvNT.B.min.high,
                    Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_wkPQsvNT.B.min.high,Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_wkPQsvNT.B.min.high,Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_wkPQsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.min.high,
                    Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.min.high),0)
    B_max = round(c(Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_TQunsvQT.B.max,Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_TQunsvQT.B.max,Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_TQunsvQT.B.max,Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svNT.B.max,Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svNT.B.max,Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svNT.B.max,
                    Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svNT.B.max,Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svNT.B.max,Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svNT.B.max,Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ14unsvNT.B.max,
                    Num.Recur_sdPQ7unsvQT.B.max.high,Num.Recur_ddPQ14unsvQT.B.max.high,Num.Recur_TQunsvQT.A.max.high,Num.Recur_sdPQ7unsvQT.B.max.high,Num.Recur_ddPQ14unsvQT.B.max.high,Num.Recur_TQunsvQT.A.max.high,Num.Recur_sdPQ7unsvQT.B.max.high,Num.Recur_ddPQ14unsvQT.B.max.high,Num.Recur_TQunsvQT.A.max.high,Num.Recur_sdPQ7svNT.B.max.high,Num.Recur_sdPQ14svNT.B.max.high,Num.Recur_wkPQsvNT.B.max.high,Num.Recur_sdPQ7svNT.B.max.high,Num.Recur_sdPQ14svNT.B.max.high,Num.Recur_wkPQsvNT.B.max.high,Num.Recur_sdPQ7svNT.B.max.high,Num.Recur_sdPQ14svNT.B.max.high,Num.Recur_wkPQsvNT.B.max.high,
                    Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ7svNT.B.max.high,Num.Recur_sdPQ14svNT.B.max.high,Num.Recur_wkPQsvNT.B.max.high,Num.Recur_sdPQ7svNT.B.max.high,Num.Recur_sdPQ14svNT.B.max.high,Num.Recur_wkPQsvNT.B.max.high,Num.Recur_sdPQ7svNT.B.max.high,Num.Recur_sdPQ14svNT.B.max.high,Num.Recur_wkPQsvNT.B.max.high,Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ14unsvNT.B.max.high,
                    Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_wkPQunsvNT.B.max.high),0)
    Sum_mean = round(c(mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max))+mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max))+mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max))+mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max))+mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max))+mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),
                       mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max))+mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max))+mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max))+mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max))+mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max))+mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),
                       mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max))+mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max))+mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max))+mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max))+mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max))+mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),
                       mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max))+mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max))+mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max))+mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max))+mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max))+mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),
                       mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max))+mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max))+mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max))+mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max))+mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max))+mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),
                       mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max))+mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max))+mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max))+mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max))+mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max))+mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),
                       mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max))+mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max))+mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max))+mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ7svNT.A.min,Num.Recur_sdPQ7svNT.A.max))+mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ14svNT.A.min,Num.Recur_sdPQ14svNT.A.max))+mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),
                       mean(c(Num.Recur_ddPQ14svNT.A.min,Num.Recur_ddPQ14svNT.A.max))+mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high))+mean(c(Num.Recur_sdPQ7unsvQT.B.min.high,Num.Recur_sdPQ7unsvQT.B.max.high)),mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high))+mean(c(Num.Recur_ddPQ14unsvQT.B.min.high,Num.Recur_ddPQ14unsvQT.B.max.high)),mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high))+mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high))+mean(c(Num.Recur_sdPQ7unsvQT.B.min.high,Num.Recur_sdPQ7unsvQT.B.max.high)),
                       mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high))+mean(c(Num.Recur_ddPQ14unsvQT.B.min.high,Num.Recur_ddPQ14unsvQT.B.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high))+mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high))+mean(c(Num.Recur_sdPQ7unsvQT.B.min.high,Num.Recur_sdPQ7unsvQT.B.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high))+mean(c(Num.Recur_ddPQ14unsvQT.B.min.high,Num.Recur_ddPQ14unsvQT.B.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high))+mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high)),
                       mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high))+mean(c(Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ7svNT.B.max.high)),mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high))+mean(c(Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_sdPQ14svNT.B.max.high)),mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high))+mean(c(Num.Recur_wkPQsvNT.B.min.high,Num.Recur_wkPQsvNT.B.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high))+mean(c(Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ7svNT.B.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high))+mean(c(Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_sdPQ14svNT.B.max.high)),
                       mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high))+mean(c(Num.Recur_wkPQsvNT.B.min.high,Num.Recur_wkPQsvNT.B.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high))+mean(c(Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ7svNT.B.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high))+mean(c(Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_sdPQ14svNT.B.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high))+mean(c(Num.Recur_wkPQsvNT.B.min.high,Num.Recur_wkPQsvNT.B.max.high)),mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high))+mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),
                       mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high))+mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high))+mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high))+mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high))+mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high))+mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),
                       mean(c(Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.max.high))+mean(c(Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ7svNT.B.max.high)),mean(c(Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.max.high))+mean(c(Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_sdPQ14svNT.B.max.high)),mean(c(Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.max.high))+mean(c(Num.Recur_wkPQsvNT.B.min.high,Num.Recur_wkPQsvNT.B.max.high)),mean(c(Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.max.high))+mean(c(Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ7svNT.B.max.high)),mean(c(Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.max.high))+mean(c(Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_sdPQ14svNT.B.max.high)),
                       mean(c(Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.max.high))+mean(c(Num.Recur_wkPQsvNT.B.min.high,Num.Recur_wkPQsvNT.B.max.high)),mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high))+mean(c(Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ7svNT.B.max.high)),mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high))+mean(c(Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_sdPQ14svNT.B.max.high)),mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high))+mean(c(Num.Recur_wkPQsvNT.B.min.high,Num.Recur_wkPQsvNT.B.max.high)),mean(c(Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.max.high))+mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),
                       mean(c(Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.max.high))+mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),mean(c(Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.max.high))+mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.max.high))+mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high))+mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high))+mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),
                       mean(c(Num.Recur_sdPQ7svNT.A.min.high,Num.Recur_sdPQ7svNT.A.max.high))+mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_sdPQ7svNT.A.min.high,Num.Recur_sdPQ7svNT.A.max.high))+mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),mean(c(Num.Recur_sdPQ14svNT.A.min.high,Num.Recur_sdPQ14svNT.A.max.high))+mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_sdPQ14svNT.A.min.high,Num.Recur_sdPQ14svNT.A.max.high))+mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),mean(c(Num.Recur_wkPQsvNT.A.min.high,Num.Recur_wkPQsvNT.A.max.high))+mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),
                       mean(c(Num.Recur_wkPQsvNT.A.min.high,Num.Recur_wkPQsvNT.A.max.high))+mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high))),0)
    Sum_min = round(c(Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_TQunsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_TQunsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_TQunsvQT.B.min,
                      Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,
                      Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,
                      Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,
                      Num.Recur_sdPQ7svQT.A.min.high+Num.Recur_sdPQ7unsvQT.B.min.high,Num.Recur_sdPQ7svQT.A.min.high+Num.Recur_ddPQ14unsvQT.B.min.high,Num.Recur_sdPQ7svQT.A.min.high+Num.Recur_TQunsvQT.A.min.high,Num.Recur_ddPQ14svQT.A.min.high+Num.Recur_sdPQ7unsvQT.B.min.high,Num.Recur_ddPQ14svQT.A.min.high+Num.Recur_ddPQ14unsvQT.B.min.high,Num.Recur_ddPQ14svQT.A.min.high+Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQsvQT.A.min.high+Num.Recur_sdPQ7unsvQT.B.min.high,Num.Recur_TQsvQT.A.min.high+Num.Recur_ddPQ14unsvQT.B.min.high,Num.Recur_TQsvQT.A.min.high+Num.Recur_TQunsvQT.A.min.high,
                      Num.Recur_sdPQ7svQT.A.min.high+Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ7svQT.A.min.high+Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_sdPQ7svQT.A.min.high+Num.Recur_wkPQsvNT.B.min.high,Num.Recur_ddPQ14svQT.A.min.high+Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_ddPQ14svQT.A.min.high+Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_ddPQ14svQT.A.min.high+Num.Recur_wkPQsvNT.B.min.high,Num.Recur_TQsvQT.A.min.high+Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_TQsvQT.A.min.high+Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_TQsvQT.A.min.high+Num.Recur_wkPQsvNT.B.min.high,
                      Num.Recur_sdPQ7svQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ7svQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_ddPQ14svQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_ddPQ14svQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_TQsvQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_TQsvQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ7unsvQT.A.min.high+Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_sdPQ7unsvQT.A.min.high+Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_sdPQ7unsvQT.A.min.high+Num.Recur_wkPQsvNT.B.min.high,
                      Num.Recur_ddPQ14unsvQT.A.min.high+Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_ddPQ14unsvQT.A.min.high+Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_ddPQ14unsvQT.A.min.high+Num.Recur_wkPQsvNT.B.min.high,Num.Recur_TQunsvQT.A.min.high+Num.Recur_sdPQ7svNT.B.min.high,Num.Recur_TQunsvQT.A.min.high+Num.Recur_sdPQ14svNT.B.min.high,Num.Recur_TQunsvQT.A.min.high+Num.Recur_wkPQsvNT.B.min.high,Num.Recur_sdPQ7unsvQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ7unsvQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_ddPQ14unsvQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,
                      Num.Recur_ddPQ14unsvQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_TQunsvQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_TQunsvQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ7svNT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ7svNT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ14svNT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14svNT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQsvNT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_wkPQsvNT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high),0)
    Sum_max = round(c(Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_TQunsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_TQunsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_TQunsvQT.B.max,
                      Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,
                      Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,
                      Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ14svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,
                      Num.Recur_sdPQ7svQT.A.max.high+Num.Recur_sdPQ7unsvQT.B.max.high,Num.Recur_sdPQ7svQT.A.max.high+Num.Recur_ddPQ14unsvQT.B.max.high,Num.Recur_sdPQ7svQT.A.max.high+Num.Recur_TQunsvQT.A.max.high,Num.Recur_ddPQ14svQT.A.max.high+Num.Recur_sdPQ7unsvQT.B.max.high,Num.Recur_ddPQ14svQT.A.max.high+Num.Recur_ddPQ14unsvQT.B.max.high,Num.Recur_ddPQ14svQT.A.max.high+Num.Recur_TQunsvQT.A.max.high,Num.Recur_TQsvQT.A.max.high+Num.Recur_sdPQ7unsvQT.B.max.high,Num.Recur_TQsvQT.A.max.high+Num.Recur_ddPQ14unsvQT.B.max.high,Num.Recur_TQsvQT.A.max.high+Num.Recur_TQunsvQT.A.max.high,
                      Num.Recur_sdPQ7svQT.A.max.high+Num.Recur_sdPQ7svNT.B.max.high,Num.Recur_sdPQ7svQT.A.max.high+Num.Recur_sdPQ14svNT.B.max.high,Num.Recur_sdPQ7svQT.A.max.high+Num.Recur_wkPQsvNT.B.max.high,Num.Recur_ddPQ14svQT.A.max.high+Num.Recur_sdPQ7svNT.B.max.high,Num.Recur_ddPQ14svQT.A.max.high+Num.Recur_sdPQ14svNT.B.max.high,Num.Recur_ddPQ14svQT.A.max.high+Num.Recur_wkPQsvNT.B.max.high,Num.Recur_TQsvQT.A.max.high+Num.Recur_sdPQ7svNT.B.max.high,Num.Recur_TQsvQT.A.max.high+Num.Recur_sdPQ14svNT.B.max.high,Num.Recur_TQsvQT.A.max.high+Num.Recur_wkPQsvNT.B.max.high,
                      Num.Recur_sdPQ7svQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_sdPQ7svQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_ddPQ14svQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_ddPQ14svQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_TQsvQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_TQsvQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ7unsvQT.A.max.high+Num.Recur_sdPQ7svNT.B.max.high,Num.Recur_sdPQ7unsvQT.A.max.high+Num.Recur_sdPQ14svNT.B.max.high,Num.Recur_sdPQ7unsvQT.A.max.high+Num.Recur_wkPQsvNT.B.max.high,
                      Num.Recur_ddPQ14unsvQT.A.max.high+Num.Recur_sdPQ7svNT.B.max.high,Num.Recur_ddPQ14unsvQT.A.max.high+Num.Recur_sdPQ14svNT.B.max.high,Num.Recur_ddPQ14unsvQT.A.max.high+Num.Recur_wkPQsvNT.B.max.high,Num.Recur_TQunsvQT.A.max.high+Num.Recur_sdPQ7svNT.B.max.high,Num.Recur_TQunsvQT.A.max.high+Num.Recur_sdPQ14svNT.B.max.high,Num.Recur_TQunsvQT.A.max.high+Num.Recur_wkPQsvNT.B.max.high,Num.Recur_sdPQ7unsvQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_sdPQ7unsvQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_ddPQ14unsvQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,
                      Num.Recur_ddPQ14unsvQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_TQunsvQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_TQunsvQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ7svNT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_sdPQ7svNT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ14svNT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_sdPQ14svNT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_wkPQsvNT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_wkPQsvNT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high),0)
    
    BT <- data.frame(Risk,A,A_Regimen,A_mean,A_min,A_max,B,B_Regimen,B_mean,B_min,B_max,Sum_mean,Sum_min,Sum_max)
    
    if (input$Risk != "All") {
      BT <- BT[BT$Risk == input$Risk,]
    }
    
    if (input$Treatment.A != "All") {
      BT <- BT[BT$A == input$Treatment.A,]
    }
    
    if (input$Treatment.B != "All") {
      BT <- BT[BT$B == input$Treatment.B,]
    }
    
    results <- list(Risk = Risk,
                    A = A,
                    A_Regimen = A_Regimen,
                    A_mean = A_mean,
                    A_min = A_min,
                    A_max = A_max,
                    B = B,
                    B_Regimen = B_Regimen,
                    B_mean = B_mean,
                    B_min = B_min,
                    B_max = B_max,
                    Sum_mean = Sum_mean,
                    Sum_min = Sum_min,
                    Sum_max = Sum_max,
                    BT = BT)
    
  })# Close model2
  
  ## Model3: Low for All -----
  model3 <- reactive({
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num    
    Num.Recur_sdPQ7svQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num    
    Num.Recur_ddPQ14svQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num  
    Num.Recur_TQsvQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num 
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num    
    Num.Recur_sdPQ7unsvQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num    
    Num.Recur_ddPQ14unsvQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num  
    Num.Recur_TQunsvQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num 
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.min <- P3.1 * P3.10 * Num
    Num.Recur_sdPQ7svNT.max <- P3.1 * P3.10 * Num
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.min <- P3.2 * P3.10 * Num
    Num.Recur_sdPQ14svNT.max <- P3.2 * P3.10 * Num
    
    # double dose PQ14 supervised no test
    Num.Recur_ddPQ14svNT.min <- P3.3 * P3.11 * Num
    Num.Recur_ddPQ14svNT.max <- P3.3 * P3.11 * Num
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.min <- P3.7.min * P3.10 * Num
    Num.Recur_sdPQ14unsvNT.max <- P3.7.max * P3.10 * Num
    
    Mid_lowsvQT = c(mean(c(Num.Recur_sdPQ7svQT.max,Num.Recur_sdPQ7svQT.min)),mean(c(Num.Recur_ddPQ14svQT.max,Num.Recur_ddPQ14svQT.min)),mean(c(Num.Recur_TQsvQT.max,Num.Recur_TQsvQT.min)))
    Lower_lowsvQT = c(Num.Recur_sdPQ7svQT.min,Num.Recur_ddPQ14svQT.min,Num.Recur_TQsvQT.min)
    Upper_lowsvQT = c(Num.Recur_sdPQ7svQT.max,Num.Recur_ddPQ14svQT.max,Num.Recur_TQsvQT.max)
    Strategy_lowsvQT = c("sdPQ7","ddPQ14","TQ")
    data_lowsvQT <- data.frame(Mid_lowsvQT,Lower_lowsvQT,Upper_lowsvQT,Strategy_lowsvQT)
    
    Mid_lowunsvQT = c(mean(c(Num.Recur_sdPQ7unsvQT.max,Num.Recur_sdPQ7unsvQT.min)),mean(c(Num.Recur_ddPQ14unsvQT.max,Num.Recur_ddPQ14unsvQT.min)),mean(c(Num.Recur_TQunsvQT.max,Num.Recur_TQunsvQT.min)))
    Lower_lowunsvQT = c(Num.Recur_sdPQ7unsvQT.min,Num.Recur_ddPQ14unsvQT.min,Num.Recur_TQunsvQT.min)
    Upper_lowunsvQT = c(Num.Recur_sdPQ7unsvQT.max,Num.Recur_ddPQ14unsvQT.max,Num.Recur_TQunsvQT.max)
    Strategy_lowunsvQT = c("sdPQ7","ddPQ14","TQ")
    data_lowunsvQT <- data.frame(Mid_lowunsvQT,Lower_lowunsvQT,Upper_lowunsvQT,Strategy_lowunsvQT)
    
    Mid_lowsvNT = c(mean(c(Num.Recur_sdPQ7svNT.max,Num.Recur_sdPQ7svNT.min)),mean(c(Num.Recur_sdPQ14svNT.max,Num.Recur_sdPQ14svNT.min)),mean(c(Num.Recur_ddPQ14svNT.max,Num.Recur_ddPQ14svNT.min)))
    Lower_lowsvNT = c(Num.Recur_sdPQ7svNT.min,Num.Recur_sdPQ14svNT.min,Num.Recur_ddPQ14svNT.min)
    Upper_lowsvNT = c(Num.Recur_sdPQ7svNT.max,Num.Recur_sdPQ14svNT.max,Num.Recur_ddPQ14svNT.max)
    Strategy_lowsvNT = c("sdPQ7","sdPQ14","ddPQ14")
    data_lowsvNT <- data.frame(Mid_lowsvNT,Lower_lowsvNT,Upper_lowsvNT,Strategy_lowsvNT)
    
    Mid_lowunsvNT = c(mean(c(Num.Recur_sdPQ14unsvNT.max,Num.Recur_sdPQ14unsvNT.min)))
    Lower_lowunsvNT = c(Num.Recur_sdPQ14unsvNT.min)
    Upper_lowunsvNT = c(Num.Recur_sdPQ14unsvNT.max)
    Strategy_lowunsvNT = c("sdPQ14")
    data_lowunsvNT <- data.frame(Mid_lowunsvNT,Lower_lowunsvNT,Upper_lowunsvNT,Strategy_lowunsvNT)
    
    results <- list(data_lowsvQT = data_lowsvQT,
                    data_lowunsvQT = data_lowunsvQT,
                    data_lowsvNT = data_lowsvNT,
                    data_lowunsvNT = data_lowunsvNT)

  })# Close model3
  
  ## Model4: Low sv QT -----
  model4 <- reactive({
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num    
    Num.Recur_sdPQ7svQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num    
    Num.Recur_ddPQ14svQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num  
    Num.Recur_TQsvQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num 
    
    Mid_lowsvQT = c(mean(c(Num.Recur_sdPQ7svQT.max,Num.Recur_sdPQ7svQT.min)),mean(c(Num.Recur_ddPQ14svQT.max,Num.Recur_ddPQ14svQT.min)),mean(c(Num.Recur_TQsvQT.max,Num.Recur_TQsvQT.min)))
    Lower_lowsvQT = c(Num.Recur_sdPQ7svQT.min,Num.Recur_ddPQ14svQT.min,Num.Recur_TQsvQT.min)
    Upper_lowsvQT = c(Num.Recur_sdPQ7svQT.max,Num.Recur_ddPQ14svQT.max,Num.Recur_TQsvQT.max)
    Strategy_lowsvQT = c("sdPQ7","ddPQ14","TQ")
    
    results <- list(Mid_lowsvQT = Mid_lowsvQT,
                    Lower_lowsvQT = Lower_lowsvQT,
                    Upper_lowsvQT = Upper_lowsvQT,
                    Strategy_lowsvQT = Strategy_lowsvQT)
    
  })# Close model4

  ## Model5: Low unsv QT-----
  model5 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num    
    Num.Recur_sdPQ7unsvQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num    
    Num.Recur_ddPQ14unsvQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num  
    Num.Recur_TQunsvQT.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num 
    
    Mid_lowunsvQT = c(mean(c(Num.Recur_sdPQ7unsvQT.max,Num.Recur_sdPQ7unsvQT.min)),mean(c(Num.Recur_ddPQ14unsvQT.max,Num.Recur_ddPQ14unsvQT.min)),mean(c(Num.Recur_TQunsvQT.max,Num.Recur_TQunsvQT.min)))
    Lower_lowunsvQT = c(Num.Recur_sdPQ7unsvQT.min,Num.Recur_ddPQ14unsvQT.min,Num.Recur_TQunsvQT.min)
    Upper_lowunsvQT = c(Num.Recur_sdPQ7unsvQT.max,Num.Recur_ddPQ14unsvQT.max,Num.Recur_TQunsvQT.max)
    Strategy_lowunsvQT = c("sdPQ7","ddPQ14","TQ")
    
    results <- list(Mid_lowunsvQT = Mid_lowunsvQT,
                    Lower_lowunsvQT = Lower_lowunsvQT,
                    Upper_lowunsvQT = Upper_lowunsvQT,
                    Strategy_lowunsvQT = Strategy_lowunsvQT)
    
  })# Close model5
  
  ## Model6: Low sv NT-----
  model6 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.min <- P3.1 * P3.10 * Num
    Num.Recur_sdPQ7svNT.max <- P3.1 * P3.10 * Num
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.min <- P3.2 * P3.10 * Num
    Num.Recur_sdPQ14svNT.max <- P3.2 * P3.10 * Num
    
    # double dose PQ14 supervised no test
    Num.Recur_ddPQ14svNT.min <- P3.3 * P3.11 * Num
    Num.Recur_ddPQ14svNT.max <- P3.3 * P3.11 * Num
    
    Mid_lowsvNT = c(mean(c(Num.Recur_sdPQ7svNT.max,Num.Recur_sdPQ7svNT.min)),mean(c(Num.Recur_sdPQ14svNT.max,Num.Recur_sdPQ14svNT.min)),mean(c(Num.Recur_ddPQ14svNT.max,Num.Recur_ddPQ14svNT.min)))
    Lower_lowsvNT = c(Num.Recur_sdPQ7svNT.min,Num.Recur_sdPQ14svNT.min,Num.Recur_ddPQ14svNT.min)
    Upper_lowsvNT = c(Num.Recur_sdPQ7svNT.max,Num.Recur_sdPQ14svNT.max,Num.Recur_ddPQ14svNT.max)
    Strategy_lowsvNT = c("sdPQ7","sdPQ14","ddPQ14")
    
    results <- list(Mid_lowsvNT = Mid_lowsvNT,
                    Lower_lowsvNT = Lower_lowsvNT,
                    Upper_lowsvNT = Upper_lowsvNT,
                    Strategy_lowsvNT = Strategy_lowsvNT)
  })# Close model6
  
  ## Model7: Low unsv NT-----
  model7 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.min <- P3.7.min * P3.10 * Num
    Num.Recur_sdPQ14unsvNT.max <- P3.7.max * P3.10 * Num
    
    Mid_lowunsvNT = c(mean(c(Num.Recur_sdPQ14unsvNT.max,Num.Recur_sdPQ14unsvNT.min)))
    Lower_lowunsvNT = c(Num.Recur_sdPQ14unsvNT.min)
    Upper_lowunsvNT = c(Num.Recur_sdPQ14unsvNT.max)
    Strategy_lowunsvNT = c("sdPQ14")
    
    results <- list(Mid_lowunsvNT = Mid_lowunsvNT,
                    Lower_lowunsvNT = Lower_lowunsvNT,
                    Upper_lowunsvNT = Upper_lowunsvNT,
                    Strategy_lowunsvNT = Strategy_lowunsvNT)
  })# Close model7
  
  ## Model8: High for All -----
  model8 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num    
    Num.Recur_sdPQ7svQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num    
    Num.Recur_ddPQ14svQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num  
    Num.Recur_TQsvQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num 
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num    
    Num.Recur_sdPQ7unsvQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num    
    Num.Recur_ddPQ14unsvQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num  
    Num.Recur_TQunsvQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num 
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.min.high <- P3.1 * P3.10 * Num
    Num.Recur_sdPQ7svNT.max.high <- P3.1 * P3.10 * Num
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.min.high <- P3.2 * P3.10 * Num
    Num.Recur_sdPQ14svNT.max.high <- P3.2 * P3.10 * Num
    
    # weekly PQ supervised no test
    Num.Recur_wkPQsvNT.min.high <- P3.5 * P3.10 * Num
    Num.Recur_wkPQsvNT.max.high <- P3.5 * P3.10 * Num
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.min.high <- P3.7.min * P3.10 * Num
    Num.Recur_sdPQ14unsvNT.max.high <- P3.7.max * P3.10 * Num
    
    # weekly PQ unsupervised no test
    Num.Recur_wkPQunsvNT.min.high <- P3.9 * P3.10 * Num
    Num.Recur_wkPQunsvNT.max.high <- P3.9 * P3.10 * Num
    
    Mid_highsvQT = c(mean(c(Num.Recur_sdPQ7svQT.max.high,Num.Recur_sdPQ7svQT.min.high)),mean(c(Num.Recur_ddPQ14svQT.max.high,Num.Recur_ddPQ14svQT.min.high)),mean(c(Num.Recur_TQsvQT.min.high,Num.Recur_TQsvQT.max.high)))
    Lower_highsvQT = c(Num.Recur_sdPQ7svQT.min.high,Num.Recur_ddPQ14svQT.min.high,Num.Recur_TQsvQT.min.high)
    Upper_highsvQT = c(Num.Recur_sdPQ7svQT.max.high,Num.Recur_ddPQ14svQT.max.high,Num.Recur_TQsvQT.max.high)
    Strategy_highsvQT = c("sdPQ7","ddPQ14","TQ")
    data_highsvQT <- data.frame(Mid_highsvQT,Lower_highsvQT,Upper_highsvQT,Strategy_highsvQT)
    
    Mid_highunsvQT = c(mean(c(Num.Recur_sdPQ7unsvQT.max.high,Num.Recur_sdPQ7unsvQT.min.high)),mean(c(Num.Recur_ddPQ14unsvQT.max.high,Num.Recur_ddPQ14unsvQT.min.high)),mean(c(Num.Recur_TQunsvQT.min.high,Num.Recur_TQunsvQT.max.high)))
    Lower_highunsvQT = c(Num.Recur_sdPQ7unsvQT.min.high,Num.Recur_ddPQ14unsvQT.min.high,Num.Recur_TQunsvQT.min.high)
    Upper_highunsvQT = c(Num.Recur_sdPQ7unsvQT.max.high,Num.Recur_ddPQ14unsvQT.max.high,Num.Recur_TQunsvQT.max.high)
    Strategy_highunsvQT = c("sdPQ7","ddPQ14","TQ")
    data_highunsvQT <- data.frame(Mid_highunsvQT,Lower_highunsvQT,Upper_highunsvQT,Strategy_highunsvQT)
    
    Mid_highsvNT = c(mean(c(Num.Recur_sdPQ7svNT.max.high,Num.Recur_sdPQ7svNT.min.high)),mean(c(Num.Recur_sdPQ14svNT.max.high,Num.Recur_sdPQ14svNT.min.high)),mean(c(Num.Recur_wkPQsvNT.min.high,Num.Recur_wkPQsvNT.max.high)))
    Lower_highsvNT = c(Num.Recur_sdPQ7svNT.min.high,Num.Recur_sdPQ14svNT.min.high,Num.Recur_wkPQsvNT.min.high)
    Upper_highsvNT = c(Num.Recur_sdPQ7svNT.max.high,Num.Recur_sdPQ14svNT.max.high,Num.Recur_wkPQsvNT.max.high)
    Strategy_highsvNT = c("sdPQ7","sdPQ14","PQ8wks")
    data_highsvNT <- data.frame(Mid_highsvNT,Lower_highsvNT,Upper_highsvNT,Strategy_highsvNT)
    
    Mid_highunsvNT = c(mean(c(Num.Recur_sdPQ14unsvNT.max.high,Num.Recur_sdPQ14unsvNT.min.high)),mean(c(Num.Recur_wkPQunsvNT.min.high,Num.Recur_wkPQunsvNT.max.high)))
    Lower_highunsvNT = c(Num.Recur_sdPQ14unsvNT.min.high,Num.Recur_wkPQunsvNT.min.high)
    Upper_highunsvNT = c(Num.Recur_sdPQ14unsvNT.max.high,Num.Recur_wkPQunsvNT.max.high)
    Strategy_highunsvNT = c("sdPQ14","PQ8wks")
    data_highunsvNT <- data.frame(Mid_highunsvNT,Lower_highunsvNT,Upper_highunsvNT,Strategy_highunsvNT)
    
    results <- list(data_highsvQT = data_highsvQT,
                    data_highunsvQT = data_highunsvQT,
                    data_highsvNT = data_highsvNT,
                    data_highunsvNT = data_highunsvNT)
    
  })# Close model8
  
  ## Model9: High sv QT -----
  model9 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num    
    Num.Recur_sdPQ7svQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num    
    Num.Recur_ddPQ14svQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num  
    Num.Recur_TQsvQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num 
    
    Mid_highsvQT = c(mean(c(Num.Recur_sdPQ7svQT.max.high,Num.Recur_sdPQ7svQT.min.high)),mean(c(Num.Recur_ddPQ14svQT.max.high,Num.Recur_ddPQ14svQT.min.high)),mean(c(Num.Recur_TQsvQT.min.high,Num.Recur_TQsvQT.max.high)))
    Lower_highsvQT = c(Num.Recur_sdPQ7svQT.min.high,Num.Recur_ddPQ14svQT.min.high,Num.Recur_TQsvQT.min.high)
    Upper_highsvQT = c(Num.Recur_sdPQ7svQT.max.high,Num.Recur_ddPQ14svQT.max.high,Num.Recur_TQsvQT.max.high)
    Strategy_highsvQT = c("sdPQ7","ddPQ14","TQ")
    
    results <- list(Mid_highsvQT = Mid_highsvQT,
                    Lower_highsvQT = Lower_highsvQT,
                    Upper_highsvQT = Upper_highsvQT,
                    Strategy_highsvQT = Strategy_highsvQT)
  })# Close model9
  
  ## Model10: High unsv QT-----
  model10 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num    
    Num.Recur_sdPQ7unsvQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num    
    Num.Recur_ddPQ14unsvQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num  
    Num.Recur_TQunsvQT.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num 
    
    Mid_highunsvQT = c(mean(c(Num.Recur_sdPQ7unsvQT.max.high,Num.Recur_sdPQ7unsvQT.min.high)),mean(c(Num.Recur_ddPQ14unsvQT.max.high,Num.Recur_ddPQ14unsvQT.min.high)),mean(c(Num.Recur_TQunsvQT.min.high,Num.Recur_TQunsvQT.max.high)))
    Lower_highunsvQT = c(Num.Recur_sdPQ7unsvQT.min.high,Num.Recur_ddPQ14unsvQT.min.high,Num.Recur_TQunsvQT.min.high)
    Upper_highunsvQT = c(Num.Recur_sdPQ7unsvQT.max.high,Num.Recur_ddPQ14unsvQT.max.high,Num.Recur_TQunsvQT.max.high)
    Strategy_highunsvQT = c("sdPQ7","ddPQ14","TQ")
   
    results <- list(Mid_highunsvQT = Mid_highunsvQT,
                    Lower_highunsvQT = Lower_highunsvQT,
                    Upper_highunsvQT = Upper_highunsvQT,
                    Strategy_highunsvQT = Strategy_highunsvQT)
    
  })# Close model10
  
  ## Model11: High sv NT-----
  model11 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.min.high <- P3.1 * P3.10 * Num
    Num.Recur_sdPQ7svNT.max.high <- P3.1 * P3.10 * Num
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.min.high <- P3.2 * P3.10 * Num
    Num.Recur_sdPQ14svNT.max.high <- P3.2 * P3.10 * Num
    
    # weekly PQ supervised no test
    Num.Recur_wkPQsvNT.min.high <- P3.5 * P3.10 * Num
    Num.Recur_wkPQsvNT.max.high <- P3.5 * P3.10 * Num
    
    Mid_highsvNT = c(mean(c(Num.Recur_sdPQ7svNT.max.high,Num.Recur_sdPQ7svNT.min.high)),mean(c(Num.Recur_sdPQ14svNT.max.high,Num.Recur_sdPQ14svNT.min.high)),mean(c(Num.Recur_wkPQsvNT.min.high,Num.Recur_wkPQsvNT.max.high)))
    Lower_highsvNT = c(Num.Recur_sdPQ7svNT.min.high,Num.Recur_sdPQ14svNT.min.high,Num.Recur_wkPQsvNT.min.high)
    Upper_highsvNT = c(Num.Recur_sdPQ7svNT.max.high,Num.Recur_sdPQ14svNT.max.high,Num.Recur_wkPQsvNT.max.high)
    Strategy_highsvNT = c("sdPQ7","sdPQ14","PQ8wks")
    
    results <- list(Mid_highsvNT = Mid_highsvNT,
                    Lower_highsvNT = Lower_highsvNT,
                    Upper_highsvNT = Upper_highsvNT,
                    Strategy_highsvNT = Strategy_highsvNT)
  })# Close model11
  
  ## Model12: High unsv NT-----
  model12 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.min.high <- P3.7.min * P3.10 * Num
    Num.Recur_sdPQ14unsvNT.max.high <- P3.7.max * P3.10 * Num
    
    # weekly PQ unsupervised no test
    Num.Recur_wkPQunsvNT.min.high <- P3.9 * P3.10 * Num
    Num.Recur_wkPQunsvNT.max.high <- P3.9 * P3.10 * Num
    
    Mid_highunsvNT = c(mean(c(Num.Recur_sdPQ14unsvNT.max.high,Num.Recur_sdPQ14unsvNT.min.high)),mean(c(Num.Recur_wkPQunsvNT.min.high,Num.Recur_wkPQunsvNT.max.high)))
    Lower_highunsvNT = c(Num.Recur_sdPQ14unsvNT.min.high,Num.Recur_wkPQunsvNT.min.high)
    Upper_highunsvNT = c(Num.Recur_sdPQ14unsvNT.max.high,Num.Recur_wkPQunsvNT.max.high)
    Strategy_highunsvNT = c("sdPQ14","PQ8wks")
    
    results <- list(Mid_highunsvNT = Mid_highunsvNT,
                    Lower_highunsvNT = Lower_highunsvNT,
                    Upper_highunsvNT = Upper_highunsvNT,
                    Strategy_highunsvNT = Strategy_highunsvNT)
  })# Close model12
  
  ## Model13: Low for All (2 scenarios)-----
  model13 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * A    
    Num.Recur_sdPQ7svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * A
    
    Num.Recur_sdPQ7svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * B    
    Num.Recur_sdPQ7svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * B
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * A    
    Num.Recur_ddPQ14svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * A
    
    Num.Recur_ddPQ14svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * B    
    Num.Recur_ddPQ14svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * B
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B 
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * A    
    Num.Recur_sdPQ7unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * A
    
    Num.Recur_sdPQ7unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * B     
    Num.Recur_sdPQ7unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * B 
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * A   
    Num.Recur_ddPQ14unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * A
    
    Num.Recur_ddPQ14unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * B     
    Num.Recur_ddPQ14unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * B 
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQunsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQunsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B   
    Num.Recur_TQunsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B  
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.A.min <- P3.1 * P3.10 * Num * A
    Num.Recur_sdPQ7svNT.A.max <- P3.1 * P3.10 * Num * A
    
    Num.Recur_sdPQ7svNT.B.min <- P3.1 * P3.10 * Num * B
    Num.Recur_sdPQ7svNT.B.max <- P3.1 * P3.10 * Num * B
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.A.min <- P3.2 * P3.10 * Num * A
    Num.Recur_sdPQ14svNT.A.max <- P3.2 * P3.10 * Num * A
    
    Num.Recur_sdPQ14svNT.B.min <- P3.2 * P3.10 * Num * B
    Num.Recur_sdPQ14svNT.B.max <- P3.2 * P3.10 * Num * B
    
    # double dose PQ14 supervised no test
    Num.Recur_ddPQ14svNT.A.min <- P3.3 * P3.11 * Num * A
    Num.Recur_ddPQ14svNT.A.max <- P3.3 * P3.11 * Num * A
    
    Num.Recur_ddPQ14svNT.B.min <- P3.3 * P3.11 * Num * B
    Num.Recur_ddPQ14svNT.B.max <- P3.3 * P3.11 * Num * B
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.A.min <- P3.7.min * P3.10 * Num * A
    Num.Recur_sdPQ14unsvNT.A.max <- P3.7.max * P3.10 * Num * A
    
    Num.Recur_sdPQ14unsvNT.B.min <- P3.7.min * P3.10 * Num * B
    Num.Recur_sdPQ14unsvNT.B.max <- P3.7.max * P3.10 * Num * B
    
    
    Mid_low_svQT_unsvQT = c(mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)),
                            mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)),
                            mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)))
    Lower_low_svQT_unsvQT = c(Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_TQunsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_TQunsvQT.B.min,
                              Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_TQunsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_TQunsvQT.B.min,
                              Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_TQunsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_TQunsvQT.B.min)
    Upper_low_svQT_unsvQT = c(Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_TQunsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_TQunsvQT.B.max,
                              Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_TQunsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_TQunsvQT.B.max,
                              Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_TQunsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_TQunsvQT.B.max)
    Test_low_svQT_unsvQT = c("svQT","unsvQT","svQT","unsvQT","svQT","unsvQT","svQT","unsvQT","svQT","unsvQT","svQT","unsvQT","svQT","unsvQT","svQT","unsvQT","svQT","unsvQT")
    Strategy_low_svQT_unsvQT = c("sdPQ7+sdPQ7","sdPQ7+sdPQ7","sdPQ7+ddPQ14","sdPQ7+ddPQ14","sdPQ7+TQ","sdPQ7+TQ","ddPQ14+sdPQ7","ddPQ14+sdPQ7","ddPQ14+ddPQ14","ddPQ14+ddPQ14","ddPQ14+TQ","ddPQ14+TQ","TQ+sdPQ7","TQ+sdPQ7","TQ+ddPQ14","TQ+ddPQ14","TQ+TQ","TQ+TQ")
    Name_low_svQT_unsvQT = c("sdPQ7","sdPQ7","sdPQ7","ddPQ14","sdPQ7","TQ","ddPQ14","sdPQ7","ddPQ14","ddPQ14","ddPQ14","TQ","TQ","sdPQ7","TQ","ddPQ14","TQ","TQ")
    data_low_svQT_unsvQT <- data.frame(Mid_low_svQT_unsvQT,Lower_low_svQT_unsvQT,Upper_low_svQT_unsvQT,Test_low_svQT_unsvQT,Strategy_low_svQT_unsvQT,Name_low_svQT_unsvQT)
    
    Mid_low_svQT_svNT = c(mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),
                          mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),
                          mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)))
    Lower_low_svQT_svNT = c(Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_ddPQ14svNT.B.min,
                            Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_ddPQ14svNT.B.min,
                            Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_ddPQ14svNT.B.min)
    Upper_low_svQT_svNT = c(Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_ddPQ14svNT.B.max,
                            Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_ddPQ14svNT.B.max,
                            Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_ddPQ14svNT.B.max)
    Test_low_svQT_svNT = c("svQT","svNT","svQT","svNT","svQT","svNT","svQT","svNT","svQT","svNT","svQT","svNT","svQT","svNT","svQT","svNT","svQT","svNT")
    Strategy_low_svQT_svNT = c("sdPQ7+sdPQ7","sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ7+ddPQ14","sdPQ7+ddPQ14","ddPQ14+sdPQ7","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+sdPQ14","ddPQ14+ddPQ14","ddPQ14+ddPQ14","TQ+sdPQ7","TQ+sdPQ7","TQ+sdPQ14","TQ+sdPQ14","TQ+ddPQ14","TQ+ddPQ14")
    Name_low_svQT_svNT = c("sdPQ7","sdPQ7","sdPQ7","sdPQ14","sdPQ7","ddPQ14","ddPQ14","sdPQ7","ddPQ14","sdPQ14","ddPQ14","ddPQ14","TQ","sdPQ7","TQ","sdPQ14","TQ","ddPQ14")
    data_low_svQT_svNT <- data.frame(Mid_low_svQT_svNT,Lower_low_svQT_svNT,Upper_low_svQT_svNT,Test_low_svQT_svNT,Strategy_low_svQT_svNT,Name_low_svQT_svNT)
    
    Mid_low_svQT_unsvNT = c(mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)))
    Lower_low_svQT_unsvNT = c(Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min)
    Upper_low_svQT_unsvNT = c(Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max)
    Test_low_svQT_unsvNT = c("svQT","unsvNT","svQT","unsvNT","svQT","unsvNT")
    Strategy_low_svQT_unsvNT = c("sdPQ7+sdPQ14","sdPQ7+sdPQ14","ddPQ14+sdPQ14","ddPQ14+sdPQ14","TQ+sdPQ14","TQ+sdPQ14")
    Name_low_svQT_unsvNT = c("sdPQ7","sdPQ14","ddPQ14","sdPQ14","TQ","sdPQ14")
    data_low_svQT_unsvNT <- data.frame(Mid_low_svQT_unsvNT,Lower_low_svQT_unsvNT,Upper_low_svQT_unsvNT,Test_low_svQT_unsvNT,Strategy_low_svQT_unsvNT,Name_low_svQT_unsvNT)
    
    Mid_low_unsvQT_svNT = c(mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),
                            mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),
                            mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)))
    Lower_low_unsvQT_svNT = c(Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,
                              Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,
                              Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_ddPQ14svNT.B.min)
    Upper_low_unsvQT_svNT = c(Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,
                              Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,
                              Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_ddPQ14svNT.B.max)
    Test_low_unsvQT_svNT = c("unsvQT","svNT","unsvQT","svNT","unsvQT","svNT","unsvQT","svNT","unsvQT","svNT","unsvQT","svNT","unsvQT","svNT","unsvQT","svNT","unsvQT","svNT")
    Strategy_low_unsvQT_svNT = c("sdPQ7+sdPQ7","sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ7+ddPQ14","sdPQ7+ddPQ14","ddPQ14+sdPQ7","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+sdPQ14","ddPQ14+ddPQ14","ddPQ14+ddPQ14","TQ+sdPQ7","TQ+sdPQ7","TQ+sdPQ14","TQ+sdPQ14","TQ+ddPQ14","TQ+ddPQ14")
    Name_low_unsvQT_svNT = c("sdPQ7","sdPQ7","sdPQ7","sdPQ14","sdPQ7","ddPQ14","ddPQ14","sdPQ7","ddPQ14","sdPQ14","ddPQ14","ddPQ14","TQ","sdPQ7","TQ","sdPQ14","TQ","ddPQ14")
    data_low_unsvQT_svNT <- data.frame(Mid_low_unsvQT_svNT,Lower_low_unsvQT_svNT,Upper_low_unsvQT_svNT,Test_low_unsvQT_svNT,Strategy_low_unsvQT_svNT,Name_low_unsvQT_svNT)
    
    Mid_low_unsvQT_unsvNT = c(mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)))
    Lower_low_unsvQT_unsvNT = c(Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min)
    Upper_low_unsvQT_unsvNT = c(Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max)
    Test_low_unsvQT_unsvNT = c("unsvQT","unsvNT","unsvQT","unsvNT","unsvQT","unsvNT")
    Strategy_low_unsvQT_unsvNT = c("sdPQ7+sdPQ14","sdPQ7+sdPQ14","ddPQ14+sdPQ14","ddPQ14+sdPQ14","TQ+sdPQ14","TQ+sdPQ14")
    Name_low_unsvQT_unsvNT = c("sdPQ7","sdPQ14","ddPQ14","sdPQ14","TQ","sdPQ14")
    data_low_unsvQT_unsvNT <- data.frame(Mid_low_unsvQT_unsvNT,Lower_low_unsvQT_unsvNT,Upper_low_unsvQT_unsvNT,Test_low_unsvQT_unsvNT,Strategy_low_unsvQT_unsvNT,Name_low_unsvQT_unsvNT)
    
    Mid_low_svNT_unsvNT = c(mean(c(Num.Recur_sdPQ7svNT.A.min,Num.Recur_sdPQ7svNT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ14svNT.A.min,Num.Recur_sdPQ14svNT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_ddPQ14svNT.A.min,Num.Recur_ddPQ14svNT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)))
    Lower_low_svNT_unsvNT = c(Num.Recur_sdPQ7svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min)
    Upper_low_svNT_unsvNT = c(Num.Recur_sdPQ7svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ14svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ14svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max)
    Test_low_svNT_unsvNT = c("svNT","unsvNT","svNT","unsvNT","svNT","unsvNT")
    Strategy_low_svNT_unsvNT = c("sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ14+sdPQ14","sdPQ14+sdPQ14","ddPQ14+sdPQ14","ddPQ14+sdPQ14")
    Name_low_svNT_unsvNT = c("sdPQ7","sdPQ14","sdPQ14","sdPQ14","ddPQ14","sdPQ14")
    data_low_svNT_unsvNT <- data.frame(Mid_low_svNT_unsvNT,Lower_low_svNT_unsvNT,Upper_low_svNT_unsvNT,Test_low_svNT_unsvNT,Strategy_low_svNT_unsvNT,Name_low_svNT_unsvNT)
    
    results <- list(data_low_svQT_unsvQT = data_low_svQT_unsvQT,
                    data_low_svQT_svNT = data_low_svQT_svNT,
                    data_low_svQT_unsvNT = data_low_svQT_unsvNT,
                    data_low_unsvQT_svNT = data_low_unsvQT_svNT,
                    data_low_unsvQT_unsvNT = data_low_unsvQT_unsvNT,
                    data_low_svNT_unsvNT = data_low_svNT_unsvNT)
    
  })# Close model13
  
  ## Model14: Low svQT & unsvQT-----
  model14 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * A    
    Num.Recur_sdPQ7svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * A
    
    Num.Recur_sdPQ7svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * B    
    Num.Recur_sdPQ7svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * B
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * A    
    Num.Recur_ddPQ14svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * A
    
    Num.Recur_ddPQ14svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * B    
    Num.Recur_ddPQ14svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * B
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B 
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * A    
    Num.Recur_sdPQ7unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * A
    
    Num.Recur_sdPQ7unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * B     
    Num.Recur_sdPQ7unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * B 
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * A   
    Num.Recur_ddPQ14unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * A
    
    Num.Recur_ddPQ14unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * B     
    Num.Recur_ddPQ14unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * B 
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQunsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQunsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B   
    Num.Recur_TQunsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B  
    
    Mid_low = c(mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)),
                mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)),
                mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)))
    Lower_low = c(Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_TQunsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_TQunsvQT.B.min,
                  Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_TQunsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_TQunsvQT.B.min,
                  Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_TQunsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_TQunsvQT.B.min)
    Upper_low = c(Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_TQunsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_TQunsvQT.B.max,
                  Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_TQunsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_TQunsvQT.B.max,
                  Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_TQunsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_TQunsvQT.B.max)
    Test_low = c("Supervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + Quantitative Test",
                 "Unsupervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test")
    Strategy_low = c("sdPQ7+sdPQ7","sdPQ7+sdPQ7","sdPQ7+ddPQ14","sdPQ7+ddPQ14","sdPQ7+TQ","sdPQ7+TQ","ddPQ14+sdPQ7","ddPQ14+sdPQ7","ddPQ14+ddPQ14","ddPQ14+ddPQ14","ddPQ14+TQ","ddPQ14+TQ","TQ+sdPQ7","TQ+sdPQ7","TQ+ddPQ14","TQ+ddPQ14","TQ+TQ","TQ+TQ")
    Name_low = c("sdPQ7","sdPQ7","sdPQ7","ddPQ14","sdPQ7","TQ","ddPQ14","sdPQ7","ddPQ14","ddPQ14","ddPQ14","TQ","TQ","sdPQ7","TQ","ddPQ14","TQ","TQ")
    
    results <- list(Mid_low = Mid_low,
                    Lower_low = Lower_low,
                    Upper_low = Upper_low,
                    Test_low = Test_low,
                    Strategy_low = Strategy_low,
                    Name_low = Name_low)
 
  })# Close model14
  
  ## Model15: Low svQT vs. svNT-----
  model15 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * A     
    Num.Recur_sdPQ7svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * A
    
    Num.Recur_sdPQ7svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * B      
    Num.Recur_sdPQ7svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * B
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * A
    Num.Recur_ddPQ14svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * A
    
    Num.Recur_ddPQ14svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * B
    Num.Recur_ddPQ14svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * B
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B 
    Num.Recur_TQsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B  
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.A.min <- P3.1 * P3.10 * Num * A
    Num.Recur_sdPQ7svNT.A.max <- P3.1 * P3.10 * Num * A
    
    Num.Recur_sdPQ7svNT.B.min <- P3.1 * P3.10 * Num * B
    Num.Recur_sdPQ7svNT.B.max <- P3.1 * P3.10 * Num * B
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.A.min <- P3.2 * P3.10 * Num * A
    Num.Recur_sdPQ14svNT.A.max <- P3.2 * P3.10 * Num * A
    
    Num.Recur_sdPQ14svNT.B.min <- P3.2 * P3.10 * Num * B
    Num.Recur_sdPQ14svNT.B.max <- P3.2 * P3.10 * Num * B
    
    # double dose PQ14 supervised no test
    Num.Recur_ddPQ14svNT.A.min <- P3.3 * P3.11 * Num * A
    Num.Recur_ddPQ14svNT.A.max <- P3.3 * P3.11 * Num * A
    
    Num.Recur_ddPQ14svNT.B.min <- P3.3 * P3.11 * Num * B
    Num.Recur_ddPQ14svNT.B.max <- P3.3 * P3.11 * Num * B
    
    Mid_low = c(mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),
                mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),
                mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)))
    Lower_low = c(Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_ddPQ14svNT.B.min,
                  Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_ddPQ14svNT.B.min,
                  Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_ddPQ14svNT.B.min)
    Upper_low = c(Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_ddPQ14svNT.B.max,
                  Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_ddPQ14svNT.B.max,
                  Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_ddPQ14svNT.B.max)
    Test_low = c("Supervised + Quantitative Test","Supervised + No Test","Supervised + Quantitative Test","Supervised + No Test","Supervised + Quantitative Test","Supervised + No Test","Supervised + Quantitative Test","Supervised + No Test","Supervised + Quantitative Test",
                 "Supervised + No Test","Supervised + Quantitative Test","Supervised + No Test","Supervised + Quantitative Test","Supervised + No Test","Supervised + Quantitative Test","Supervised + No Test","Supervised + Quantitative Test","Supervised + No Test")
    Strategy_low = c("sdPQ7+sdPQ7","sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ7+ddPQ14","sdPQ7+ddPQ14","ddPQ14+sdPQ7","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+sdPQ14","ddPQ14+ddPQ14","ddPQ14+ddPQ14","TQ+sdPQ7","TQ+sdPQ7","TQ+sdPQ14","TQ+sdPQ14","TQ+ddPQ14","TQ+ddPQ14")
    Name_low = c("sdPQ7","sdPQ7","sdPQ7","sdPQ14","sdPQ7","ddPQ14","ddPQ14","sdPQ7","ddPQ14","sdPQ14","ddPQ14","ddPQ14","TQ","sdPQ7","TQ","sdPQ14","TQ","ddPQ14")
    
    results <- list(Mid_low = Mid_low,
                    Lower_low = Lower_low,
                    Upper_low = Upper_low,
                    Test_low = Test_low,
                    Strategy_low = Strategy_low,
                    Name_low = Name_low)
    
  })# Close model15
  
  ## Model16: Low svQT vs. unsvNT-----
  model16 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * A     
    Num.Recur_sdPQ7svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * A
    
    Num.Recur_sdPQ7svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * B      
    Num.Recur_sdPQ7svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * B
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * A
    Num.Recur_ddPQ14svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * A
    
    Num.Recur_ddPQ14svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * B
    Num.Recur_ddPQ14svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * B
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B 
    Num.Recur_TQsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B  
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.A.min <- P3.7.min * P3.10 * Num * A
    Num.Recur_sdPQ14unsvNT.A.max <- P3.7.max * P3.10 * Num * A
    
    Num.Recur_sdPQ14unsvNT.B.min <- P3.7.min * P3.10 * Num * B
    Num.Recur_sdPQ14unsvNT.B.max <- P3.7.max * P3.10 * Num * B
    
    Mid_low = c(mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)))
    Lower_low = c(Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min)
    Upper_low = c(Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max)
    Test_low = c("Supervised + Quantitative Test","Unsupervised + No Test","Supervised + Quantitative Test","Unsupervised + No Test","Supervised + Quantitative Test","Unsupervised + No Test")
    Strategy_low = c("sdPQ7+sdPQ14","sdPQ7+sdPQ14","ddPQ14+sdPQ14","ddPQ14+sdPQ14","TQ+sdPQ14","TQ+sdPQ14")
    Name_low = c("sdPQ7","sdPQ14","ddPQ14","sdPQ14","TQ","sdPQ14")
    
    results <- list(Mid_low = Mid_low,
                    Lower_low = Lower_low,
                    Upper_low = Upper_low,
                    Test_low = Test_low,
                    Strategy_low = Strategy_low,
                    Name_low = Name_low)
    
  })# Close model16
  
  ## Model17: Low unsvQT vs. svNT-----
  model17 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * A    
    Num.Recur_sdPQ7unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * A
    
    Num.Recur_sdPQ7unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * B    
    Num.Recur_sdPQ7unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * B
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * A    
    Num.Recur_ddPQ14unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * A
    
    Num.Recur_ddPQ14unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * B    
    Num.Recur_ddPQ14unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * B
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQunsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQunsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQunsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B 
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.A.min <- P3.1 * P3.10 * Num * A
    Num.Recur_sdPQ7svNT.A.max <- P3.1 * P3.10 * Num * A
    
    Num.Recur_sdPQ7svNT.B.min <- P3.1 * P3.10 * Num * B
    Num.Recur_sdPQ7svNT.B.max <- P3.1 * P3.10 * Num * B
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.A.min <- P3.2 * P3.10 * Num * A
    Num.Recur_sdPQ14svNT.A.max <- P3.2 * P3.10 * Num * A
    
    Num.Recur_sdPQ14svNT.B.min <- P3.2 * P3.10 * Num * B
    Num.Recur_sdPQ14svNT.B.max <- P3.2 * P3.10 * Num * B
    
    # double dose PQ14 supervised no test
    Num.Recur_ddPQ14svNT.A.min <- P3.3 * P3.11 * Num * A
    Num.Recur_ddPQ14svNT.A.max <- P3.3 * P3.11 * Num * A
    
    Num.Recur_ddPQ14svNT.B.min <- P3.3 * P3.11 * Num * B
    Num.Recur_ddPQ14svNT.B.max <- P3.3 * P3.11 * Num * B
    
    Mid_low = c(mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),
                mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)),
                mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14svNT.B.max)))
    Lower_low = c(Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,
                  Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,
                  Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_ddPQ14svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_ddPQ14svNT.B.min)
    Upper_low = c(Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,
                  Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,
                  Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_ddPQ14svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_ddPQ14svNT.B.max)
    Test_low = c("Unsupervised + Quantitative Test","Supervised + No Test","Unsupervised + Quantitative Test","Supervised + No Test","Unsupervised + Quantitative Test","Supervised + No Test","Unsupervised + Quantitative Test","Supervised + No Test","Unsupervised + Quantitative Test",
                 "Supervised + No Test","Unsupervised + Quantitative Test","Supervised + No Test","Unsupervised + Quantitative Test","Supervised + No Test","Unsupervised + Quantitative Test","Supervised + No Test","Unsupervised + Quantitative Test","Supervised + No Test")
    Strategy_low = c("sdPQ7+sdPQ7","sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ7+ddPQ14","sdPQ7+ddPQ14","ddPQ14+sdPQ7","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+sdPQ14","ddPQ14+ddPQ14","ddPQ14+ddPQ14","TQ+sdPQ7","TQ+sdPQ7","TQ+sdPQ14","TQ+sdPQ14","TQ+ddPQ14","TQ+ddPQ14")
    Name_low = c("sdPQ7","sdPQ7","sdPQ7","sdPQ14","sdPQ7","ddPQ14","ddPQ14","sdPQ7","ddPQ14","sdPQ14","ddPQ14","ddPQ14","TQ","sdPQ7","TQ","sdPQ14","TQ","ddPQ14")
    
    results <- list(Mid_low = Mid_low,
                    Lower_low = Lower_low,
                    Upper_low = Upper_low,
                    Test_low = Test_low,
                    Strategy_low = Strategy_low,
                    Name_low = Name_low)
    
  })# Close model17
  
  ## Model18: Low unsvQT vs. unsvNT-----
  model18 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * A    
    Num.Recur_sdPQ7unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * A
    
    Num.Recur_sdPQ7unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * B    
    Num.Recur_sdPQ7unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * B
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * A    
    Num.Recur_ddPQ14unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * A
    
    Num.Recur_ddPQ14unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * B    
    Num.Recur_ddPQ14unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * B
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQunsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQunsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQunsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B 
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.A.min <- P3.7.min * P3.10 * Num * A
    Num.Recur_sdPQ14unsvNT.A.max <- P3.7.max * P3.10 * Num * A
    
    Num.Recur_sdPQ14unsvNT.B.min <- P3.7.min * P3.10 * Num * B
    Num.Recur_sdPQ14unsvNT.B.max <- P3.7.max * P3.10 * Num * B
    
    Mid_low = c(mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)))
    Lower_low = c(Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min)
    Upper_low = c(Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max)
    Test_low = c("Unsupervised + Quantitative Test","Unsupervised + No Test","Unsupervised + Quantitative Test","Unsupervised + No Test","Unsupervised + Quantitative Test","Unsupervised + No Test")
    Strategy_low = c("sdPQ7+sdPQ14","sdPQ7+sdPQ14","ddPQ14+sdPQ14","ddPQ14+sdPQ14","TQ+sdPQ14","TQ+sdPQ14")
    Name_low = c("sdPQ7","sdPQ14","ddPQ14","sdPQ14","TQ","sdPQ14")
    
    results <- list(Mid_low = Mid_low,
                    Lower_low = Lower_low,
                    Upper_low = Upper_low,
                    Test_low = Test_low,
                    Strategy_low = Strategy_low,
                    Name_low = Name_low)
    
  })# Close model18
  
  ## Model19: Low svNT vs. unsvNT-----
  model19 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.A.min <- P3.1 * P3.10 * Num * A
    Num.Recur_sdPQ7svNT.A.max <- P3.1 * P3.10 * Num * A
    
    Num.Recur_sdPQ7svNT.B.min <- P3.1 * P3.10 * Num * B
    Num.Recur_sdPQ7svNT.B.max <- P3.1 * P3.10 * Num * B
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.A.min <- P3.2 * P3.10 * Num * A
    Num.Recur_sdPQ14svNT.A.max <- P3.2 * P3.10 * Num * A
    
    Num.Recur_sdPQ14svNT.B.min <- P3.2 * P3.10 * Num * B
    Num.Recur_sdPQ14svNT.B.max <- P3.2 * P3.10 * Num * B
    
    # double dose PQ14 supervised no test
    Num.Recur_ddPQ14svNT.A.min <- P3.3 * P3.11 * Num * A
    Num.Recur_ddPQ14svNT.A.max <- P3.3 * P3.11 * Num * A
    
    Num.Recur_ddPQ14svNT.B.min <- P3.3 * P3.11 * Num * B
    Num.Recur_ddPQ14svNT.B.max <- P3.3 * P3.11 * Num * B
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.A.min <- P3.7.min * P3.10 * Num * A
    Num.Recur_sdPQ14unsvNT.A.max <- P3.7.max * P3.10 * Num * A
    
    Num.Recur_sdPQ14unsvNT.B.min <- P3.7.min * P3.10 * Num * B
    Num.Recur_sdPQ14unsvNT.B.max <- P3.7.max * P3.10 * Num * B
    
    Mid_low = c(mean(c(Num.Recur_sdPQ7svNT.A.min,Num.Recur_sdPQ7svNT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ14svNT.A.min,Num.Recur_sdPQ14svNT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_ddPQ14svNT.A.min,Num.Recur_ddPQ14svNT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)))
    Lower_low = c(Num.Recur_sdPQ7svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min)
    Upper_low = c(Num.Recur_sdPQ7svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ14svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ14svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max)
    Test_low = c("Supervised + No Test","Unsupervised + No Test","Supervised + No Test","Unsupervised + No Test","Supervised + No Test","Unsupervised + No Test")
    Strategy_low = c("sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ14+sdPQ14","sdPQ14+sdPQ14","ddPQ14+sdPQ14","ddPQ14+sdPQ14")
    Name_low = c("sdPQ7","sdPQ14","sdPQ14","sdPQ14","ddPQ14","sdPQ14")
    
    results <- list(Mid_low = Mid_low,
                    Lower_low = Lower_low,
                    Upper_low = Upper_low,
                    Test_low = Test_low,
                    Strategy_low = Strategy_low,
                    Name_low = Name_low)
    
  })# Close model19
  
  ## Model20: High for All (2 scenarios) -----
  model20 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * A     
    Num.Recur_sdPQ7svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * A
    
    Num.Recur_sdPQ7svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * B      
    Num.Recur_sdPQ7svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * B
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * A    
    Num.Recur_ddPQ14svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * A
    
    Num.Recur_ddPQ14svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * B    
    Num.Recur_ddPQ14svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * B
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A
    
    Num.Recur_TQsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * A  
    Num.Recur_sdPQ7unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * A
    
    Num.Recur_sdPQ7unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * B    
    Num.Recur_sdPQ7unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * B
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * A    
    Num.Recur_ddPQ14unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * A
    
    Num.Recur_ddPQ14unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * B    
    Num.Recur_ddPQ14unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * B
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQunsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQunsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQunsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B 
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.A.min <- P3.1 * P3.10 * Num * A
    Num.Recur_sdPQ7svNT.A.max <- P3.1 * P3.10 * Num * A
    
    Num.Recur_sdPQ7svNT.B.min <- P3.1 * P3.10 * Num * B
    Num.Recur_sdPQ7svNT.B.max <- P3.1 * P3.10 * Num * B
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.A.min <- P3.2 * P3.10 * Num * A
    Num.Recur_sdPQ14svNT.A.max <- P3.2 * P3.10 * Num * A
    
    Num.Recur_sdPQ14svNT.B.min <- P3.2 * P3.10 * Num * B
    Num.Recur_sdPQ14svNT.B.max <- P3.2 * P3.10 * Num * B
    
    # weekly PQ supervised no test
    Num.Recur_wkPQsvNT.A.min <- P3.5 * P3.10 * Num * A
    Num.Recur_wkPQsvNT.A.max <- P3.5 * P3.10 * Num * A
    
    Num.Recur_wkPQsvNT.B.min <- P3.5 * P3.10 * Num * B
    Num.Recur_wkPQsvNT.B.max <- P3.5 * P3.10 * Num * B
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.A.min <- P3.7.min * P3.10 * Num * A
    Num.Recur_sdPQ14unsvNT.A.max <- P3.7.max * P3.10 * Num * A
    
    Num.Recur_sdPQ14unsvNT.B.min <- P3.7.min * P3.10 * Num * B
    Num.Recur_sdPQ14unsvNT.B.max <- P3.7.max * P3.10 * Num * B
    
    # weekly PQ unsupervised no test
    Num.Recur_wkPQunsvNT.A.min <- P3.9 * P3.10 * Num * A
    Num.Recur_wkPQunsvNT.A.max <- P3.9 * P3.10 * Num * A
    
    Num.Recur_wkPQunsvNT.B.min <- P3.9 * P3.10 * Num * B
    Num.Recur_wkPQunsvNT.B.max <- P3.9 * P3.10 * Num * B
    
    Mid_high_svQT_unsvQT = c(mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)),
                             mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)),
                             mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)))
    Lower_high_svQT_unsvQT = c(Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_TQunsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_TQunsvQT.B.min,
                               Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_TQunsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_TQunsvQT.B.min,
                               Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_TQunsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_TQunsvQT.B.min)
    Upper_high_svQT_unsvQT = c(Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_TQunsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_TQunsvQT.B.max,
                               Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_TQunsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_TQunsvQT.B.max,
                               Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_TQunsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_TQunsvQT.B.max)
    Test_high_svQT_unsvQT = c("svQT","unsvQT","svQT","unsvQT","svQT","unsvQT","svQT","unsvQT","svQT","unsvQT","svQT","unsvQT","svQT","unsvQT","svQT","unsvQT","svQT","unsvQT")
    Strategy_high_svQT_unsvQT = c("sdPQ7+sdPQ7","sdPQ7+sdPQ7","sdPQ7+ddPQ14","sdPQ7+ddPQ14","sdPQ7+TQ","sdPQ7+TQ","ddPQ14+sdPQ7","ddPQ14+sdPQ7","ddPQ14+ddPQ14","ddPQ14+ddPQ14","ddPQ14+TQ","ddPQ14+TQ","TQ+sdPQ7","TQ+sdPQ7","TQ+ddPQ14","TQ+ddPQ14","TQ+TQ","TQ+TQ")
    Name_high_svQT_unsvQT = c("sdPQ7","sdPQ7","sdPQ7","ddPQ14","sdPQ7","TQ","ddPQ14","sdPQ7","ddPQ14","ddPQ14","ddPQ14","TQ","TQ","sdPQ7","TQ","ddPQ14","TQ","TQ")
    data_high_svQT_unsvQT <- data.frame(Mid_high_svQT_unsvQT,Lower_high_svQT_unsvQT,Upper_high_svQT_unsvQT,Test_high_svQT_unsvQT,Strategy_high_svQT_unsvQT,Name_high_svQT_unsvQT)
    
    Mid_high_svQT_svNT = c(mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_wkPQsvNT.B.min,Num.Recur_wkPQsvNT.B.max)),
                           mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_wkPQsvNT.B.min,Num.Recur_wkPQsvNT.B.max)),
                           mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_wkPQsvNT.B.min,Num.Recur_wkPQsvNT.B.max)))
    Lower_high_svQT_svNT = c(Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_wkPQsvNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_wkPQsvNT.B.min,
                             Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_wkPQsvNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_wkPQsvNT.B.min,
                             Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_wkPQsvNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_wkPQsvNT.B.min)
    Upper_high_svQT_svNT = c(Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_wkPQsvNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_wkPQsvNT.B.max,
                             Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_wkPQsvNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_wkPQsvNT.B.max,
                             Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_wkPQsvNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_wkPQsvNT.B.max)
    Test_high_svQT_svNT = c("svQT","svNT","svQT","svNT","svQT","svNT","svQT","svNT","svQT","svNT","svQT","svNT","svQT","svNT","svQT","svNT","svQT","svNT")
    Strategy_high_svQT_svNT = c("sdPQ7+sdPQ7","sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ7+PQ8wks","sdPQ7+PQ8wks","ddPQ14+sdPQ7","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+sdPQ14","ddPQ14+PQ8wks","ddPQ14+PQ8wks","TQ+sdPQ7","TQ+sdPQ7","TQ+sdPQ14","TQ+sdPQ14","TQ+PQ8wks","TQ+PQ8wks")
    Name_high_svQT_svNT = c("sdPQ7","sdPQ7","sdPQ7","sdPQ14","sdPQ7","PQ8wks","ddPQ14","sdPQ7","ddPQ14","sdPQ14","ddPQ14","PQ8wks","TQ","sdPQ7","TQ","sdPQ14","TQ","PQ8wks")
    data_high_svQT_svNT <- data.frame(Mid_high_svQT_svNT,Lower_high_svQT_svNT,Upper_high_svQT_svNT,Test_high_svQT_svNT,Strategy_high_svQT_svNT,Name_high_svQT_svNT)
    
    Mid_high_svQT_unsvNT = c(mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_wkPQunsvNT.B.min,Num.Recur_wkPQunsvNT.B.max)),
                             mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_wkPQunsvNT.B.min,Num.Recur_wkPQunsvNT.B.max)),
                             mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_wkPQunsvNT.B.min,Num.Recur_wkPQunsvNT.B.max)))
    Lower_high_svQT_unsvNT = c(Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_wkPQunsvNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_wkPQunsvNT.B.min,
                               Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_wkPQunsvNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_wkPQunsvNT.B.min,
                               Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_wkPQunsvNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_wkPQunsvNT.B.min)
    Upper_high_svQT_unsvNT = c(Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_wkPQunsvNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_wkPQunsvNT.B.max,
                               Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_wkPQunsvNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_wkPQunsvNT.B.max,
                               Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_wkPQunsvNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_wkPQunsvNT.B.max)
    Test_high_svQT_unsvNT = c("svQT","unsvNT","svQT","unsvNT","svQT","unsvNT","svQT","unsvNT","svQT","unsvNT","svQT","unsvNT")
    Strategy_high_svQT_unsvNT = c("sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ7+PQ8wks","sdPQ7+PQ8wks","ddPQ14+sdPQ14","ddPQ14+sdPQ14","ddPQ14+PQ8wks","ddPQ14+PQ8wks","TQ+sdPQ14","TQ+sdPQ14","TQ+PQ8wks","TQ+PQ8wks")
    Name_high_svQT_unsvNT = c("sdPQ7","sdPQ14","sdPQ7","PQ8wks","ddPQ14","sdPQ14","ddPQ14","PQ8wks","TQ","sdPQ14","TQ","PQ8wks")
    data_high_svQT_unsvNT <- data.frame(Mid_high_svQT_unsvNT,Lower_high_svQT_unsvNT,Upper_high_svQT_unsvNT,Test_high_svQT_unsvNT,Strategy_high_svQT_unsvNT,Name_high_svQT_unsvNT)
    
    Mid_high_unsvQT_svNT = c(mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_wkPQsvNT.B.min,Num.Recur_wkPQsvNT.B.max)),
                             mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_wkPQsvNT.B.min,Num.Recur_wkPQsvNT.B.max)),
                             mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_wkPQsvNT.B.min,Num.Recur_wkPQsvNT.B.max)))
    Lower_high_unsvQT_svNT = c(Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_wkPQsvNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_wkPQsvNT.B.min,
                               Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_wkPQsvNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_wkPQsvNT.B.min,
                               Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_wkPQsvNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_wkPQsvNT.B.min)
    Upper_high_unsvQT_svNT = c(Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_wkPQsvNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_wkPQsvNT.B.max,
                               Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_wkPQsvNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_wkPQsvNT.B.max,
                               Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_wkPQsvNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_wkPQsvNT.B.max)
    Test_high_unsvQT_svNT = c("unsvQT","svNT","unsvQT","svNT","unsvQT","svNT","unsvQT","svNT","unsvQT","svNT","unsvQT","svNT","unsvQT","svNT","unsvQT","svNT","unsvQT","svNT")
    Strategy_high_unsvQT_svNT = c("sdPQ7+sdPQ7","sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ7+PQ8wks","sdPQ7+PQ8wks","ddPQ14+sdPQ7","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+sdPQ14","ddPQ14+PQ8wks","ddPQ14+PQ8wks","TQ+sdPQ7","TQ+sdPQ7","TQ+sdPQ14","TQ+sdPQ14","TQ+PQ8wks","TQ+PQ8wks")
    Name_high_unsvQT_svNT = c("sdPQ7","sdPQ7","sdPQ7","sdPQ14","sdPQ7","PQ8wks","ddPQ14","sdPQ7","ddPQ14","sdPQ14","ddPQ14","PQ8wks","TQ","sdPQ7","TQ","sdPQ14","TQ","PQ8wks")
    data_high_unsvQT_svNT <- data.frame(Mid_high_unsvQT_svNT,Lower_high_unsvQT_svNT,Upper_high_unsvQT_svNT,Test_high_unsvQT_svNT,Strategy_high_unsvQT_svNT,Name_high_unsvQT_svNT)
    
    Mid_high_unsvQT_unsvNT = c(mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_wkPQunsvNT.B.min,Num.Recur_wkPQunsvNT.B.max)),
                               mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_wkPQunsvNT.B.min,Num.Recur_wkPQunsvNT.B.max)),
                               mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_wkPQunsvNT.B.min,Num.Recur_wkPQunsvNT.B.max)))
    Lower_high_unsvQT_unsvNT = c(Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_wkPQunsvNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_wkPQunsvNT.B.min,
                                 Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_wkPQunsvNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_wkPQunsvNT.B.min,
                                 Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_wkPQunsvNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_wkPQunsvNT.B.min)
    Upper_high_unsvQT_unsvNT = c(Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_wkPQunsvNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_wkPQunsvNT.B.max,
                                 Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_wkPQunsvNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_wkPQunsvNT.B.max,
                                 Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_wkPQunsvNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_wkPQunsvNT.B.max)
    Test_high_unsvQT_unsvNT = c("unsvQT","unsvNT","unsvQT","unsvNT","unsvQT","unsvNT","unsvQT","unsvNT","unsvQT","unsvNT","unsvQT","unsvNT")
    Strategy_high_unsvQT_unsvNT = c("sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ7+PQ8wks","sdPQ7+PQ8wks","ddPQ14+sdPQ14","ddPQ14+sdPQ14","ddPQ14+PQ8wks","ddPQ14+PQ8wks","TQ+sdPQ14","TQ+sdPQ14","TQ+PQ8wks","TQ+PQ8wks")
    Name_high_unsvQT_unsvNT = c("sdPQ7","sdPQ14","sdPQ7","PQ8wks","ddPQ14","sdPQ14","ddPQ14","PQ8wks","TQ","sdPQ14","TQ","PQ8wks")
    data_high_unsvQT_unsvNT <- data.frame(Mid_high_unsvQT_unsvNT,Lower_high_unsvQT_unsvNT,Upper_high_unsvQT_unsvNT,Test_high_unsvQT_unsvNT,Strategy_high_unsvQT_unsvNT,Name_high_unsvQT_unsvNT)
    
    Mid_high_svNT_unsvNT = c(mean(c(Num.Recur_sdPQ7svNT.A.min,Num.Recur_sdPQ7svNT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ7svNT.A.min,Num.Recur_sdPQ7svNT.A.max)),mean(c(Num.Recur_wkPQunsvNT.B.min,Num.Recur_wkPQunsvNT.B.max)),
                             mean(c(Num.Recur_sdPQ14svNT.A.min,Num.Recur_sdPQ14svNT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_sdPQ14svNT.A.min,Num.Recur_sdPQ14svNT.A.max)),mean(c(Num.Recur_wkPQunsvNT.B.min,Num.Recur_wkPQunsvNT.B.max)),
                             mean(c(Num.Recur_wkPQsvNT.A.min,Num.Recur_wkPQsvNT.A.max)),mean(c(Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14unsvNT.B.max)),mean(c(Num.Recur_wkPQsvNT.A.min,Num.Recur_wkPQsvNT.A.max)),mean(c(Num.Recur_wkPQunsvNT.B.min,Num.Recur_wkPQunsvNT.B.max)))
    Lower_high_svNT_unsvNT = c(Num.Recur_sdPQ7svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ7svNT.A.min+Num.Recur_wkPQunsvNT.B.min,Num.Recur_sdPQ7svNT.A.min+Num.Recur_wkPQunsvNT.B.min,
                               Num.Recur_sdPQ14svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14svNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_sdPQ14svNT.A.min+Num.Recur_wkPQunsvNT.B.min,Num.Recur_sdPQ14svNT.A.min+Num.Recur_wkPQunsvNT.B.min,
                               Num.Recur_wkPQsvNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_wkPQsvNT.A.min+Num.Recur_sdPQ14unsvNT.B.min,Num.Recur_wkPQsvNT.A.min+Num.Recur_wkPQunsvNT.B.min,Num.Recur_wkPQsvNT.A.min+Num.Recur_wkPQunsvNT.B.min)
    Upper_high_svNT_unsvNT = c(Num.Recur_sdPQ7svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ7svNT.A.max+Num.Recur_wkPQunsvNT.B.max,Num.Recur_sdPQ7svNT.A.max+Num.Recur_wkPQunsvNT.B.max,
                               Num.Recur_sdPQ14svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ14svNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_sdPQ14svNT.A.max+Num.Recur_wkPQunsvNT.B.max,Num.Recur_sdPQ14svNT.A.max+Num.Recur_wkPQunsvNT.B.max,
                               Num.Recur_wkPQsvNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_wkPQsvNT.A.max+Num.Recur_sdPQ14unsvNT.B.max,Num.Recur_wkPQsvNT.A.max+Num.Recur_wkPQunsvNT.B.max,Num.Recur_wkPQsvNT.A.max+Num.Recur_wkPQunsvNT.B.max)
    Test_high_svNT_unsvNT = c("svNT","unsvNT","svNT","unsvNT","svNT","unsvNT","svNT","unsvNT","svNT","unsvNT","svNT","unsvNT")
    Strategy_high_svNT_unsvNT = c("sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ7+PQ8wks","sdPQ7+PQ8wks","sdPQ14+sdPQ14","sdPQ14+sdPQ14","sdPQ14+PQ8wks","sdPQ14+PQ8wks","PQ8wks+sdPQ14","PQ8wks+sdPQ14","PQ8wks+PQ8wks","PQ8wks+PQ8wks")
    Name_high_svNT_unsvNT = c("sdPQ7","sdPQ14","sdPQ7","PQ8wks","sdPQ14","sdPQ14","sdPQ14","PQ8wks","PQ8wks","sdPQ14","PQ8wks","PQ8wks")
    data_high_svNT_unsvNT <- data.frame(Mid_high_svNT_unsvNT,Lower_high_svNT_unsvNT,Upper_high_svNT_unsvNT,Test_high_svNT_unsvNT,Strategy_high_svNT_unsvNT,Name_high_svNT_unsvNT)
    
    results <- list(data_high_svQT_unsvQT = data_high_svQT_unsvQT,
                    data_high_svQT_svNT = data_high_svQT_svNT,
                    data_high_svQT_unsvNT = data_high_svQT_unsvNT,
                    data_high_unsvQT_svNT = data_high_unsvQT_svNT,
                    data_high_unsvQT_unsvNT = data_high_unsvQT_unsvNT,
                    data_high_svNT_unsvNT = data_high_svNT_unsvNT)
  })# Close model20
  
  ## Model21: High svQT vs. unsvQT -----
  model21 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * A     
    Num.Recur_sdPQ7svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * A
    
    Num.Recur_sdPQ7svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * B      
    Num.Recur_sdPQ7svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * B
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * A    
    Num.Recur_ddPQ14svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * A
    
    Num.Recur_ddPQ14svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * B    
    Num.Recur_ddPQ14svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * B
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A
    
    Num.Recur_TQsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * A  
    Num.Recur_sdPQ7unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * A
    
    Num.Recur_sdPQ7unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * B    
    Num.Recur_sdPQ7unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * B
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * A    
    Num.Recur_ddPQ14unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * A
    
    Num.Recur_ddPQ14unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * B    
    Num.Recur_ddPQ14unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * B
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQunsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQunsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQunsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B 
    
    Mid_high = c(mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)),
                 mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)),
                 mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7unsvQT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14unsvQT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_TQunsvQT.B.min,Num.Recur_TQunsvQT.B.max)))
    Lower_high = c(Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_TQunsvQT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_TQunsvQT.B.min,
                   Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_TQunsvQT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_TQunsvQT.B.min,
                   Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_ddPQ14unsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_TQunsvQT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_TQunsvQT.B.min)
    Upper_high = c(Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_TQunsvQT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_TQunsvQT.B.max,
                   Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_TQunsvQT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_TQunsvQT.B.max,
                   Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_ddPQ14unsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_TQunsvQT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_TQunsvQT.B.max)
    Test_high = c("Supervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + Quantitative Test",
                  "Unsupervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test","Supervised + Quantitative Test","Unsupervised + Quantitative Test")
    Strategy_high = c("sdPQ7+sdPQ7","sdPQ7+sdPQ7","sdPQ7+ddPQ14","sdPQ7+ddPQ14","sdPQ7+TQ","sdPQ7+TQ","ddPQ14+sdPQ7","ddPQ14+sdPQ7","ddPQ14+ddPQ14","ddPQ14+ddPQ14","ddPQ14+TQ","ddPQ14+TQ","TQ+sdPQ7","TQ+sdPQ7","TQ+ddPQ14","TQ+ddPQ14","TQ+TQ","TQ+TQ")
    Name_high = c("sdPQ7","sdPQ7","sdPQ7","ddPQ14","sdPQ7","TQ","ddPQ14","sdPQ7","ddPQ14","ddPQ14","ddPQ14","TQ","TQ","sdPQ7","TQ","ddPQ14","TQ","TQ")
    
    results <- list(Mid_high = Mid_high,
                    Lower_high = Lower_high,
                    Upper_high = Upper_high,
                    Test_high = Test_high,
                    Strategy_high = Strategy_high,
                    Name_high = Name_high)
    
  })# Close model21
  
  ## Model22: High svQT vs. svNT -----
  model22 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * A     
    Num.Recur_sdPQ7svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * A
    
    Num.Recur_sdPQ7svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * B      
    Num.Recur_sdPQ7svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * B
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * A    
    Num.Recur_ddPQ14svQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * A
    
    Num.Recur_ddPQ14svQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * B    
    Num.Recur_ddPQ14svQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * B
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A
    
    Num.Recur_TQsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.A.min <- P3.1 * P3.10 * Num * A
    Num.Recur_sdPQ7svNT.A.max <- P3.1 * P3.10 * Num * A
    
    Num.Recur_sdPQ7svNT.B.min <- P3.1 * P3.10 * Num * B
    Num.Recur_sdPQ7svNT.B.max <- P3.1 * P3.10 * Num * B
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.A.min <- P3.2 * P3.10 * Num * A
    Num.Recur_sdPQ14svNT.A.max <- P3.2 * P3.10 * Num * A
    
    Num.Recur_sdPQ14svNT.B.min <- P3.2 * P3.10 * Num * B
    Num.Recur_sdPQ14svNT.B.max <- P3.2 * P3.10 * Num * B
    
    # weekly PQ supervised no test
    Num.Recur_wkPQsvNT.A.min <- P3.5 * P3.10 * Num * A
    Num.Recur_wkPQsvNT.A.max <- P3.5 * P3.10 * Num * A
    
    Num.Recur_wkPQsvNT.B.min <- P3.5 * P3.10 * Num * B
    Num.Recur_wkPQsvNT.B.max <- P3.5 * P3.10 * Num * B
    
    Mid_high = c(mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ7svQT.A.min,Num.Recur_sdPQ7svQT.A.max)),mean(c(Num.Recur_wkPQsvNT.B.min,Num.Recur_wkPQsvNT.B.max)),
                 mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14svQT.A.min,Num.Recur_ddPQ14svQT.A.max)),mean(c(Num.Recur_wkPQsvNT.B.min,Num.Recur_wkPQsvNT.B.max)),
                 mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_TQsvQT.A.min,Num.Recur_TQsvQT.A.max)),mean(c(Num.Recur_wkPQsvNT.B.min,Num.Recur_wkPQsvNT.B.max)))
    Lower_high = c(Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_wkPQsvNT.B.min,Num.Recur_sdPQ7svQT.A.min+Num.Recur_wkPQsvNT.B.min,
                   Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_wkPQsvNT.B.min,Num.Recur_ddPQ14svQT.A.min+Num.Recur_wkPQsvNT.B.min,
                   Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_wkPQsvNT.B.min,Num.Recur_TQsvQT.A.min+Num.Recur_wkPQsvNT.B.min)
    Upper_high = c(Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_wkPQsvNT.B.max,Num.Recur_sdPQ7svQT.A.max+Num.Recur_wkPQsvNT.B.max,
                   Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_wkPQsvNT.B.max,Num.Recur_ddPQ14svQT.A.max+Num.Recur_wkPQsvNT.B.max,
                   Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_wkPQsvNT.B.max,Num.Recur_TQsvQT.A.max+Num.Recur_wkPQsvNT.B.max)
    Test_high = c("Supervised + Quantitative Test","Supervised + No Test","Supervised + Quantitative Test","Supervised + No Test","Supervised + Quantitative Test","Supervised + No Test","Supervised + Quantitative Test","Supervised + No Test","Supervised + Quantitative Test",
                  "Supervised + No Test","Supervised + Quantitative Test","Supervised + No Test","Supervised + Quantitative Test","Supervised + No Test","Supervised + Quantitative Test","Supervised + No Test","Supervised + Quantitative Test","Supervised + No Test")
    Strategy_high = c("sdPQ7+sdPQ7","sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ7+PQ8wks","sdPQ7+PQ8wks","ddPQ14+sdPQ7","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+sdPQ14","ddPQ14+PQ8wks","ddPQ14+PQ8wks","TQ+sdPQ7","TQ+sdPQ7","TQ+sdPQ14","TQ+sdPQ14","TQ+PQ8wks","TQ+PQ8wks")
    Name_high = c("sdPQ7","sdPQ7","sdPQ7","sdPQ14","sdPQ7","PQ8wks","ddPQ14","sdPQ7","ddPQ14","sdPQ14","ddPQ14","PQ8wks","TQ","sdPQ7","TQ","sdPQ14","TQ","PQ8wks")
    
    results <- list(Mid_high = Mid_high,
                    Lower_high = Lower_high,
                    Upper_high = Upper_high,
                    Test_high = Test_high,
                    Strategy_high = Strategy_high,
                    Name_high = Name_high)
    
  })# Close model22
  
  ## Model23: High svQT vs. unsvNT -----
  model23 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised quantitative test
    Num.Recur_sdPQ7svQT.A.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * A     
    Num.Recur_sdPQ7svQT.A.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * A
    
    Num.Recur_sdPQ7svQT.B.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.1) * P3.10 * Num * B      
    Num.Recur_sdPQ7svQT.B.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.1) * P3.10 * Num * B
    
    # double dose PQ14 supervised quantitative test
    Num.Recur_ddPQ14svQT.A.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * A    
    Num.Recur_ddPQ14svQT.A.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * A
    
    Num.Recur_ddPQ14svQT.B.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.3 * P3.11) * Num * B    
    Num.Recur_ddPQ14svQT.B.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.3 * P3.11) * Num * B
    
    # TQ supervised quantitative test
    Num.Recur_TQsvQT.A.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A  
    Num.Recur_TQsvQT.A.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A
    
    Num.Recur_TQsvQT.B.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.5 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.1 * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQsvQT.B.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.5 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.1 * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.A.min.high <- P3.7.min * P3.10 * Num * A
    Num.Recur_sdPQ14unsvNT.A.max.high <- P3.7.max * P3.10 * Num * A
    
    Num.Recur_sdPQ14unsvNT.B.min.high <- P3.7.min * P3.10 * Num * B
    Num.Recur_sdPQ14unsvNT.B.max.high <- P3.7.max * P3.10 * Num * B
    
    # weekly PQ unsupervised no test
    Num.Recur_wkPQunsvNT.A.min.high <- P3.9 * P3.10 * Num * A
    Num.Recur_wkPQunsvNT.A.max.high <- P3.9 * P3.10 * Num * A
    
    Num.Recur_wkPQunsvNT.B.min.high <- P3.9 * P3.10 * Num * B
    Num.Recur_wkPQunsvNT.B.max.high <- P3.9 * P3.10 * Num * B
    
    Mid_high = c(mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_sdPQ7svQT.A.min.high,Num.Recur_sdPQ7svQT.A.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),
                 mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_ddPQ14svQT.A.min.high,Num.Recur_ddPQ14svQT.A.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),
                 mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_TQsvQT.A.min.high,Num.Recur_TQsvQT.A.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)))
    Lower_high = c(Num.Recur_sdPQ7svQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ7svQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ7svQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ7svQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,
                   Num.Recur_ddPQ14svQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_ddPQ14svQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_ddPQ14svQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_ddPQ14svQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,
                   Num.Recur_TQsvQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_TQsvQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_TQsvQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_TQsvQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high)
    Upper_high = c(Num.Recur_sdPQ7svQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_sdPQ7svQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_sdPQ7svQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ7svQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,
                   Num.Recur_ddPQ14svQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_ddPQ14svQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_ddPQ14svQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_ddPQ14svQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,
                   Num.Recur_TQsvQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_TQsvQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_TQsvQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_TQsvQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high)
    Test_high = c("Supervised + Quantitative Test","Unsupervised + No Test","Supervised + Quantitative Test","Unsupervised + No Test","Supervised + Quantitative Test","Unsupervised + No Test","Supervised + Quantitative Test","Unsupervised + No Test","Supervised + Quantitative Test","Unsupervised + No Test","Supervised + Quantitative Test","Unsupervised + No Test")
    Strategy_high = c("sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ7+PQ8wks","sdPQ7+PQ8wks","ddPQ14+sdPQ14","ddPQ14+sdPQ14","ddPQ14+PQ8wks","ddPQ14+PQ8wks","TQ+sdPQ14","TQ+sdPQ14","TQ+PQ8wks","TQ+PQ8wks")
    Name_high = c("sdPQ7","sdPQ14","sdPQ7","PQ8wks","ddPQ14","sdPQ14","ddPQ14","PQ8wks","TQ","sdPQ14","TQ","PQ8wks")
    
    results <- list(Mid_high = Mid_high,
                    Lower_high = Lower_high,
                    Upper_high = Upper_high,
                    Test_high = Test_high,
                    Strategy_high = Strategy_high,
                    Name_high = Name_high)
    
  })# Close model23
  
  ## Model24: High unsvQT vs. svNT -----
  model24 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * A    
    Num.Recur_sdPQ7unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * A
    
    Num.Recur_sdPQ7unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * B    
    Num.Recur_sdPQ7unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * B
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * A    
    Num.Recur_ddPQ14unsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * A
    
    Num.Recur_ddPQ14unsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * B    
    Num.Recur_ddPQ14unsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * B
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.A.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A 
    Num.Recur_TQunsvQT.A.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQunsvQT.B.min <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQunsvQT.B.max <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B 
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.A.min <- P3.1 * P3.10 * Num * A
    Num.Recur_sdPQ7svNT.A.max <- P3.1 * P3.10 * Num * A
    
    Num.Recur_sdPQ7svNT.B.min <- P3.1 * P3.10 * Num * B
    Num.Recur_sdPQ7svNT.B.max <- P3.1 * P3.10 * Num * B
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.A.min <- P3.2 * P3.10 * Num * A
    Num.Recur_sdPQ14svNT.A.max <- P3.2 * P3.10 * Num * A
    
    Num.Recur_sdPQ14svNT.B.min <- P3.2 * P3.10 * Num * B
    Num.Recur_sdPQ14svNT.B.max <- P3.2 * P3.10 * Num * B
    
    # weekly PQ supervised no test
    Num.Recur_wkPQsvNT.A.min <- P3.5 * P3.10 * Num * A
    Num.Recur_wkPQsvNT.A.max <- P3.5 * P3.10 * Num * A
    
    Num.Recur_wkPQsvNT.B.min <- P3.5 * P3.10 * Num * B
    Num.Recur_wkPQsvNT.B.max <- P3.5 * P3.10 * Num * B
    
    Mid_high = c(mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_sdPQ7unsvQT.A.min,Num.Recur_sdPQ7unsvQT.A.max)),mean(c(Num.Recur_wkPQsvNT.B.min,Num.Recur_wkPQsvNT.B.max)),
                 mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_ddPQ14unsvQT.A.min,Num.Recur_ddPQ14unsvQT.A.max)),mean(c(Num.Recur_wkPQsvNT.B.min,Num.Recur_wkPQsvNT.B.max)),
                 mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7svNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ14svNT.B.max)),mean(c(Num.Recur_TQunsvQT.A.min,Num.Recur_TQunsvQT.A.max)),mean(c(Num.Recur_wkPQsvNT.B.min,Num.Recur_wkPQsvNT.B.max)))
    Lower_high = c(Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_wkPQsvNT.B.min,Num.Recur_sdPQ7unsvQT.A.min+Num.Recur_wkPQsvNT.B.min,
                   Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_wkPQsvNT.B.min,Num.Recur_ddPQ14unsvQT.A.min+Num.Recur_wkPQsvNT.B.min,
                   Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ7svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_sdPQ14svNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_wkPQsvNT.B.min,Num.Recur_TQunsvQT.A.min+Num.Recur_wkPQsvNT.B.min)
    Upper_high = c(Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_wkPQsvNT.B.max,Num.Recur_sdPQ7unsvQT.A.max+Num.Recur_wkPQsvNT.B.max,
                   Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_wkPQsvNT.B.max,Num.Recur_ddPQ14unsvQT.A.max+Num.Recur_wkPQsvNT.B.max,
                   Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ7svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_sdPQ14svNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_wkPQsvNT.B.max,Num.Recur_TQunsvQT.A.max+Num.Recur_wkPQsvNT.B.max)
    Test_high = c("Unsupervised + Quantitative Test","Supervised + No Test","Unsupervised + Quantitative Test","Supervised + No Test","Unsupervised + Quantitative Test","Supervised + No Test","Unsupervised + Quantitative Test","Supervised + No Test","Unsupervised + Quantitative Test",
                  "Supervised + No Test","Unsupervised + Quantitative Test","Supervised + No Test","Unsupervised + Quantitative Test","Supervised + No Test","Unsupervised + Quantitative Test","Supervised + No Test","Unsupervised + Quantitative Test","Supervised + No Test")
    Strategy_high = c("sdPQ7+sdPQ7","sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ7+PQ8wks","sdPQ7+PQ8wks","ddPQ14+sdPQ7","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+sdPQ14","ddPQ14+PQ8wks","ddPQ14+PQ8wks","TQ+sdPQ7","TQ+sdPQ7","TQ+sdPQ14","TQ+sdPQ14","TQ+PQ8wks","TQ+PQ8wks")
    Name_high = c("sdPQ7","sdPQ7","sdPQ7","sdPQ14","sdPQ7","PQ8wks","ddPQ14","sdPQ7","ddPQ14","sdPQ14","ddPQ14","PQ8wks","TQ","sdPQ7","TQ","sdPQ14","TQ","PQ8wks")
    
    results <- list(Mid_high = Mid_high,
                    Lower_high = Lower_high,
                    Upper_high = Upper_high,
                    Test_high = Test_high,
                    Strategy_high = Strategy_high,
                    Name_high = Name_high)
    
  })# Close model24
  
  ## Model25: High unsvQT vs. unsvNT -----
  model25 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 unsupervised quantitative test
    Num.Recur_sdPQ7unsvQT.A.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * A    
    Num.Recur_sdPQ7unsvQT.A.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * A
    
    Num.Recur_sdPQ7unsvQT.B.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.6.min) * P3.10 * Num * B    
    Num.Recur_sdPQ7unsvQT.B.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.6.max) * P3.10 * Num * B
    
    # double dose PQ14 unsupervised quantitative test
    Num.Recur_ddPQ14unsvQT.A.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * A    
    Num.Recur_ddPQ14unsvQT.A.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * A
    
    Num.Recur_ddPQ14unsvQT.B.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + (1 - P2.1.min*P1.2.min*2/21 - P2.1.min*P1.1.min*4/7) * P3.8.min * P3.11) * Num * B    
    Num.Recur_ddPQ14unsvQT.B.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + (1 - P2.1.max*P1.2.max*2/21 - P2.1.max*P1.1.max*4/7) * P3.8.max * P3.11) * Num * B
    
    # TQ unsupervised quantitative test
    Num.Recur_TQunsvQT.A.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * A 
    Num.Recur_TQunsvQT.A.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * A 
    
    Num.Recur_TQunsvQT.B.min.high <- ((P2.1.min*P1.2.min*2/21 + P2.1.min*P1.1.min*4/7) * P3.9 * P3.10 + P2.1.min*P1.2.min*19/21 * P3.6.min * P3.10 + (1 - P2.1.min*P1.2.min - P2.1.min*P1.1.min*4/7) * P3.4 * P3.12) * Num * B  
    Num.Recur_TQunsvQT.B.max.high <- ((P2.1.max*P1.2.max*2/21 + P2.1.max*P1.1.max*4/7) * P3.9 * P3.10 + P2.1.max*P1.2.max*19/21 * P3.6.max * P3.10 + (1 - P2.1.max*P1.2.max - P2.1.max*P1.1.max*4/7) * P3.4 * P3.12) * Num * B 
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.A.min.high <- P3.7.min * P3.10 * Num * A
    Num.Recur_sdPQ14unsvNT.A.max.high <- P3.7.max * P3.10 * Num * A
    
    Num.Recur_sdPQ14unsvNT.B.min.high <- P3.7.min * P3.10 * Num * B
    Num.Recur_sdPQ14unsvNT.B.max.high <- P3.7.max * P3.10 * Num * B
    
    # weekly PQ unsupervised no test
    Num.Recur_wkPQunsvNT.A.min.high <- P3.9 * P3.10 * Num * A
    Num.Recur_wkPQunsvNT.A.max.high <- P3.9 * P3.10 * Num * A
    
    Num.Recur_wkPQunsvNT.B.min.high <- P3.9 * P3.10 * Num * B
    Num.Recur_wkPQunsvNT.B.max.high <- P3.9 * P3.10 * Num * B
    
    Mid_high = c(mean(c(Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_sdPQ7unsvQT.A.min.high,Num.Recur_sdPQ7unsvQT.A.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),
                 mean(c(Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_ddPQ14unsvQT.A.min.high,Num.Recur_ddPQ14unsvQT.A.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),
                 mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_TQunsvQT.A.min.high,Num.Recur_TQunsvQT.A.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)))
    Lower_high = c(Num.Recur_sdPQ7unsvQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ7unsvQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ7unsvQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ7unsvQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,
                   Num.Recur_ddPQ14unsvQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_ddPQ14unsvQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_ddPQ14unsvQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_ddPQ14unsvQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,
                   Num.Recur_TQunsvQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_TQunsvQT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_TQunsvQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_TQunsvQT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high)
    Upper_high = c(Num.Recur_sdPQ7unsvQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_sdPQ7unsvQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_sdPQ7unsvQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ7unsvQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,
                   Num.Recur_ddPQ14unsvQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_ddPQ14unsvQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_ddPQ14unsvQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_ddPQ14unsvQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,
                   Num.Recur_TQunsvQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_TQunsvQT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_TQunsvQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_TQunsvQT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high)
    Test_high = c("Unsupervised + Quantitative Test","Unsupervised + No Test","Unsupervised + Quantitative Test","Unsupervised + No Test","Unsupervised + Quantitative Test","Unsupervised + No Test","Unsupervised + Quantitative Test","Unsupervised + No Test","Unsupervised + Quantitative Test","Unsupervised + No Test","Unsupervised + Quantitative Test","Unsupervised + No Test")
    Strategy_high = c("sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ7+PQ8wks","sdPQ7+PQ8wks","ddPQ14+sdPQ14","ddPQ14+sdPQ14","ddPQ14+PQ8wks","ddPQ14+PQ8wks","TQ+sdPQ14","TQ+sdPQ14","TQ+PQ8wks","TQ+PQ8wks")
    Name_high = c("sdPQ7","sdPQ14","sdPQ7","PQ8wks","ddPQ14","sdPQ14","ddPQ14","PQ8wks","TQ","sdPQ14","TQ","PQ8wks")
    
    results <- list(Mid_high = Mid_high,
                    Lower_high = Lower_high,
                    Upper_high = Upper_high,
                    Test_high = Test_high,
                    Strategy_high = Strategy_high,
                    Name_high = Name_high)
    
  })# Close model25
  
  ## Model26: High svNT vs. unsvNT -----
  model26 <- reactive({
    
    # General parameters
    
    ## General
    country = input$country
    Num = input$Num
    
    ## epidemiology
    P1.1.min = input$P1.1.min/100
    P1.1.max = input$P1.1.max/100
    P1.2.min = 1-input$P1.1.max/100
    P1.2.max = 1-input$P1.1.min/100
    P2.1.min = input$P2.1.min/100
    P2.1.max = input$P2.1.max/100
    Risk = input$Risk
    Treatment = input$Treatment
    A <- input$A/100
    B <- 1-input$A/100
    Treatment.A = input$Treatment.A
    Treatment.B = input$Treatment.B
    
    ## Recurrence
    P3.1 = input$P3.1/100
    P3.2 = input$P3.2/100
    P3.3 = input$P3.3/100
    P3.4 = input$P3.4/100
    P3.5 = input$P3.5/100
    P3.6.min = input$P3.6.min/100
    P3.6.max = input$P3.6.max/100
    P3.7.min = input$P3.7.min/100
    P3.7.max = input$P3.7.max/100
    P3.8.min = input$P3.8.min/100
    P3.8.max = input$P3.8.max/100
    P3.9 = input$P3.9/100
    P3.10 = input$P3.10
    P3.11 = input$P3.11
    P3.12 = input$P3.12
    
    # standard dose PQ7 supervised no test
    Num.Recur_sdPQ7svNT.A.min.high <- P3.1 * P3.10 * Num * A
    Num.Recur_sdPQ7svNT.A.max.high <- P3.1 * P3.10 * Num * A
    
    Num.Recur_sdPQ7svNT.B.min.high <- P3.1 * P3.10 * Num * B
    Num.Recur_sdPQ7svNT.B.max.high <- P3.1 * P3.10 * Num * B
    
    # standard dose PQ14 supervised no test
    Num.Recur_sdPQ14svNT.A.min.high <- P3.2 * P3.10 * Num * A
    Num.Recur_sdPQ14svNT.A.max.high <- P3.2 * P3.10 * Num * A
    
    Num.Recur_sdPQ14svNT.B.min.high <- P3.2 * P3.10 * Num * B
    Num.Recur_sdPQ14svNT.B.max.high <- P3.2 * P3.10 * Num * B
    
    # weekly PQ supervised no test
    Num.Recur_wkPQsvNT.A.min.high <- P3.5 * P3.10 * Num * A
    Num.Recur_wkPQsvNT.A.max.high <- P3.5 * P3.10 * Num * A
    
    Num.Recur_wkPQsvNT.B.min.high <- P3.5 * P3.10 * Num * B
    Num.Recur_wkPQsvNT.B.max.high <- P3.5 * P3.10 * Num * B
    
    # standard dose PQ14 unsupervised no test
    Num.Recur_sdPQ14unsvNT.A.min.high <- P3.7.min * P3.10 * Num * A
    Num.Recur_sdPQ14unsvNT.A.max.high <- P3.7.max * P3.10 * Num * A
    
    Num.Recur_sdPQ14unsvNT.B.min.high <- P3.7.min * P3.10 * Num * B
    Num.Recur_sdPQ14unsvNT.B.max.high <- P3.7.max * P3.10 * Num * B
    
    # weekly PQ unsupervised no test
    Num.Recur_wkPQunsvNT.A.min.high <- P3.9 * P3.10 * Num * A
    Num.Recur_wkPQunsvNT.A.max.high <- P3.9 * P3.10 * Num * A
    
    Num.Recur_wkPQunsvNT.B.min.high <- P3.9 * P3.10 * Num * B
    Num.Recur_wkPQunsvNT.B.max.high <- P3.9 * P3.10 * Num * B
    
    Mid_high = c(mean(c(Num.Recur_sdPQ7svNT.A.min.high,Num.Recur_sdPQ7svNT.A.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_sdPQ7svNT.A.min.high,Num.Recur_sdPQ7svNT.A.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),
                 mean(c(Num.Recur_sdPQ14svNT.A.min.high,Num.Recur_sdPQ14svNT.A.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_sdPQ14svNT.A.min.high,Num.Recur_sdPQ14svNT.A.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)),
                 mean(c(Num.Recur_wkPQsvNT.A.min.high,Num.Recur_wkPQsvNT.A.max.high)),mean(c(Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14unsvNT.B.max.high)),mean(c(Num.Recur_wkPQsvNT.A.min.high,Num.Recur_wkPQsvNT.A.max.high)),mean(c(Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQunsvNT.B.max.high)))
    Lower_high = c(Num.Recur_sdPQ7svNT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ7svNT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ7svNT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ7svNT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,
                   Num.Recur_sdPQ14svNT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14svNT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_sdPQ14svNT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_sdPQ14svNT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,
                   Num.Recur_wkPQsvNT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_wkPQsvNT.A.min.high+Num.Recur_sdPQ14unsvNT.B.min.high,Num.Recur_wkPQsvNT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high,Num.Recur_wkPQsvNT.A.min.high+Num.Recur_wkPQunsvNT.B.min.high)
    Upper_high = c(Num.Recur_sdPQ7svNT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_sdPQ7svNT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_sdPQ7svNT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ7svNT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,
                   Num.Recur_sdPQ14svNT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_sdPQ14svNT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_sdPQ14svNT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_sdPQ14svNT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,
                   Num.Recur_wkPQsvNT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_wkPQsvNT.A.max.high+Num.Recur_sdPQ14unsvNT.B.max.high,Num.Recur_wkPQsvNT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high,Num.Recur_wkPQsvNT.A.max.high+Num.Recur_wkPQunsvNT.B.max.high)
    Test_high = c("Supervised + No Test","Unsupervised + No Test","Supervised + No Test","Unsupervised + No Test","Supervised + No Test","Unsupervised + No Test","Supervised + No Test","Unsupervised + No Test","Supervised + No Test","Unsupervised + No Test","Supervised + No Test","Unsupervised + No Test")
    Strategy_high = c("sdPQ7+sdPQ14","sdPQ7+sdPQ14","sdPQ7+PQ8wks","sdPQ7+PQ8wks","sdPQ14+sdPQ14","sdPQ14+sdPQ14","sdPQ14+PQ8wks","sdPQ14+PQ8wks","PQ8wks+sdPQ14","PQ8wks+sdPQ14","PQ8wks+PQ8wks","PQ8wks+PQ8wks")
    Name_high = c("sdPQ7","sdPQ14","sdPQ7","PQ8wks","sdPQ14","sdPQ14","sdPQ14","PQ8wks","PQ8wks","sdPQ14","PQ8wks","PQ8wks")
    
    results <- list(Mid_high = Mid_high,
                    Lower_high = Lower_high,
                    Upper_high = Upper_high,
                    Test_high = Test_high,
                    Strategy_high = Strategy_high,
                    Name_high = Name_high)
    
  })# Close model26

  
  #### Get inputs list ----
  data <- reactive({reactiveValuesToList(input)})
  observeEvent(input$Submit,{saveData(data())})
  
  #### Table_1scenario ----

  # Show filtered data in the datatable
  output$table_1scenario <- renderDataTable(expr = data.frame(model1()$TT) %>% rename("Delivery Strategy" = Treatment),options = list(searching = FALSE,pageLength = 15,autoWidth = TRUE))

  #### Table_2scenarios ----
  output$table_2scenarios <- renderDataTable(expr = (data.frame(model2()$BT)),options = list(searching = FALSE,pageLength = 25,scrollX = T,scrollY = "500px",autoWidth = TRUE,columnDefs = list(list(width = "200px",targets = c(2,7)))))
  
  #### Recur Plot (1scenario) ----
      output$plot_1scenario <- renderPlot({ 
        if (input$Risk == "Low" & input$Treatment == "All") {
          data_lowsvQT <- data.frame(list(model3()$data_lowsvQT))
          data_lowsvQT$Strategy_lowsvQT <- factor(data_lowsvQT$Strategy_lowsvQT,levels = c("sdPQ7","ddPQ14","TQ"))
          data_lowsvQT <- data_lowsvQT %>% mutate(Mid_lowsvQT = as.numeric(Mid_lowsvQT),Lower_lowsvQT = as.numeric(Lower_lowsvQT),Upper_lowsvQT = as.numeric(Upper_lowsvQT))
          p1 <-ggplot(data_lowsvQT,aes(Strategy_lowsvQT,Mid_lowsvQT,fill = Strategy_lowsvQT)) +
            geom_bar(stat = "identity",position=position_dodge(width = 0.5,preserve = "single"),width = 0.5,color = "black") +
            scale_fill_manual(values = c("#A7C6ED","#FFFFFF","#BA0C2F")) +
            geom_errorbar(aes(ymax=Upper_lowsvQT,ymin=Lower_lowsvQT),width=0.1) +
            theme_bw() +
            theme(legend.position = "top",legend.title = element_blank()) +
            theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                  axis.text = element_text(size = 10),legend.text = element_text(size = 12)) +
            scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
            xlab("Quantitative Test with Supervision") + ylab("Recurrence (#)") + 
            theme(axis.title = element_text(size = 13,colour = "black",face = "bold"))
          
          data_lowunsvQT <- data.frame(list(model3()$data_lowunsvQT))
          data_lowunsvQT$Strategy_lowunsvQT <- factor(data_lowunsvQT$Strategy_lowunsvQT,levels = c("sdPQ7","ddPQ14","TQ"))
          data_lowunsvQT <- data_lowunsvQT %>% mutate(Mid_lowunsvQT = as.numeric(Mid_lowunsvQT),Lower_lowunsvQT = as.numeric(Lower_lowunsvQT),Upper_lowunsvQT = as.numeric(Upper_lowunsvQT))
          p2 <- ggplot(data_lowunsvQT,aes(Strategy_lowunsvQT,Mid_lowunsvQT,fill = Strategy_lowunsvQT)) +
            geom_bar(stat = "identity",position=position_dodge(width = 0.5,preserve = "single"),width = 0.5,color = "black") +
            scale_fill_manual(values = c("#A7C6ED","#FFFFFF","#BA0C2F")) +
            geom_errorbar(aes(ymax=Upper_lowunsvQT,ymin=Lower_lowunsvQT),width=0.1) +
            theme_bw() +
            theme(legend.position = "top",legend.title = element_blank()) +
            theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                  axis.text = element_text(size = 10),legend.text = element_text(size = 12)) +
            scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
            xlab("Quantitative Test without Supervision") + ylab("Recurrence (#)") + 
            theme(axis.title = element_text(size = 13,colour = "black",face = "bold"))
          
          data_lowsvNT <- data.frame(list(model3()$data_lowsvNT))
          data_lowsvNT$Strategy_lowsvNT <- factor(data_lowsvNT$Strategy_lowsvNT,levels = c("sdPQ7","sdPQ14","ddPQ14"))
          data_lowsvNT <- data_lowsvNT %>% mutate(Mid_lowsvNT = as.numeric(Mid_lowsvNT),Lower_lowsvNT = as.numeric(Lower_lowsvNT),Upper_lowsvNT = as.numeric(Upper_lowsvNT))
          p3 <- ggplot(data_lowsvNT,aes(Strategy_lowsvNT,Mid_lowsvNT,fill = Strategy_lowsvNT)) +
            geom_bar(stat = "identity",position=position_dodge(width = 0.5,preserve = "single"),width = 0.5,color = "black") +
            scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF")) +
            geom_errorbar(aes(ymax=Upper_lowsvNT,ymin=Lower_lowsvNT),width=0.1) +
            theme_bw() +
            theme(legend.position = "top",legend.title = element_blank()) +
            theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                  axis.text = element_text(size = 10),legend.text = element_text(size = 12)) +
            scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
            xlab("No Test with Supervision") + ylab("Recurrence (#)") + 
            theme(axis.title = element_text(size = 13,colour = "black",face = "bold"))
          
          data_lowunsvNT <- data.frame(list(model3()$data_lowunsvNT))
          data_lowunsvNT$Strategy_lowunsvNT <- factor(data_lowunsvNT$Strategy_lowunsvNT,levels = c("sdPQ14"))
          data_lowunsvNT <- data_lowunsvNT %>% mutate(Mid_lowunsvNT = as.numeric(Mid_lowunsvNT),Lower_lowunsvNT = as.numeric(Lower_lowunsvNT),Upper_lowunsvNT = as.numeric(Upper_lowunsvNT))
          p4 <- ggplot(data_lowunsvNT,aes(Strategy_lowunsvNT,Mid_lowunsvNT,fill = Strategy_lowunsvNT)) +
            geom_bar(stat = "identity",position=position_dodge(width = 0.2,preserve = "single"),width = 0.2,color = "black") +
            scale_fill_manual(values = c("#0067B9")) +
            geom_errorbar(aes(ymax=Upper_lowunsvNT,ymin=Lower_lowunsvNT),width=0.05) +
            theme_bw() +
            theme(legend.position = "top",legend.title = element_blank()) +
            theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                  axis.text = element_text(size = 10),legend.text = element_text(size = 12)) +
            scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
            xlab("No Test without Supervision") + ylab("Recurrence (#)") + 
            theme(axis.title = element_text(size = 13,colour = "black",face = "bold")) 
          
          ggdraw() +
            draw_plot(p1,0,0.51,0.49,0.49) +
            draw_plot(p2,0.51,0.51,0.49,0.49) +
            draw_plot(p3,0,0,0.49,0.49) +
            draw_plot(p4,0.51,0,0.49,0.49)
        } else
          if (input$Risk == "Low" & input$Treatment == "Supervised + Quantitative Test") {
          lowsvQT <- list(model4())
          data_lowsvQT <- data.frame(lowsvQT)
          data_lowsvQT$Strategy_lowsvQT <- factor(data_lowsvQT$Strategy_lowsvQT,levels = c("sdPQ7","ddPQ14","TQ"))
          data_lowsvQT <- data_lowsvQT %>% mutate(Mid_lowsvQT = as.numeric(Mid_lowsvQT),Lower_lowsvQT = as.numeric(Lower_lowsvQT),Upper_lowsvQT = as.numeric(Upper_lowsvQT))
          ggplot(data_lowsvQT,aes(Strategy_lowsvQT,Mid_lowsvQT,fill = Strategy_lowsvQT)) +
            geom_bar(stat = "identity",position=position_dodge(width = 0.5,preserve = "single"),width = 0.5,color = "black") +
            scale_fill_manual(values = c("#A7C6ED","#FFFFFF","#BA0C2F")) +
            geom_errorbar(aes(ymax=Upper_lowsvQT,ymin=Lower_lowsvQT),width=0.1) +
            theme_bw() +
            theme(legend.position = "top",legend.title = element_blank()) +
            theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                  axis.text = element_text(size = 18),legend.text = element_text(size = 15)) +
            scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
            xlab("Quantitative Test with Supervision") + ylab("Recurrence (#)") + 
            theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
          } else
            if (input$Risk == "Low" & input$Treatment == "Unsupervised + Quantitative Test") {
              lowunsvQT <- list(model5())
              data_lowunsvQT <- data.frame(lowunsvQT)
              data_lowunsvQT$Strategy_lowunsvQT <- factor(data_lowunsvQT$Strategy_lowunsvQT,levels = c("sdPQ7","ddPQ14","TQ"))
              data_lowunsvQT <- data_lowunsvQT %>% mutate(Mid_lowunsvQT = as.numeric(Mid_lowunsvQT),Lower_lowunsvQT = as.numeric(Lower_lowunsvQT),Upper_lowunsvQT = as.numeric(Upper_lowunsvQT))
              ggplot(data_lowunsvQT,aes(Strategy_lowunsvQT,Mid_lowunsvQT,fill = Strategy_lowunsvQT)) +
                geom_bar(stat = "identity",position=position_dodge(width = 0.5,preserve = "single"),width = 0.5,color = "black") +
                scale_fill_manual(values = c("#A7C6ED","#FFFFFF","#BA0C2F")) +
                geom_errorbar(aes(ymax=Upper_lowunsvQT,ymin=Lower_lowunsvQT),width=0.1) +
                theme_bw() +
                theme(legend.position = "top",legend.title = element_blank()) +
                theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                      axis.text = element_text(size = 18),legend.text = element_text(size = 15)) +
                scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
                xlab("Quantitative Test without Supervision") + ylab("Recurrence (#)") + 
                theme(axis.title = element_text(size = 18,colour = "black",face = "bold"))
              } else
                if (input$Risk == "Low" & input$Treatment == "Supervised + No Test") {
                  lowsvNT <- list(model6())
                  data_lowsvNT <- data.frame(lowsvNT)
                  data_lowsvNT$Strategy_lowsvNT <- factor(data_lowsvNT$Strategy_lowsvNT,levels = c("sdPQ7","sdPQ14","ddPQ14"))
                  data_lowsvNT <- data_lowsvNT %>% mutate(Mid_lowsvNT = as.numeric(Mid_lowsvNT),Lower_lowsvNT = as.numeric(Lower_lowsvNT),Upper_lowsvNT = as.numeric(Upper_lowsvNT))
                  ggplot(data_lowsvNT,aes(Strategy_lowsvNT,Mid_lowsvNT,fill = Strategy_lowsvNT)) +
                    geom_bar(stat = "identity",position=position_dodge(width = 0.5,preserve = "single"),width = 0.5,color = "black") +
                    scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF")) +
                    geom_errorbar(aes(ymax=Upper_lowsvNT,ymin=Lower_lowsvNT),width=0.1) +
                    theme_bw() +
                    theme(legend.position = "top",legend.title = element_blank()) +
                    theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                          axis.text = element_text(size = 18),legend.text = element_text(size = 15)) +
                    scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
                    xlab("No Test with Supervision") + ylab("Recurrence (#)") + 
                    theme(axis.title = element_text(size = 18,colour = "black",face = "bold"))
                  } else
                    if (input$Risk == "Low" & input$Treatment == "Unsupervised + No Test") {
                      lowunsvNT <- list(model7())
                      data_lowunsvNT <- data.frame(lowunsvNT)
                      data_lowunsvNT$Strategy_lowunsvNT <- factor(data_lowunsvNT$Strategy_lowunsvNT,levels = c("sdPQ14"))
                      data_lowunsvNT <- data_lowunsvNT %>% mutate(Mid_lowunsvNT = as.numeric(Mid_lowunsvNT),Lower_lowunsvNT = as.numeric(Lower_lowunsvNT),Upper_lowunsvNT = as.numeric(Upper_lowunsvNT))
                      ggplot(data_lowunsvNT,aes(Strategy_lowunsvNT,Mid_lowunsvNT,fill = Strategy_lowunsvNT)) +
                        geom_bar(stat = "identity",position=position_dodge(width = 0.2,preserve = "single"),width = 0.2,color = "black") +
                        scale_fill_manual(values = c("#0067B9")) +
                        geom_errorbar(aes(ymax=Upper_lowunsvNT,ymin=Lower_lowunsvNT),width=0.05) +
                        theme_bw() +
                        theme(legend.position = "top",legend.title = element_blank()) +
                        theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                              axis.text = element_text(size = 18),legend.text = element_text(size = 15)) +
                        scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
                        xlab("No Test without Supervision") + ylab("Recurrence (#)") + 
                        theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
                    } else
                      if (input$Risk == "High" & input$Treatment == "All") {
                        data_highsvQT <- data.frame(list(model8()$data_highsvQT))
                        data_highsvQT$Strategy_highsvQT <- factor(data_highsvQT$Strategy_highsvQT,levels = c("sdPQ7","ddPQ14","TQ"))
                        data_highsvQT <- data_highsvQT %>% mutate(Mid_highsvQT = as.numeric(Mid_highsvQT),Lower_highsvQT = as.numeric(Lower_highsvQT),Upper_highsvQT = as.numeric(Upper_highsvQT))
                        p5 <- ggplot(data_highsvQT,aes(Strategy_highsvQT,Mid_highsvQT,fill = Strategy_highsvQT)) +
                          geom_bar(stat = "identity",position=position_dodge(width = 0.5,preserve = "single"),width = 0.5,color = "black") +
                          scale_fill_manual(values = c("#A7C6ED","#FFFFFF","#BA0C2F")) +
                          geom_errorbar(aes(ymax=Upper_highsvQT,ymin=Lower_highsvQT),width=0.1) +
                          theme_bw() +
                          theme(legend.position = "top",legend.title = element_blank()) +
                          theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                                axis.text = element_text(size = 10),legend.text = element_text(size = 12)) +
                          scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                          xlab("Quantitative Test with Supervision") + ylab("Recurrence (#)") + 
                          theme(axis.title = element_text(size = 13,colour = "black",face = "bold"))
                        
                        data_highunsvQT <- data.frame(list(model8()$data_highunsvQT))
                        data_highunsvQT$Strategy_highunsvQT <- factor(data_highunsvQT$Strategy_highunsvQT,levels = c("sdPQ7","ddPQ14","TQ"))
                        data_highunsvQT <- data_highunsvQT %>% mutate(Mid_highunsvQT = as.numeric(Mid_highunsvQT),Lower_highunsvQT = as.numeric(Lower_highunsvQT),Upper_highunsvQT = as.numeric(Upper_highunsvQT))
                        p6 <- ggplot(data_highunsvQT,aes(Strategy_highunsvQT,Mid_highunsvQT,fill = Strategy_highunsvQT)) +
                          geom_bar(stat = "identity",position=position_dodge(width = 0.5,preserve = "single"),width = 0.5,color = "black") +
                          scale_fill_manual(values = c("#A7C6ED","#FFFFFF","#BA0C2F")) +
                          geom_errorbar(aes(ymax=Upper_highunsvQT,ymin=Lower_highunsvQT),width=0.1) +
                          theme_bw() +
                          theme(legend.position = "top",legend.title = element_blank()) +
                          theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                                axis.text = element_text(size = 10),legend.text = element_text(size = 12)) +
                          scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                          xlab("Quantitative Test without Supervision") + ylab("Recurrence (#)") + 
                          theme(axis.title = element_text(size = 13,colour = "black",face = "bold"))
                        
                        data_highsvNT <- data.frame(list(model8()$data_highsvNT))
                        data_highsvNT$Strategy_highsvNT <- factor(data_highsvNT$Strategy_highsvNT,levels = c("sdPQ7","sdPQ14","PQ8wks"))
                        data_highsvNT <- data_highsvNT %>% mutate(Mid_highsvNT = as.numeric(Mid_highsvNT),Lower_highsvNT = as.numeric(Lower_highsvNT),Upper_highsvNT = as.numeric(Upper_highsvNT))
                        p7 <- ggplot(data_highsvNT,aes(Strategy_highsvNT,Mid_highsvNT,fill = Strategy_highsvNT)) +
                          geom_bar(stat = "identity",position=position_dodge(width = 0.5,preserve = "single"),width = 0.5,color = "black") +
                          scale_fill_manual(values = c("#A7C6ED","#0067B9","#CFCDC9")) +
                          geom_errorbar(aes(ymax=Upper_highsvNT,ymin=Lower_highsvNT),width=0.1) +
                          theme_bw() +
                          theme(legend.position = "top",legend.title = element_blank()) +
                          theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                                axis.text = element_text(size = 10),legend.text = element_text(size = 12)) +
                          scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                          xlab("No Test with Supervision") + ylab("Recurrence (#)") + 
                          theme(axis.title = element_text(size = 13,colour = "black",face = "bold")) 
                        
                        data_highunsvNT <- data.frame(list(model8()$data_highunsvNT))
                        data_highunsvNT$Strategy_highunsvNT <- factor(data_highunsvNT$Strategy_highunsvNT,levels = c("sdPQ14","PQ8wks"))
                        data_highunsvNT <- data_highunsvNT %>% mutate(Mid_highunsvNT = as.numeric(Mid_highunsvNT),Lower_highunsvNT = as.numeric(Lower_highunsvNT),Upper_highunsvNT = as.numeric(Upper_highunsvNT))
                        p8 <- ggplot(data_highunsvNT,aes(Strategy_highunsvNT,Mid_highunsvNT,fill = Strategy_highunsvNT)) +
                          geom_bar(stat = "identity",position=position_dodge(width = 0.4,preserve = "single"),width = 0.4,color = "black") +
                          scale_fill_manual(values = c("#0067B9","#CFCDC9")) +
                          geom_errorbar(aes(ymax=Upper_highunsvNT,ymin=Lower_highunsvNT),width=0.1) +
                          theme_bw() +
                          theme(legend.position = "top",legend.title = element_blank()) +
                          theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                                axis.text = element_text(size = 10),legend.text = element_text(size = 12)) +
                          scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                          xlab("No Test without Supervision") + ylab("Recurrence (#)") + 
                          theme(axis.title = element_text(size = 13,colour = "black",face = "bold"))
                        
                        ggdraw() +
                          draw_plot(p5,0,0.51,0.49,0.49) +
                          draw_plot(p6,0.51,0.51,0.49,0.49) +
                          draw_plot(p7,0,0,0.49,0.49) +
                          draw_plot(p8,0.51,0,0.49,0.49)
                      } else
                      if (input$Risk == "High" & input$Treatment == "Supervised + Quantitative Test") {
                        highsvQT <- list(model9())
                        data_highsvQT <- data.frame(highsvQT)
                        data_highsvQT$Strategy_highsvQT <- factor(data_highsvQT$Strategy_highsvQT,levels = c("sdPQ7","ddPQ14","TQ"))
                        data_highsvQT <- data_highsvQT %>% mutate(Mid_highsvQT = as.numeric(Mid_highsvQT),Lower_highsvQT = as.numeric(Lower_highsvQT),Upper_highsvQT = as.numeric(Upper_highsvQT))
                        ggplot(data_highsvQT,aes(Strategy_highsvQT,Mid_highsvQT,fill = Strategy_highsvQT)) +
                          geom_bar(stat = "identity",position=position_dodge(width = 0.5,preserve = "single"),width = 0.5,color = "black") +
                          scale_fill_manual(values = c("#A7C6ED","#FFFFFF","#BA0C2F")) +
                          geom_errorbar(aes(ymax=Upper_highsvQT,ymin=Lower_highsvQT),width=0.1) +
                          theme_bw() +
                          theme(legend.position = "top",legend.title = element_blank()) +
                          theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                                axis.text = element_text(size = 18),legend.text = element_text(size = 15)) +
                          scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                          xlab("Quantitative Test with Supervision") + ylab("Recurrence (#)") + 
                          theme(axis.title = element_text(size = 18,colour = "black",face = "bold"))
                                } else
                        if (input$Risk == "High" & input$Treatment == "Unsupervised + Quantitative Test") {
                          highunsvQT <- list(model10())
                          data_highunsvQT <- data.frame(highunsvQT)
                          data_highunsvQT$Strategy_highunsvQT <- factor(data_highunsvQT$Strategy_highunsvQT,levels = c("sdPQ7","ddPQ14","TQ"))
                          data_highunsvQT <- data_highunsvQT %>% mutate(Mid_highunsvQT = as.numeric(Mid_highunsvQT),Lower_highunsvQT = as.numeric(Lower_highunsvQT),Upper_highunsvQT = as.numeric(Upper_highunsvQT))
                          ggplot(data_highunsvQT,aes(Strategy_highunsvQT,Mid_highunsvQT,fill = Strategy_highunsvQT)) +
                            geom_bar(stat = "identity",position=position_dodge(width = 0.5,preserve = "single"),width = 0.5,color = "black") +
                            scale_fill_manual(values = c("#A7C6ED","#FFFFFF","#BA0C2F")) +
                            geom_errorbar(aes(ymax=Upper_highunsvQT,ymin=Lower_highunsvQT),width=0.1) +
                            theme_bw() +
                            theme(legend.position = "top",legend.title = element_blank()) +
                            theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                                  axis.text = element_text(size = 18),legend.text = element_text(size = 15)) +
                            scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                            xlab("Quantitative Test without Supervision") + ylab("Recurrence (#)") + 
                            theme(axis.title = element_text(size = 18,colour = "black",face = "bold"))
                          } else
                          if (input$Risk == "High" & input$Treatment == "Supervised + No Test") {
                            highsvNT <- list(model11())
                            data_highsvNT <- data.frame(highsvNT)
                            data_highsvNT$Strategy_highsvNT <- factor(data_highsvNT$Strategy_highsvNT,levels = c("sdPQ7","sdPQ14","PQ8wks"))
                            data_highsvNT <- data_highsvNT %>% mutate(Mid_highsvNT = as.numeric(Mid_highsvNT),Lower_highsvNT = as.numeric(Lower_highsvNT),Upper_highsvNT = as.numeric(Upper_highsvNT))
                            ggplot(data_highsvNT,aes(Strategy_highsvNT,Mid_highsvNT,fill = Strategy_highsvNT)) +
                              geom_bar(stat = "identity",position=position_dodge(width = 0.5,preserve = "single"),width = 0.5,color = "black") +
                              scale_fill_manual(values = c("#A7C6ED","#0067B9","#CFCDC9")) +
                              geom_errorbar(aes(ymax=Upper_highsvNT,ymin=Lower_highsvNT),width=0.1) +
                              theme_bw() +
                              theme(legend.position = "top",legend.title = element_blank()) +
                              theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                                    axis.text = element_text(size = 18),legend.text = element_text(size = 15)) +
                              scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                              xlab("No Test with Supervision") + ylab("Recurrence (#)") + 
                              theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
                            } else
                            if (input$Risk == "High" & input$Treatment == "Unsupervised + No Test") {
                              highunsvNT <- list(model12())
                              data_highunsvNT <- data.frame(highunsvNT)
                              data_highunsvNT$Strategy_highunsvNT <- factor(data_highunsvNT$Strategy_highunsvNT,levels = c("sdPQ14","PQ8wks"))
                              data_highunsvNT <- data_highunsvNT %>% mutate(Mid_highunsvNT = as.numeric(Mid_highunsvNT),Lower_highunsvNT = as.numeric(Lower_highunsvNT),Upper_highunsvNT = as.numeric(Upper_highunsvNT))
                              ggplot(data_highunsvNT,aes(Strategy_highunsvNT,Mid_highunsvNT,fill = Strategy_highunsvNT)) +
                                geom_bar(stat = "identity",position=position_dodge(width = 0.4,preserve = "single"),width = 0.4,color = "black") +
                                scale_fill_manual(values = c("#0067B9","#CFCDC9")) +
                                geom_errorbar(aes(ymax=Upper_highunsvNT,ymin=Lower_highunsvNT),width=0.1) +
                                theme_bw() +
                                theme(legend.position = "top",legend.title = element_blank()) +
                                theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                                      axis.text = element_text(size = 18),legend.text = element_text(size = 15)) +
                                scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                                xlab("No Test without Supervision") + ylab("Recurrence (#)") + 
                                theme(axis.title = element_text(size = 18,colour = "black",face = "bold"))
                              } 
        })
  
  #### Recur Plot (2scenarios) ----
  output$plot_2scenarios <- renderPlot({
    if (input$Risk == "Low" & input$Treatment.A == "All"& input$Treatment.B == "All") {
      data_low_svQT_unsvQT <- data.frame(list(model13()$data_low_svQT_unsvQT))
      data_low_svQT_unsvQT$Test_low_svQT_unsvQT <- factor(data_low_svQT_unsvQT$Test_low_svQT_unsvQT,levels = c("svQT","unsvQT"))
      data_low_svQT_unsvQT$Strategy_low_svQT_unsvQT <- factor(data_low_svQT_unsvQT$Strategy_low_svQT_unsvQT,levels = c("sdPQ7+sdPQ7","sdPQ7+ddPQ14","sdPQ7+TQ","ddPQ14+sdPQ7","ddPQ14+ddPQ14","ddPQ14+TQ","TQ+sdPQ7","TQ+ddPQ14","TQ+TQ"))
      data_low_svQT_unsvQT$Name_low <- factor(data_low_svQT_unsvQT$Name_low_svQT_unsvQT,levels = c("sdPQ7","ddPQ14","TQ"))
      data_low_svQT_unsvQT <- data_low_svQT_unsvQT %>% mutate(Mid_low_svQT_unsvQT = as.numeric(Mid_low_svQT_unsvQT),Lower_low_svQT_unsvQT = as.numeric(Lower_low_svQT_unsvQT),Upper_low_svQT_unsvQT = as.numeric(Upper_low_svQT_unsvQT))
      p1 <- ggplot(data_low_svQT_unsvQT,aes(Strategy_low_svQT_unsvQT,Mid_low_svQT_unsvQT,fill = Name_low_svQT_unsvQT)) +
        geom_col(position = "stack",width = 0.8,color = "black")+
        geom_col_pattern(aes(pattern = Test_low_svQT_unsvQT,pattern_angle = Test_low_svQT_unsvQT),width = 0.8,pattern_fill = "black",color = "black",pattern_density = 0.1) +
        scale_pattern_manual(values = c("none","stripe")) +
        scale_pattern_angle_manual(values = c(0,45)) +
        scale_fill_manual(values = c("#A7C6ED","#FFFFFF","#BA0C2F")) +
        geom_errorbar(aes(ymax=Upper_low_svQT_unsvQT,ymin=Lower_low_svQT_unsvQT),width=0.1) +
        theme_bw() +
        theme(legend.position = "top",legend.title = element_blank()) +
        theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
              axis.text = element_text(size = 4),legend.text = element_text(size = 7)) +
        scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
        xlab("Quantitative Test with Supervision vs. Quantitative Test without Supervision") + ylab("Recurrence (#)") + 
        theme(axis.title = element_text(size = 8,colour = "black",face = "bold")) 
      
      data_low_svQT_svNT <- data.frame(list(model13()$data_low_svQT_svNT))
      data_low_svQT_svNT$Test_low_svQT_svNT <- factor(data_low_svQT_svNT$Test_low_svQT_svNT,levels = c("svQT","svNT"))
      data_low_svQT_svNT$Strategy_low_svQT_svNT <- factor(data_low_svQT_svNT$Strategy_low_svQT_svNT,levels = c("sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+ddPQ14","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+ddPQ14","TQ+sdPQ7","TQ+sdPQ14","TQ+ddPQ14"))
      data_low_svQT_svNT$Name_low_svQT_svNT <- factor(data_low_svQT_svNT$Name_low_svQT_svNT,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ"))
      data_low_svQT_svNT <- data_low_svQT_svNT %>% mutate(Mid_low_svQT_svNT = as.numeric(Mid_low_svQT_svNT),Lower_low_svQT_svNT = as.numeric(Lower_low_svQT_svNT),Upper_low_svQT_svNT = as.numeric(Upper_low_svQT_svNT))
      p2 <- ggplot(data_low_svQT_svNT,aes(Strategy_low_svQT_svNT,Mid_low_svQT_svNT,fill = Name_low_svQT_svNT)) +
        geom_col(position = "stack",width = 0.8,color = "black")+
        geom_col_pattern(aes(pattern = Test_low_svQT_svNT,pattern_angle = Test_low_svQT_svNT),width = 0.8,pattern_fill = "black",color = "black",pattern_density = 0.1) +
        scale_pattern_manual(values = c("none","stripe")) +
        scale_pattern_angle_manual(values = c(0,45)) +
        scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F")) +
        geom_errorbar(aes(ymax=Upper_low_svQT_svNT,ymin=Lower_low_svQT_svNT),width=0.1) +
        theme_bw() +
        theme(legend.position = "top",legend.title = element_blank()) +
        theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
              axis.text = element_text(size = 4),legend.text = element_text(size = 7)) +
        scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
        xlab("Quantitative Test with Supervision vs. No Test with Supervision") + ylab("Recurrence (#)") + 
        theme(axis.title = element_text(size = 8,colour = "black",face = "bold")) 
      
      data_low_svQT_unsvNT <- data.frame(list(model13()$data_low_svQT_unsvNT))
      data_low_svQT_unsvNT$Test_low_svQT_unsvNT <- factor(data_low_svQT_unsvNT$Test_low_svQT_unsvNT,levels = c("svQT","unsvNT"))
      data_low_svQT_unsvNT$Strategy_low_svQT_unsvNT <- factor(data_low_svQT_unsvNT$Strategy_low_svQT_unsvNT,levels = c("sdPQ7+sdPQ14","ddPQ14+sdPQ14","TQ+sdPQ14"))
      data_low_svQT_unsvNT$Name_low_svQT_unsvNT <- factor(data_low_svQT_unsvNT$Name_low_svQT_unsvNT,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ"))
      data_low_svQT_unsvNT <- data_low_svQT_unsvNT %>% mutate(Mid_low_svQT_unsvNT = as.numeric(Mid_low_svQT_unsvNT),Lower_low_svQT_unsvNT = as.numeric(Lower_low_svQT_unsvNT),Upper_low_svQT_unsvNT = as.numeric(Upper_low_svQT_unsvNT))
      p3 <- ggplot(data_low_svQT_unsvNT,aes(Strategy_low_svQT_unsvNT,Mid_low_svQT_unsvNT,fill = Name_low_svQT_unsvNT)) +
        geom_col(position = "stack",width = 0.3,color = "black")+
        geom_col_pattern(aes(pattern = Test_low_svQT_unsvNT,pattern_angle = Test_low_svQT_unsvNT),width = 0.3,pattern_fill = "black",color = "black",pattern_density = 0.1) +
        scale_pattern_manual(values = c("none","stripe")) +
        scale_pattern_angle_manual(values = c(0,45)) +
        scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F")) +
        geom_errorbar(aes(ymax=Upper_low_svQT_unsvNT,ymin=Lower_low_svQT_unsvNT),width=0.1) +
        theme_bw() +
        theme(legend.position = "top",legend.title = element_blank()) +
        theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
              axis.text = element_text(size = 6),legend.text = element_text(size = 7)) +
        scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
        xlab("Quantitative Test with Supervision vs. No Test without Supervision") + ylab("Recurrence (#)") + 
        theme(axis.title = element_text(size = 8,colour = "black",face = "bold"))
      
      data_low_unsvQT_svNT <- data.frame(list(model13()$data_low_unsvQT_svNT))
      data_low_unsvQT_svNT$Test_low_unsvQT_svNT <- factor(data_low_unsvQT_svNT$Test_low_unsvQT_svNT,levels = c("unsvQT","svNT"))
      data_low_unsvQT_svNT$Strategy_low_unsvQT_svNT <- factor(data_low_unsvQT_svNT$Strategy_low_unsvQT_svNT,levels = c("sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+ddPQ14","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+ddPQ14","TQ+sdPQ7","TQ+sdPQ14","TQ+ddPQ14"))
      data_low_unsvQT_svNT$Name_low_unsvQT_svNT <- factor(data_low_unsvQT_svNT$Name_low_unsvQT_svNT,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ"))
      data_low_unsvQT_svNT <- data_low_unsvQT_svNT %>% mutate(Mid_low_unsvQT_svNT = as.numeric(Mid_low_unsvQT_svNT),Lower_low_unsvQT_svNT = as.numeric(Lower_low_unsvQT_svNT),Upper_low_unsvQT_svNT = as.numeric(Upper_low_unsvQT_svNT))
      p4 <- ggplot(data_low_unsvQT_svNT,aes(Strategy_low_unsvQT_svNT,Mid_low_unsvQT_svNT,fill = Name_low_unsvQT_svNT)) +
        geom_col(position = "stack",width = 0.8,color = "black")+
        geom_col_pattern(aes(pattern = Test_low_unsvQT_svNT,pattern_angle = Test_low_unsvQT_svNT),width = 0.8,pattern_fill = "black",color = "black",pattern_density = 0.1) +
        scale_pattern_manual(values = c("none","stripe")) +
        scale_pattern_angle_manual(values = c(0,45)) +
        scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F")) +
        geom_errorbar(aes(ymax=Upper_low_unsvQT_svNT,ymin=Lower_low_unsvQT_svNT),width=0.1) +
        theme_bw() +
        theme(legend.position = "top",legend.title = element_blank()) +
        theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
              axis.text = element_text(size = 4),legend.text = element_text(size = 7)) +
        scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
        xlab("Quantitative Test without Supervision vs. No Test with Supervision") + ylab("Recurrence (#)") + 
        theme(axis.title = element_text(size = 8,colour = "black",face = "bold")) 
      
      data_low_unsvQT_unsvNT <- data.frame(list(model13()$data_low_unsvQT_unsvNT))
      data_low_unsvQT_unsvNT$Test_low_unsvQT_unsvNT <- factor(data_low_unsvQT_unsvNT$Test_low_unsvQT_unsvNT,levels = c("unsvQT","unsvNT"))
      data_low_unsvQT_unsvNT$Strategy_low_unsvQT_unsvNT <- factor(data_low_unsvQT_unsvNT$Strategy_low_unsvQT_unsvNT,levels = c("sdPQ7+sdPQ14","ddPQ14+sdPQ14","TQ+sdPQ14"))
      data_low_unsvQT_unsvNT$Name_low_unsvQT_unsvNT <- factor(data_low_unsvQT_unsvNT$Name_low_unsvQT_unsvNT,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ"))
      data_low_unsvQT_unsvNT <- data_low_unsvQT_unsvNT %>% mutate(Mid_low_unsvQT_unsvNT = as.numeric(Mid_low_unsvQT_unsvNT),Lower_low_unsvQT_unsvNT = as.numeric(Lower_low_unsvQT_unsvNT),Upper_low_unsvQT_unsvNT = as.numeric(Upper_low_unsvQT_unsvNT))
      p5 <- ggplot(data_low_unsvQT_unsvNT,aes(Strategy_low_unsvQT_unsvNT,Mid_low_unsvQT_unsvNT,fill = Name_low_unsvQT_unsvNT)) +
        geom_col(position = "stack",width = 0.3,color = "black")+
        geom_col_pattern(aes(pattern = Test_low_unsvQT_unsvNT,pattern_angle = Test_low_unsvQT_unsvNT),width = 0.3,pattern_fill = "black",color = "black",pattern_density = 0.1) +
        scale_pattern_manual(values = c("none","stripe")) +
        scale_pattern_angle_manual(values = c(0,45)) +
        scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F")) +
        geom_errorbar(aes(ymax=Upper_low_unsvQT_unsvNT,ymin=Lower_low_unsvQT_unsvNT),width=0.1) +
        theme_bw() +
        theme(legend.position = "top",legend.title = element_blank()) +
        theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
              axis.text = element_text(size = 6),legend.text = element_text(size = 7)) +
        scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
        xlab("Quantitative Test without Supervision vs. No Test without Supervision") + ylab("Recurrence (#)") + 
        theme(axis.title = element_text(size = 8,colour = "black",face = "bold")) 
      
      data_low_svNT_unsvNT <- data.frame(list(model13()$data_low_svNT_unsvNT))
      data_low_svNT_unsvNT$Test_low_svNT_unsvNT <- factor(data_low_svNT_unsvNT$Test_low_svNT_unsvNT,levels = c("svNT","unsvNT"))
      data_low_svNT_unsvNT$Strategy_low_svNT_unsvNT <- factor(data_low_svNT_unsvNT$Strategy_low_svNT_unsvNT,levels = c("sdPQ7+sdPQ14","sdPQ14+sdPQ14","ddPQ14+sdPQ14"))
      data_low_svNT_unsvNT$Name_low_svNT_unsvNT <- factor(data_low_svNT_unsvNT$Name_low_svNT_unsvNT,levels = c("sdPQ7","sdPQ14","ddPQ14"))
      data_low_svNT_unsvNT <- data_low_svNT_unsvNT %>% mutate(Mid_low_svNT_unsvNT = as.numeric(Mid_low_svNT_unsvNT),Lower_low_svNT_unsvNT = as.numeric(Lower_low_svNT_unsvNT),Upper_low_svNT_unsvNT = as.numeric(Upper_low_svNT_unsvNT))
      p6 <- ggplot(data_low_svNT_unsvNT,aes(Strategy_low_svNT_unsvNT,Mid_low_svNT_unsvNT,fill = Name_low_svNT_unsvNT)) +
        geom_col(position = "stack",width = 0.3,color = "black")+
        geom_col_pattern(aes(pattern = Test_low_svNT_unsvNT,pattern_angle = Test_low_svNT_unsvNT),width = 0.3,pattern_fill = "black",color = "black",pattern_density = 0.1) +
        scale_pattern_manual(values = c("none","stripe")) +
        scale_pattern_angle_manual(values = c(0,45)) +
        scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF")) +
        geom_errorbar(aes(ymax=Upper_low_svNT_unsvNT,ymin=Lower_low_svNT_unsvNT),width=0.1) +
        theme_bw() +
        theme(legend.position = "top",legend.title = element_blank()) +
        theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
              axis.text = element_text(size = 6),legend.text = element_text(size = 7)) +
        scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
        xlab("No Test with Supervision vs. No Test without Supervision") + ylab("Recurrence (#)") + 
        theme(axis.title = element_text(size = 8,colour = "black",face = "bold")) 
      
      ggdraw() +
        draw_plot(p1,0,0.5,0.33,0.5) +
        draw_plot(p2,0.33,0.5,0.33,0.5) +
        draw_plot(p3,0.66,0.5,0.33,0.5) +
        draw_plot(p4,0,0,0.33,0.5) +
        draw_plot(p5,0.33,0,0.33,0.5) +
        draw_plot(p6,0.66,0,0.33,0.5)
    } else
    if (input$Risk == "Low" & input$Treatment.A == "Supervised + Quantitative Test"& input$Treatment.B == "Unsupervised + Quantitative Test") {
      low_svQT_unsvQT <- list(model14())
      data_low_svQT_unsvQT <- data.frame(low_svQT_unsvQT)
      data_low_svQT_unsvQT$Test_low <- factor(data_low_svQT_unsvQT$Test_low,levels = c("Supervised + Quantitative Test","Unsupervised + Quantitative Test"))
      data_low_svQT_unsvQT$Strategy_low <- factor(data_low_svQT_unsvQT$Strategy_low,levels = c("sdPQ7+sdPQ7","sdPQ7+ddPQ14","sdPQ7+TQ","ddPQ14+sdPQ7","ddPQ14+ddPQ14","ddPQ14+TQ","TQ+sdPQ7","TQ+ddPQ14","TQ+TQ"))
      data_low_svQT_unsvQT$Name_low <- factor(data_low_svQT_unsvQT$Name_low,levels = c("sdPQ7","ddPQ14","TQ"))
      data_low_svQT_unsvQT <- data_low_svQT_unsvQT %>% mutate(Mid_low = as.numeric(Mid_low),Lower_low = as.numeric(Lower_low),Upper_low = as.numeric(Upper_low))
      ggplot(data_low_svQT_unsvQT,aes(Strategy_low,Mid_low,fill = Name_low)) +
        geom_col(position = "stack",width = 0.8,color = "black")+
        geom_col_pattern(aes(pattern = Test_low,pattern_angle = Test_low),width = 0.8,pattern_fill = "black",color = "black",pattern_density = 0.1) +
        scale_pattern_manual(values = c("none","stripe")) +
        scale_pattern_angle_manual(values = c(0,45)) +
        scale_fill_manual(values = c("#A7C6ED","#FFFFFF","#BA0C2F")) +
        geom_errorbar(aes(ymax=Upper_low,ymin=Lower_low),width=0.1) +
        theme_bw() +
        theme(legend.position = "top",legend.title = element_blank()) +
        theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
              axis.text = element_text(size = 10),legend.text = element_text(size = 15)) +
        scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
        xlab("Quantitative Test with Supervision (solid) vs. Quantitative Test without Supervision (stripe)") + ylab("Recurrence (#)") + 
        theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
    } else
      if (input$Risk == "Low" & input$Treatment.A == "Supervised + Quantitative Test"& input$Treatment.B == "Supervised + No Test") {
        low_svQT_svNT <- list(model15())
        data_low_svQT_svNT <- data.frame(low_svQT_svNT)
        data_low_svQT_svNT$Test_low <- factor(data_low_svQT_svNT$Test_low,levels = c("Supervised + Quantitative Test","Supervised + No Test"))
        data_low_svQT_svNT$Strategy_low <- factor(data_low_svQT_svNT$Strategy_low,levels = c("sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+ddPQ14","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+ddPQ14","TQ+sdPQ7","TQ+sdPQ14","TQ+ddPQ14"))
        data_low_svQT_svNT$Name_low <- factor(data_low_svQT_svNT$Name_low,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ"))
        data_low_svQT_svNT <- data_low_svQT_svNT %>% mutate(Mid_low = as.numeric(Mid_low),Lower_low = as.numeric(Lower_low),Upper_low = as.numeric(Upper_low))
        ggplot(data_low_svQT_svNT,aes(Strategy_low,Mid_low,fill = Name_low)) +
          geom_col(position = "stack",width = 0.8,color = "black")+
          geom_col_pattern(aes(pattern = Test_low,pattern_angle = Test_low),width = 0.8,pattern_fill = "black",color = "black",pattern_density = 0.1) +
          scale_pattern_manual(values = c("none","stripe")) +
          scale_pattern_angle_manual(values = c(0,45)) +
          scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F")) +
          geom_errorbar(aes(ymax=Upper_low,ymin=Lower_low),width=0.1) +
          theme_bw() +
          theme(legend.position = "top",legend.title = element_blank()) +
          theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                axis.text = element_text(size = 10),legend.text = element_text(size = 15)) +
          scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
          xlab("Quantitative Test with Supervision (solid) vs. No Test with Supervision (stripe)") + ylab("Recurrence (#)") + 
          theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
      } else
        if (input$Risk == "Low" & input$Treatment.A == "Supervised + Quantitative Test"& input$Treatment.B == "Unsupervised + No Test") {
          low_svQT_unsvNT <- list(model16())
          data_low_svQT_unsvNT <- data.frame(low_svQT_unsvNT)
          data_low_svQT_unsvNT$Test_low <- factor(data_low_svQT_unsvNT$Test_low,levels = c("Supervised + Quantitative Test","Unsupervised + No Test"))
          data_low_svQT_unsvNT$Strategy_low <- factor(data_low_svQT_unsvNT$Strategy_low,levels = c("sdPQ7+sdPQ14","ddPQ14+sdPQ14","TQ+sdPQ14"))
          data_low_svQT_unsvNT$Name_low <- factor(data_low_svQT_unsvNT$Name_low,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ"))
          data_low_svQT_unsvNT <- data_low_svQT_unsvNT %>% mutate(Mid_low = as.numeric(Mid_low),Lower_low = as.numeric(Lower_low),Upper_low = as.numeric(Upper_low))
          ggplot(data_low_svQT_unsvNT,aes(Strategy_low,Mid_low,fill = Name_low)) +
            geom_col(position = "stack",width = 0.3,color = "black")+
            geom_col_pattern(aes(pattern = Test_low,pattern_angle = Test_low),width = 0.3,pattern_fill = "black",color = "black",pattern_density = 0.1) +
            scale_pattern_manual(values = c("none","stripe")) +
            scale_pattern_angle_manual(values = c(0,45)) +
            scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F")) +
            geom_errorbar(aes(ymax=Upper_low,ymin=Lower_low),width=0.1) +
            theme_bw() +
            theme(legend.position = "top",legend.title = element_blank()) +
            theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                  axis.text = element_text(size = 10),legend.text = element_text(size = 15)) +
            scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
            xlab("Quantitative Test with Supervision (solid) vs. No Test without Supervision (stripe)") + ylab("Recurrence (#)") + 
            theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
        } else
          if (input$Risk == "Low" & input$Treatment.A == "Unsupervised + Quantitative Test"& input$Treatment.B == "Supervised + No Test") {
            low_unsvQT_svNT <- list(model17())
            data_low_unsvQT_svNT <- data.frame(low_unsvQT_svNT)
            data_low_unsvQT_svNT$Test_low <- factor(data_low_unsvQT_svNT$Test_low,levels = c("Unsupervised + Quantitative Test","Supervised + No Test"))
            data_low_unsvQT_svNT$Strategy_low <- factor(data_low_unsvQT_svNT$Strategy_low,levels = c("sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+ddPQ14","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+ddPQ14","TQ+sdPQ7","TQ+sdPQ14","TQ+ddPQ14"))
            data_low_unsvQT_svNT$Name_low <- factor(data_low_unsvQT_svNT$Name_low,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ"))
            data_low_unsvQT_svNT <- data_low_unsvQT_svNT %>% mutate(Mid_low = as.numeric(Mid_low),Lower_low = as.numeric(Lower_low),Upper_low = as.numeric(Upper_low))
            ggplot(data_low_unsvQT_svNT,aes(Strategy_low,Mid_low,fill = Name_low)) +
              geom_col(position = "stack",width = 0.8,color = "black")+
              geom_col_pattern(aes(pattern = Test_low,pattern_angle = Test_low),width = 0.8,pattern_fill = "black",color = "black",pattern_density = 0.1) +
              scale_pattern_manual(values = c("none","stripe")) +
              scale_pattern_angle_manual(values = c(0,45)) +
              scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F")) +
              geom_errorbar(aes(ymax=Upper_low,ymin=Lower_low),width=0.1) +
              theme_bw() +
              theme(legend.position = "top",legend.title = element_blank()) +
              theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                    axis.text = element_text(size = 10),legend.text = element_text(size = 15)) +
              scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
              xlab("Quantitative Test without Supervision (solid) vs. No Test with Supervision (stripe)") + ylab("Recurrence (#)") + 
              theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
          } else
            if (input$Risk == "Low" & input$Treatment.A == "Unsupervised + Quantitative Test"& input$Treatment.B == "Unsupervised + No Test") {
              low_unsvQT_unsvNT <- list(model18())
              data_low_unsvQT_unsvNT <- data.frame(low_unsvQT_unsvNT)
              data_low_unsvQT_unsvNT$Test_low <- factor(data_low_unsvQT_unsvNT$Test_low,levels = c("Unsupervised + Quantitative Test","Unsupervised + No Test"))
              data_low_unsvQT_unsvNT$Strategy_low <- factor(data_low_unsvQT_unsvNT$Strategy_low,levels = c("sdPQ7+sdPQ14","ddPQ14+sdPQ14","TQ+sdPQ14"))
              data_low_unsvQT_unsvNT$Name_low <- factor(data_low_unsvQT_unsvNT$Name_low,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ"))
              data_low_unsvQT_unsvNT <- data_low_unsvQT_unsvNT %>% mutate(Mid_low = as.numeric(Mid_low),Lower_low = as.numeric(Lower_low),Upper_low = as.numeric(Upper_low))
              ggplot(data_low_unsvQT_unsvNT,aes(Strategy_low,Mid_low,fill = Name_low)) +
                geom_col(position = "stack",width = 0.3,color = "black")+
                geom_col_pattern(aes(pattern = Test_low,pattern_angle = Test_low),width = 0.3,pattern_fill = "black",color = "black",pattern_density = 0.1) +
                scale_pattern_manual(values = c("none","stripe")) +
                scale_pattern_angle_manual(values = c(0,45)) +
                scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F")) +
                geom_errorbar(aes(ymax=Upper_low,ymin=Lower_low),width=0.1) +
                theme_bw() +
                theme(legend.position = "top",legend.title = element_blank()) +
                theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                      axis.text = element_text(size = 10),legend.text = element_text(size = 15)) +
                scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
                xlab("Quantitative Test without Supervision (solid) vs. No Test without Supervision (stripe)") + ylab("Recurrence (#)") + 
                theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
            } else
              if (input$Risk == "Low" & input$Treatment.A == "Supervised + No Test"& input$Treatment.B == "Unsupervised + No Test") {
                low_svNT_unsvNT <- list(model19())
                data_low_svNT_unsvNT <- data.frame(low_svNT_unsvNT)
                data_low_svNT_unsvNT$Test_low <- factor(data_low_svNT_unsvNT$Test_low,levels = c("Supervised + No Test","Unsupervised + No Test"))
                data_low_svNT_unsvNT$Strategy_low <- factor(data_low_svNT_unsvNT$Strategy_low,levels = c("sdPQ7+sdPQ14","sdPQ14+sdPQ14","ddPQ14+sdPQ14"))
                data_low_svNT_unsvNT$Name_low <- factor(data_low_svNT_unsvNT$Name_low,levels = c("sdPQ7","sdPQ14","ddPQ14"))
                data_low_svNT_unsvNT <- data_low_svNT_unsvNT %>% mutate(Mid_low = as.numeric(Mid_low),Lower_low = as.numeric(Lower_low),Upper_low = as.numeric(Upper_low))
                ggplot(data_low_svNT_unsvNT,aes(Strategy_low,Mid_low,fill = Name_low)) +
                  geom_col(position = "stack",width = 0.3,color = "black")+
                  geom_col_pattern(aes(pattern = Test_low,pattern_angle = Test_low),width = 0.3,pattern_fill = "black",color = "black",pattern_density = 0.1) +
                  scale_pattern_manual(values = c("none","stripe")) +
                  scale_pattern_angle_manual(values = c(0,45)) +
                  scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF")) +
                  geom_errorbar(aes(ymax=Upper_low,ymin=Lower_low),width=0.1) +
                  theme_bw() +
                  theme(legend.position = "top",legend.title = element_blank()) +
                  theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                        axis.text = element_text(size = 10),legend.text = element_text(size = 15)) +
                  scale_y_continuous(expand = c(0,0),limits = c(0,5000),breaks = seq(0,5000,1000)) + 
                  xlab("No Test with Supervision (solid) vs. No Test without Supervision (stripe)") + ylab("Recurrence (#)") + 
                  theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
              } else
                if (input$Risk == "High" & input$Treatment.A == "All"& input$Treatment.B == "All") {
                  data_high_svQT_unsvQT <- data.frame(list(model20()$data_high_svQT_unsvQT))
                  data_high_svQT_unsvQT$Test_high_svQT_unsvQT <- factor(data_high_svQT_unsvQT$Test_high_svQT_unsvQT,levels = c("svQT","unsvQT"))
                  data_high_svQT_unsvQT$Strategy_high_svQT_unsvQT <- factor(data_high_svQT_unsvQT$Strategy_high_svQT_unsvQT,levels = c("sdPQ7+sdPQ7","sdPQ7+ddPQ14","sdPQ7+TQ","ddPQ14+sdPQ7","ddPQ14+ddPQ14","ddPQ14+TQ","TQ+sdPQ7","TQ+ddPQ14","TQ+TQ"))
                  data_high_svQT_unsvQT$Name_high_svQT_unsvQT <- factor(data_high_svQT_unsvQT$Name_high_svQT_unsvQT,levels = c("sdPQ7","ddPQ14","TQ"))
                  data_high_svQT_unsvQT <- data_high_svQT_unsvQT %>% mutate(Mid_high_svQT_unsvQT = as.numeric(Mid_high_svQT_unsvQT),Lower_high_svQT_unsvQT = as.numeric(Lower_high_svQT_unsvQT),Upper_high_svQT_unsvQT = as.numeric(Upper_high_svQT_unsvQT))
                  p7 <- ggplot(data_high_svQT_unsvQT,aes(Strategy_high_svQT_unsvQT,Mid_high_svQT_unsvQT,fill = Name_high_svQT_unsvQT)) +
                    geom_col(position = "stack",width = 0.8,color = "black")+
                    geom_col_pattern(aes(pattern = Test_high_svQT_unsvQT,pattern_angle = Test_high_svQT_unsvQT),width = 0.8,pattern_fill = "black",color = "black",pattern_density = 0.1) +
                    scale_pattern_manual(values = c("none","stripe")) +
                    scale_pattern_angle_manual(values = c(0,45)) +
                    scale_fill_manual(values = c("#A7C6ED","#FFFFFF","#BA0C2F")) +
                    geom_errorbar(aes(ymax=Upper_high_svQT_unsvQT,ymin=Lower_high_svQT_unsvQT),width=0.1) +
                    theme_bw() +
                    theme(legend.position = "top",legend.title = element_blank()) +
                    theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                          axis.text = element_text(size = 4),legend.text = element_text(size = 6)) +
                    scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                    xlab("Quantitative Test with Supervision (solid) vs. Quantitative Test without Supervision") + ylab("Recurrence (#)") + 
                    theme(axis.title = element_text(size = 8,colour = "black",face = "bold"))
                  
                  data_high_svQT_svNT <- data.frame(list(model20()$data_high_svQT_svNT))
                  data_high_svQT_svNT$Test_high_svQT_svNT <- factor(data_high_svQT_svNT$Test_high_svQT_svNT,levels = c("svQT","svNT"))
                  data_high_svQT_svNT$Strategy_high_svQT_svNT <- factor(data_high_svQT_svNT$Strategy_high_svQT_svNT,levels = c("sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+PQ8wks","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+PQ8wks","TQ+sdPQ7","TQ+sdPQ14","TQ+PQ8wks"))
                  data_high_svQT_svNT$Name_high_svQT_svNT <- factor(data_high_svQT_svNT$Name_high_svQT_svNT,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ","PQ8wks"))
                  data_high_svQT_svNT <- data_high_svQT_svNT %>% mutate(Mid_high_svQT_svNT = as.numeric(Mid_high_svQT_svNT),Lower_high_svQT_svNT = as.numeric(Lower_high_svQT_svNT),Upper_high_svQT_svNT = as.numeric(Upper_high_svQT_svNT))
                  p8 <- ggplot(data_high_svQT_svNT,aes(Strategy_high_svQT_svNT,Mid_high_svQT_svNT,fill = Name_high_svQT_svNT)) +
                    geom_col(position = "stack",width = 0.8,color = "black")+
                    geom_col_pattern(aes(pattern = Test_high_svQT_svNT,pattern_angle = Test_high_svQT_svNT),width = 0.8,pattern_fill = "black",color = "black",pattern_density = 0.1) +
                    scale_pattern_manual(values = c("none","stripe")) +
                    scale_pattern_angle_manual(values = c(0,45)) +
                    scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F","#CFCDC9")) +
                    geom_errorbar(aes(ymax=Upper_high_svQT_svNT,ymin=Lower_high_svQT_svNT),width=0.1) +
                    theme_bw() +
                    theme(legend.position = "top",legend.title = element_blank()) +
                    theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                          axis.text = element_text(size = 4),legend.text = element_text(size = 6)) +
                    scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                    xlab("Quantitative Test with Supervision vs. No Test with Supervision") + ylab("Recurrence (#)") + 
                    theme(axis.title = element_text(size = 8,colour = "black",face = "bold"))
                  
                  data_high_svQT_unsvNT <- data.frame(list(model20()$data_high_svQT_unsvNT))
                  data_high_svQT_unsvNT$Test_high_svQT_unsvNT <- factor(data_high_svQT_unsvNT$Test_high_svQT_unsvNT,levels = c("svQT","unsvNT"))
                  data_high_svQT_unsvNT$Strategy_high_svQT_unsvNT <- factor(data_high_svQT_unsvNT$Strategy_high_svQT_unsvNT,levels = c("sdPQ7+sdPQ14","sdPQ7+PQ8wks","ddPQ14+sdPQ14","ddPQ14+PQ8wks","TQ+sdPQ14","TQ+PQ8wks"))
                  data_high_svQT_unsvNT$Name_high_svQT_unsvNT <- factor(data_high_svQT_unsvNT$Name_high_svQT_unsvNT,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ","PQ8wks"))
                  data_high_svQT_unsvNT <- data_high_svQT_unsvNT %>% mutate(Mid_high_svQT_unsvNT = as.numeric(Mid_high_svQT_unsvNT),Lower_high_svQT_unsvNT = as.numeric(Lower_high_svQT_unsvNT),Upper_high_svQT_unsvNT = as.numeric(Upper_high_svQT_unsvNT))
                  p9 <- ggplot(data_high_svQT_unsvNT,aes(Strategy_high_svQT_unsvNT,Mid_high_svQT_unsvNT,fill = Name_high_svQT_unsvNT)) +
                    geom_col(position = "stack",width = 0.5,color = "black")+
                    geom_col_pattern(aes(pattern = Test_high_svQT_unsvNT,pattern_angle = Test_high_svQT_unsvNT),width = 0.5,pattern_fill = "black",color = "black",pattern_density = 0.1) +
                    scale_pattern_manual(values = c("none","stripe")) +
                    scale_pattern_angle_manual(values = c(0,45)) +
                    scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F","#CFCDC9")) +
                    geom_errorbar(aes(ymax=Upper_high_svQT_unsvNT,ymin=Lower_high_svQT_unsvNT),width=0.1) +
                    theme_bw() +
                    theme(legend.position = "top",legend.title = element_blank()) +
                    theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                          axis.text = element_text(size = 6),legend.text = element_text(size = 6)) +
                    scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                    xlab("Quantitative Test with Supervision vs. No Test without Supervision") + ylab("Recurrence (#)") +
                    theme(axis.title = element_text(size = 8,colour = "black",face = "bold")) 
                  
                  data_high_unsvQT_svNT <- data.frame(list(model20()$data_high_unsvQT_svNT))
                  data_high_unsvQT_svNT$Test_high_unsvQT_svNT <- factor(data_high_unsvQT_svNT$Test_high_unsvQT_svNT,levels = c("unsvQT","svNT"))
                  data_high_unsvQT_svNT$Strategy_high_unsvQT_svNT <- factor(data_high_unsvQT_svNT$Strategy_high_unsvQT_svNT,levels = c("sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+PQ8wks","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+PQ8wks","TQ+sdPQ7","TQ+sdPQ14","TQ+PQ8wks"))
                  data_high_unsvQT_svNT$Name_high_unsvQT_svNT <- factor(data_high_unsvQT_svNT$Name_high_unsvQT_svNT,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ","PQ8wks"))
                  data_high_unsvQT_svNT <- data_high_unsvQT_svNT %>% mutate(Mid_high_unsvQT_svNT = as.numeric(Mid_high_unsvQT_svNT),Lower_high_unsvQT_svNT = as.numeric(Lower_high_unsvQT_svNT),Upper_high_unsvQT_svNT = as.numeric(Upper_high_unsvQT_svNT))
                  p10 <- ggplot(data_high_unsvQT_svNT,aes(Strategy_high_unsvQT_svNT,Mid_high_unsvQT_svNT,fill = Name_high_unsvQT_svNT)) +
                    geom_col(position = "stack",width = 0.8,color = "black")+
                    geom_col_pattern(aes(pattern = Test_high_unsvQT_svNT,pattern_angle = Test_high_unsvQT_svNT),width = 0.8,pattern_fill = "black",color = "black",pattern_density = 0.1) +
                    scale_pattern_manual(values = c("none","stripe")) +
                    scale_pattern_angle_manual(values = c(0,45)) +
                    scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F","#CFCDC9")) +
                    geom_errorbar(aes(ymax=Upper_high_unsvQT_svNT,ymin=Lower_high_unsvQT_svNT),width=0.1) +
                    theme_bw() +
                    theme(legend.position = "top",legend.title = element_blank()) +
                    theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                          axis.text = element_text(size = 4),legend.text = element_text(size = 6)) +
                    scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                    xlab("Quantitative Test without Supervision vs. No Test with Supervision") + ylab("Recurrence (#)") + 
                    theme(axis.title = element_text(size = 8,colour = "black",face = "bold")) 
                  
                  data_high_unsvQT_unsvNT <- data.frame(list(model20()$data_high_unsvQT_unsvNT))
                  data_high_unsvQT_unsvNT$Test_high_unsvQT_unsvNT <- factor(data_high_unsvQT_unsvNT$Test_high_unsvQT_unsvNT,levels = c("unsvQT","unsvNT"))
                  data_high_unsvQT_unsvNT$Strategy_high_unsvQT_unsvNT <- factor(data_high_unsvQT_unsvNT$Strategy_high_unsvQT_unsvNT,levels = c("sdPQ7+sdPQ14","sdPQ7+PQ8wks","ddPQ14+sdPQ14","ddPQ14+PQ8wks","TQ+sdPQ14","TQ+PQ8wks"))
                  data_high_unsvQT_unsvNT$Name_high_unsvQT_unsvNT <- factor(data_high_unsvQT_unsvNT$Name_high_unsvQT_unsvNT,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ","PQ8wks"))
                  data_high_unsvQT_unsvNT <- data_high_unsvQT_unsvNT %>% mutate(Mid_high_unsvQT_unsvNT = as.numeric(Mid_high_unsvQT_unsvNT),Lower_high_unsvQT_unsvNT = as.numeric(Lower_high_unsvQT_unsvNT),Upper_high_unsvQT_unsvNT = as.numeric(Upper_high_unsvQT_unsvNT))
                  p11 <- ggplot(data_high_unsvQT_unsvNT,aes(Strategy_high_unsvQT_unsvNT,Mid_high_unsvQT_unsvNT,fill = Name_high_unsvQT_unsvNT)) +
                    geom_col(position = "stack",width = 0.5,color = "black")+
                    geom_col_pattern(aes(pattern = Test_high_unsvQT_unsvNT,pattern_angle = Test_high_unsvQT_unsvNT),width = 0.5,pattern_fill = "black",color = "black",pattern_density = 0.1) +
                    scale_pattern_manual(values = c("none","stripe")) +
                    scale_pattern_angle_manual(values = c(0,45)) +
                    scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F","#CFCDC9")) +
                    geom_errorbar(aes(ymax=Upper_high_unsvQT_unsvNT,ymin=Lower_high_unsvQT_unsvNT),width=0.1) +
                    theme_bw() +
                    theme(legend.position = "top",legend.title = element_blank()) +
                    theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                          axis.text = element_text(size = 6),legend.text = element_text(size = 6)) +
                    scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                    xlab("Quantitative Test without Supervision vs. No Test without Supervision") + ylab("Recurrence (#)") +
                    theme(axis.title = element_text(size = 8,colour = "black",face = "bold")) 
                  
                  data_high_svNT_unsvNT <- data.frame(list(model20()$data_high_svNT_unsvNT))
                  data_high_svNT_unsvNT$Test_high_svNT_unsvNT <- factor(data_high_svNT_unsvNT$Test_high_svNT_unsvNT,levels = c("svNT","unsvNT"))
                  data_high_svNT_unsvNT$Strategy_high_svNT_unsvNT <- factor(data_high_svNT_unsvNT$Strategy_high_svNT_unsvNT,levels = c("sdPQ7+sdPQ14","sdPQ7+PQ8wks","sdPQ14+sdPQ14","sdPQ14+PQ8wks","PQ8wks+sdPQ14","PQ8wks+PQ8wks"))
                  data_high_svNT_unsvNT$Name_high_svNT_unsvNT <- factor(data_high_svNT_unsvNT$Name_high_svNT_unsvNT,levels = c("sdPQ7","sdPQ14","PQ8wks"))
                  data_high_svNT_unsvNT <- data_high_svNT_unsvNT %>% mutate(Mid_high_svNT_unsvNT = as.numeric(Mid_high_svNT_unsvNT),Lower_high_svNT_unsvNT = as.numeric(Lower_high_svNT_unsvNT),Upper_high_svNT_unsvNT = as.numeric(Upper_high_svNT_unsvNT))
                  p12 <- ggplot(data_high_svNT_unsvNT,aes(Strategy_high_svNT_unsvNT,Mid_high_svNT_unsvNT,fill = Name_high_svNT_unsvNT)) +
                    geom_col(position = "stack",width = 0.5,color = "black")+
                    geom_col_pattern(aes(pattern = Test_high_svNT_unsvNT,pattern_angle = Test_high_svNT_unsvNT),width = 0.5,pattern_fill = "black",color = "black",pattern_density = 0.1) +
                    scale_pattern_manual(values = c("none","stripe")) +
                    scale_pattern_angle_manual(values = c(0,45)) +
                    scale_fill_manual(values = c("#A7C6ED","#0067B9","#CFCDC9")) +
                    geom_errorbar(aes(ymax=Upper_high_svNT_unsvNT,ymin=Lower_high_svNT_unsvNT),width=0.1) +
                    theme_bw() +
                    theme(legend.position = "top",legend.title = element_blank()) +
                    theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                          axis.text = element_text(size = 6),legend.text = element_text(size = 6)) +
                    scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                    xlab("No Test with Supervision vs. No Test without Supervision") + ylab("Recurrence (#)") + 
                    theme(axis.title = element_text(size = 8,colour = "black",face = "bold")) 
                  
                  ggdraw() +
                    draw_plot(p7,0,0.5,0.33,0.5) +
                    draw_plot(p8,0.33,0.5,0.33,0.5) +
                    draw_plot(p9,0.66,0.5,0.33,0.5) +
                    draw_plot(p10,0,0,0.33,0.5) +
                    draw_plot(p11,0.33,0,0.33,0.5) +
                    draw_plot(p12,0.66,0,0.33,0.5)
                } else
                if (input$Risk == "High" & input$Treatment.A == "Supervised + Quantitative Test"& input$Treatment.B == "Unsupervised + Quantitative Test") {
                  high_svQT_unsvQT <- list(model21())
                  data_high_svQT_unsvQT <- data.frame(high_svQT_unsvQT)
                  data_high_svQT_unsvQT$Test_high <- factor(data_high_svQT_unsvQT$Test_high,levels = c("Supervised + Quantitative Test","Unsupervised + Quantitative Test"))
                  data_high_svQT_unsvQT$Strategy_high <- factor(data_high_svQT_unsvQT$Strategy_high,levels = c("sdPQ7+sdPQ7","sdPQ7+ddPQ14","sdPQ7+TQ","ddPQ14+sdPQ7","ddPQ14+ddPQ14","ddPQ14+TQ","TQ+sdPQ7","TQ+ddPQ14","TQ+TQ"))
                  data_high_svQT_unsvQT$Name_high <- factor(data_high_svQT_unsvQT$Name_high,levels = c("sdPQ7","ddPQ14","TQ"))
                  data_high_svQT_unsvQT <- data_high_svQT_unsvQT %>% mutate(Mid_high = as.numeric(Mid_high),Lower_high = as.numeric(Lower_high),Upper_high = as.numeric(Upper_high))
                  ggplot(data_high_svQT_unsvQT,aes(Strategy_high,Mid_high,fill = Name_high)) +
                    geom_col(position = "stack",width = 0.8,color = "black")+
                    geom_col_pattern(aes(pattern = Test_high,pattern_angle = Test_high),width = 0.8,pattern_fill = "black",color = "black",pattern_density = 0.1) +
                    scale_pattern_manual(values = c("none","stripe")) +
                    scale_pattern_angle_manual(values = c(0,45)) +
                    scale_fill_manual(values = c("#A7C6ED","#FFFFFF","#BA0C2F")) +
                    geom_errorbar(aes(ymax=Upper_high,ymin=Lower_high),width=0.1) +
                    theme_bw() +
                    theme(legend.position = "top",legend.title = element_blank()) +
                    theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                          axis.text = element_text(size = 10),legend.text = element_text(size = 15)) +
                    scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                    xlab("Quantitative Test with Supervision (solid) vs. Quantitative Test without Supervision (stripe)") + ylab("Recurrence (#)") + 
                    theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
                } else
                  if (input$Risk == "High" & input$Treatment.A == "Supervised + Quantitative Test"& input$Treatment.B == "Supervised + No Test") {
                    high_svQT_svNT <- list(model22())
                    data_high_svQT_svNT <- data.frame(high_svQT_svNT)
                    data_high_svQT_svNT$Test_high <- factor(data_high_svQT_svNT$Test_high,levels = c("Supervised + Quantitative Test","Supervised + No Test"))
                    data_high_svQT_svNT$Strategy_high <- factor(data_high_svQT_svNT$Strategy_high,levels = c("sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+PQ8wks","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+PQ8wks","TQ+sdPQ7","TQ+sdPQ14","TQ+PQ8wks"))
                    data_high_svQT_svNT$Name_high <- factor(data_high_svQT_svNT$Name_high,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ","PQ8wks"))
                    data_high_svQT_svNT <- data_high_svQT_svNT %>% mutate(Mid_high = as.numeric(Mid_high),Lower_high = as.numeric(Lower_high),Upper_high = as.numeric(Upper_high))
                    ggplot(data_high_svQT_svNT,aes(Strategy_high,Mid_high,fill = Name_high)) +
                      geom_col(position = "stack",width = 0.8,color = "black")+
                      geom_col_pattern(aes(pattern = Test_high,pattern_angle = Test_high),width = 0.8,pattern_fill = "black",color = "black",pattern_density = 0.1) +
                      scale_pattern_manual(values = c("none","stripe")) +
                      scale_pattern_angle_manual(values = c(0,45)) +
                      scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F","#CFCDC9")) +
                      geom_errorbar(aes(ymax=Upper_high,ymin=Lower_high),width=0.1) +
                      theme_bw() +
                      theme(legend.position = "top",legend.title = element_blank()) +
                      theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                            axis.text = element_text(size = 10),legend.text = element_text(size = 15)) +
                      scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                      xlab("Quantitative Test with Supervision (solid) vs. No Test with Supervision (stripe)") + ylab("Recurrence (#)") + 
                      theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
                  } else
                    if (input$Risk == "High" & input$Treatment.A == "Supervised + Quantitative Test"& input$Treatment.B == "Unsupervised + No Test") {
                      high_svQT_unsvNT <- list(model23())
                      data_high_svQT_unsvNT <- data.frame(high_svQT_unsvNT)
                      data_high_svQT_unsvNT$Test_high <- factor(data_high_svQT_unsvNT$Test_high,levels = c("Supervised + Quantitative Test","Unsupervised + No Test"))
                      data_high_svQT_unsvNT$Strategy_high <- factor(data_high_svQT_unsvNT$Strategy_high,levels = c("sdPQ7+sdPQ14","sdPQ7+PQ8wks","ddPQ14+sdPQ14","ddPQ14+PQ8wks","TQ+sdPQ14","TQ+PQ8wks"))
                      data_high_svQT_unsvNT$Name_high <- factor(data_high_svQT_unsvNT$Name_high,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ","PQ8wks"))
                      data_high_svQT_unsvNT <- data_high_svQT_unsvNT %>% mutate(Mid_high = as.numeric(Mid_high),Lower_high = as.numeric(Lower_high),Upper_high = as.numeric(Upper_high))
                      ggplot(data_high_svQT_unsvNT,aes(Strategy_high,Mid_high,fill = Name_high)) +
                        geom_col(position = "stack",width = 0.5,color = "black")+
                        geom_col_pattern(aes(pattern = Test_high,pattern_angle = Test_high),width = 0.5,pattern_fill = "black",color = "black",pattern_density = 0.1) +
                        scale_pattern_manual(values = c("none","stripe")) +
                        scale_pattern_angle_manual(values = c(0,45)) +
                        scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F","#CFCDC9")) +
                        geom_errorbar(aes(ymax=Upper_high,ymin=Lower_high),width=0.1) +
                        theme_bw() +
                        theme(legend.position = "top",legend.title = element_blank()) +
                        theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                              axis.text = element_text(size = 10),legend.text = element_text(size = 15)) +
                        scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                        xlab("Quantitative Test with Supervision (solid) vs. No Test without Supervision (stripe)") + ylab("Recurrence (#)") +
                        theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
                    } else
                      if (input$Risk == "High" & input$Treatment.A == "Unsupervised + Quantitative Test"& input$Treatment.B == "Supervised + No Test") {
                        high_unsvQT_svNT <- list(model24())
                        data_high_unsvQT_svNT <- data.frame(high_unsvQT_svNT)
                        data_high_unsvQT_svNT$Test_high <- factor(data_high_unsvQT_svNT$Test_high,levels = c("Unsupervised + Quantitative Test","Supervised + No Test"))
                        data_high_unsvQT_svNT$Strategy_high <- factor(data_high_unsvQT_svNT$Strategy_high,levels = c("sdPQ7+sdPQ7","sdPQ7+sdPQ14","sdPQ7+PQ8wks","ddPQ14+sdPQ7","ddPQ14+sdPQ14","ddPQ14+PQ8wks","TQ+sdPQ7","TQ+sdPQ14","TQ+PQ8wks"))
                        data_high_unsvQT_svNT$Name_high <- factor(data_high_unsvQT_svNT$Name_high,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ","PQ8wks"))
                        data_high_unsvQT_svNT <- data_high_unsvQT_svNT %>% mutate(Mid_high = as.numeric(Mid_high),Lower_high = as.numeric(Lower_high),Upper_high = as.numeric(Upper_high))
                        ggplot(data_high_unsvQT_svNT,aes(Strategy_high,Mid_high,fill = Name_high)) +
                          geom_col(position = "stack",width = 0.8,color = "black")+
                          geom_col_pattern(aes(pattern = Test_high,pattern_angle = Test_high),width = 0.8,pattern_fill = "black",color = "black",pattern_density = 0.1) +
                          scale_pattern_manual(values = c("none","stripe")) +
                          scale_pattern_angle_manual(values = c(0,45)) +
                          scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F","#CFCDC9")) +
                          geom_errorbar(aes(ymax=Upper_high,ymin=Lower_high),width=0.1) +
                          theme_bw() +
                          theme(legend.position = "top",legend.title = element_blank()) +
                          theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                                axis.text = element_text(size = 10),legend.text = element_text(size = 15)) +
                          scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                          xlab("Quantitative Test without Supervision (solid) vs. No Test with Supervision (stripe)") + ylab("Recurrence (#)") + 
                          theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
                      } else
                        if (input$Risk == "High" & input$Treatment.A == "Unsupervised + Quantitative Test"& input$Treatment.B == "Unsupervised + No Test") {
                          high_unsvQT_unsvNT <- list(model25())
                          data_high_unsvQT_unsvNT <- data.frame(high_unsvQT_unsvNT)
                          data_high_unsvQT_unsvNT$Test_high <- factor(data_high_unsvQT_unsvNT$Test_high,levels = c("Unsupervised + Quantitative Test","Unsupervised + No Test"))
                          data_high_unsvQT_unsvNT$Strategy_high <- factor(data_high_unsvQT_unsvNT$Strategy_high,levels = c("sdPQ7+sdPQ14","sdPQ7+PQ8wks","ddPQ14+sdPQ14","ddPQ14+PQ8wks","TQ+sdPQ14","TQ+PQ8wks"))
                          data_high_unsvQT_unsvNT$Name_high <- factor(data_high_unsvQT_unsvNT$Name_high,levels = c("sdPQ7","sdPQ14","ddPQ14","TQ","PQ8wks"))
                          data_high_unsvQT_unsvNT <- data_high_unsvQT_unsvNT %>% mutate(Mid_high = as.numeric(Mid_high),Lower_high = as.numeric(Lower_high),Upper_high = as.numeric(Upper_high))
                          ggplot(data_high_unsvQT_unsvNT,aes(Strategy_high,Mid_high,fill = Name_high)) +
                            geom_col(position = "stack",width = 0.5,color = "black")+
                            geom_col_pattern(aes(pattern = Test_high,pattern_angle = Test_high),width = 0.5,pattern_fill = "black",color = "black",pattern_density = 0.1) +
                            scale_pattern_manual(values = c("none","stripe")) +
                            scale_pattern_angle_manual(values = c(0,45)) +
                            scale_fill_manual(values = c("#A7C6ED","#0067B9","#FFFFFF","#BA0C2F","#CFCDC9")) +
                            geom_errorbar(aes(ymax=Upper_high,ymin=Lower_high),width=0.1) +
                            theme_bw() +
                            theme(legend.position = "top",legend.title = element_blank()) +
                            theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                                  axis.text = element_text(size = 10),legend.text = element_text(size = 15)) +
                            scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                            xlab("Quantitative Test without Supervision (solid) vs. No Test without Supervision (stripe)") + ylab("Recurrence (#)") +
                            theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
                        } else
                          if (input$Risk == "High" & input$Treatment.A == "Supervised + No Test"& input$Treatment.B == "Unsupervised + No Test") {
                            high_svNT_unsvNT <- list(model26())
                            data_high_svNT_unsvNT <- data.frame(high_svNT_unsvNT)
                            data_high_svNT_unsvNT$Test_high <- factor(data_high_svNT_unsvNT$Test_high,levels = c("Supervised + No Test","Unsupervised + No Test"))
                            data_high_svNT_unsvNT$Strategy_high <- factor(data_high_svNT_unsvNT$Strategy_high,levels = c("sdPQ7+sdPQ14","sdPQ7+PQ8wks","sdPQ14+sdPQ14","sdPQ14+PQ8wks","PQ8wks+sdPQ14","PQ8wks+PQ8wks"))
                            data_high_svNT_unsvNT$Name_high <- factor(data_high_svNT_unsvNT$Name_high,levels = c("sdPQ7","sdPQ14","PQ8wks"))
                            data_high_svNT_unsvNT <- data_high_svNT_unsvNT %>% mutate(Mid_high = as.numeric(Mid_high),Lower_high = as.numeric(Lower_high),Upper_high = as.numeric(Upper_high))
                            ggplot(data_high_svNT_unsvNT,aes(Strategy_high,Mid_high,fill = Name_high)) +
                              geom_col(position = "stack",width = 0.5,color = "black")+
                              geom_col_pattern(aes(pattern = Test_high,pattern_angle = Test_high),width = 0.5,pattern_fill = "black",color = "black",pattern_density = 0.1) +
                              scale_pattern_manual(values = c("none","stripe")) +
                              scale_pattern_angle_manual(values = c(0,45)) +
                              scale_fill_manual(values = c("#A7C6ED","#0067B9","#CFCDC9")) +
                              geom_errorbar(aes(ymax=Upper_high,ymin=Lower_high),width=0.1) +
                              theme_bw() +
                              theme(legend.position = "top",legend.title = element_blank()) +
                              theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
                                    axis.text = element_text(size = 10),legend.text = element_text(size = 15)) +
                              scale_y_continuous(expand = c(0,0),limits = c(0,6000),breaks = seq(0,6000,1200)) + 
                              xlab("No Test with Supervision (solid) vs. No Test without Supervision (stripe)") + ylab("Recurrence (#)") + 
                              theme(axis.title = element_text(size = 18,colour = "black",face = "bold")) 
                          } 
  })
  
}  ## close server

# Run the application 
shinyApp(ui = ui, server = server)
