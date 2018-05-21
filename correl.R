#!/usr/bin/env Rscript

data <- read.csv("counts.csv", header=FALSE)

vals = list()

vals$Kind = data$V1[data$V2 == "Kind"]
vals$Grade = data$V1[data$V2 == "Grade"]

x11()
boxplot(vals,
        xlab='Response to "What is more important, being kind or getting a good grade?"',
        ylab='Word count of response to "What stresses you out?"',
        main='Grade Focus vs Stress Level')

Sys.sleep(1000)
