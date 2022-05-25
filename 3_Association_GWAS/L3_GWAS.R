library(qqman)
system("plink --bfile HapMap_3_r3_13 --assoc --out assoc_results")


system("plink --bfile HapMap_3_r3_13 --covar covar_mds.txt --logistic --hide-covar --out logistic_results")


system("awk '!/'NA'/' logistic_results.assoc.logistic > logistic_results.assoc_2.logistic")

system("plink --bfile HapMap_3_r3_13 -assoc --adjust --out adjusted_assoc_results")

results_log <- read.table("logistic_results.assoc_2.logistic", head=TRUE)
jpeg("Logistic_manhattan.jpeg")
manhattan(results_log,chr="CHR",bp="BP",p="P",snp="SNP", main = "Manhattan plot: logistic")
dev.off()

results_as <- read.table("assoc_results.assoc", head=TRUE)
jpeg("assoc_manhattan.jpeg")
manhattan(results_as,chr="CHR",bp="BP",p="P",snp="SNP", main = "Manhattan plot: assoc")
dev.off()  


jpeg("QQ-Plot_logistic.jpeg")
qq(results_log$P, main = "Q-Q plot of GWAS p-values : log")
dev.off()

results_as <- read.table("assoc_results.assoc", head=TRUE)
jpeg("QQ-Plot_assoc.jpeg")
qq(results_as$P, main = "Q-Q plot of GWAS p-values : log")
dev.off()


