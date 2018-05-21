#!/usr/bin/env Rscript

data <- read.csv("counts.csv", header=FALSE)

vals = list()

vals$Kind = data$V1[data$V3 == "Kind"]
vals$Grade = data$V1[data$V3 == "Grade"]

x11()
boxplot(vals,
        xlab='Response to "What is more important, being kind or getting a good grade?"',
        ylab='Word count of response to "What stresses you out?"',
        main='Grade Focus vs Stress Level')
t.test(vals$Kind, vals$Grade)

x11()
plot(data$V1, data$V2)
abline(lm(data$V2 ~ data$V1))
cor(data$V1, data$V2)

Sys.sleep(1000)
