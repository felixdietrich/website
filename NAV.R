require(QCAM)
require(ggplot2)
require(plotly)
require(rdrop2)
options(scipen = 999)
# a <- read.csv('~/Dropbox/NAV_U6136674.csv')
# devtools::install_version("ggplot2", version = "3.2.1", repos = "http://cran.us.r-project.org")

path = '~/'
# path <- 'C:/Users/felix.dietrich/Documents/GitHub/website/'
token <- readRDS(gzcon(url("https://dl.dropboxusercontent.com/s/id7x9vni8gjydi3/droptoken.rds")))
a <- drop_read_csv('drdietrich/NAV_U1406322_2021.csv', dest = tempdir(), dtoken = token)
b <- drop_read_csv('drdietrich/NAV.csv', dest = tempdir(), dtoken = token) # NAV_U6136674.csv

aa <- xts(round(a[,'Total'], 0), as.Date(as.character(a[,'ReportDate']), format = "%Y%m%d"))
bb <- xts(round(b[,'Total'], 0), as.Date(as.character(b[,'ReportDate']), format = "%Y%m%d"))

c <- rbind(ROC(aa[,1], type = "discrete")['/2021-04-14'],
           ROC(bb[,1], type = "discrete")['2021-05-12/'])['2021/']
# plot.zoo(cumprod(c+1)-1)
d <- cumprod(c+1)-1
e <- seq(as.Date('2021-01-01'), Sys.Date(), 1)
f <- na.omit(setNames(na.locf(weekdays_subset(cbind(d, xts(rep(NA, length(e)), e))[,1])), 'series'))

dat <- data.frame('series'=round(f, 2))
dat$date <- as.Date(rownames(dat))
rownames(dat) <- NULL

q <- ggplot(dat, aes(x = `date`, y = `series`)) + geom_line(color = rgb(255, 40, 0, maxColorValue = 255)) + 
  xlab(NULL) + ylab(NULL) + theme_minimal() + scale_y_continuous(labels = scales::percent) +
  theme(panel.background = element_rect(fill = "transparent",colour = NA),
        plot.background = element_rect(fill = "transparent",colour = NA))

p <- ggplotly(q) %>% config(displayModeBar = FALSE) %>% layout(margin = list(l = 0, r = 0, t = 0, b = 0)) # negative margins funktioniert nicht
htmlwidgets::saveWidget(p, paste0(path, "drdie_1.html"), background = "#f8f9fa", selfcontained = F, libdir = "lib")

