

#***************************************
# FUNCTION TO SIMULATE COIN TOSSES 
#***************************************

# define fn: -----------
coin.toss <- function(reps = 100, 
                      numcoins=7) {
      # fn to record num heads (=1) for each of several coins that 
      #     are flipped a specified number of times 
      
      
      # load packages if not already loaded: 
      if (!require("magrittr")) {
            library("magrittr")
      }
      
      if (!require("dplyr")) {
            library("dplyr")
      }
      
      if (!require("reshape2")) {
            library("reshape2")
      }
      
      if (!require("ggplot2")) {
            library("ggplot2")
      }
      #**************************************
      

      # for each coin, toss and record full results: 
      toss.results <- sapply(seq(1:numcoins), # data to iterate over 
                   
                   # define fn: 
                   function(x) {
                         rbinom(n=reps, size=1, prob=.5)
                   }
                   ) %>% as.data.frame
      print(toss.results)
      
      # find total heads:  
      summary.results <- summarise_all(toss.results, 
                                       sum)  %>% print 
      
      # melt data: 
      toss.results.melt <- melt(toss.results)  %>% print 
      
      summary.results.melt <- melt(summary.results)  %>% print 
      
      
      # plot results as col graph: 
      ggplot(summary.results.melt, 
             aes(x=variable, 
                 y=value)) + 
            
            geom_bar(stat = "identity", 
                     fill="dodgerblue") + 
            
            theme_classic(base_size = 16)
      
      
      
      
}



# test fn: -------------
coin.toss(reps=20)
