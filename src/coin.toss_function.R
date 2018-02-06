

#***************************************
# FUNCTION TO SIMULATE COIN TOSSES 
#***************************************

# define fn: -----------
coin.toss <- function(reps = 100, 
                      numcoins=7, 
                      layout=1) {
      # fn to record num heads (=1) for each of several coins that 
      #     are flipped a specified number of times 
      # arg layout = 1 for showing col graph, 2 for col and boxplot
      
      
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
      # print(toss.results)
      
      # find total heads:  
      summary.results <- summarise_all(toss.results, 
                                       sum)  %>% print 
      
      # melt data: 
      toss.results.melt <- melt(toss.results)  %>% print 
      
      summary.results.melt <- melt(summary.results)  %>% print 
      
      
      # plot results as col graph: 
      p1.bar <- ggplot(summary.results.melt, 
                   aes(x=variable, 
                       y=value)) + 
                  
                  geom_bar(stat = "identity", 
                           fill="dodgerblue") + 
                  
                  labs(title = paste0("Result of tossing ", 
                                      numcoins, 
                                      " coins ", 
                                      reps, 
                                      " times")) + 
                  
                  theme_classic(base_size = 16)
      
      
      # plot results as boxplot: 
      p2.box <- ggplot(toss.results.melt, 
                   aes(x=variable, 
                       y=value)) + 
                  
                  geom_boxplot() + 
                  
                  stat_summary(fun.y=mean) +
                  
                  labs(title = paste0("Result of tossing ", 
                                      numcoins, 
                                      " coins ", 
                                      reps, 
                                      " times")) + 
                  
                  theme_classic(base_size = 16)
      
      
      # choose layout: 
      if (layout == 1){
            p1.bar
      } else if (layout ==2){
            setpar <- par(mfrow=c(2,1))
            print(p1.bar); print(p2.box) 
            par(setpar)  # reset display 
      }
      
}



# test fn: -------------
coin.toss(reps=20, layout=2)
