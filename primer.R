setwd("C:/Users/los40/Desktop/Treball Mineria/train")
setwd(list.files()[1])
exp<-data.frame("Imagen"=(list.files()), "Tipo"="Type_1")
setwd("C:/Users/los40/Desktop/Treball Mineria/train")
setwd(list.files()[2])
exp2<-data.frame("Imagen"=(list.files()), "Tipo"="Type_2")
setwd("C:/Users/los40/Desktop/Treball Mineria/train")
setwd(list.files()[3])
exp3<-data.frame("Imagen"=(list.files()), "Tipo"="Type_3")
data<-rbind(exp,exp2,exp3)

#install.packages("jpeg")
#install.packages("fields")
#install.packages("MXNet")
#source("http://bioconductor.org/biocLite.R")
library(jpeg);library(fields)
biocLite("EBImage")
library(EBImage)
setwd("C:/Users/los40/Desktop/Treball Mineria/train/Type_1")

#imatge 10.jpg de 3096x4128

x<-(readJPEG(list.files()[1]))
dim(x)[1:2]
y <- resize(x, w = 50, h = 25)
y <- resize(x, dim(x)[1]/30)
plot(as.raster(y))
dim(y)[1:2]

#thresholding
nmask = thresh(y, w=10, h=10, offset=0.05)
nmask = opening(nmask, makeBrush(5, shape='disc'))
nmask = fillHull(nmask)
nmask = bwlabel(nmask)

display(nmask, all=TRUE)

#segmentacio
ctmask = opening(y>0.1, makeBrush(5, shape='disc'))
cmask = propagate(y, seeds=nmask, mask=ctmask)

display(ctmask)

segmented = paintObjects(cmask, y, col='#ff00ff')
segmented = paintObjects(nmask, segmented, col='#ffff00')

display(segmented, all=TRUE)

plot(as.raster(segmented))

###QUE ES THRESHOLDING:
threshold = otsu(y)
threshold
