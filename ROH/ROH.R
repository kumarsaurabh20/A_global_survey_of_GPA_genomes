library(detectRUNS)
dir()
mapFilePath <- "peach_tobacco.map"
genotypeFilePath <- "peach_tobacco.ped"
slidingRuns <- slidingRUNS.run(genotypeFile = genotypeFilePath, mapFile = mapFilePath, windowSize = 15, threshold = 0.05,minSNP = 20, ROHet = FALSE, maxOppWindow = 1, maxMissWindow = 1, maxGap = 10^6, minLengthBps = 250000, minDensity = 3.4/10^3, maxOppRun = NULL, maxMissRun = NULL)
summaryList <- summaryRuns(runs = slidingRuns, mapFile = mapFilePath, genotypeFile = genotypeFilePath, Class = 6, snpInRuns = TRUE)
summaryList$summary_ROH_count
summaryList$summary_ROH_mean_chr
head(summaryList$SNPinRun)
plot_Runs(runs = slidingRuns)
pdf('sliding_windows.pdf')
plot_Runs(runs = slidingRuns)
dev.off()
png('test.png')
plot_Runs(runs = slidingRuns)
quit()
