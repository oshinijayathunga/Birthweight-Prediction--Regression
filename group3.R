attach(babies) ##forward selection
summary(lm(bwt~1))
summary(lm(bwt~gestation))
summary(lm(bwt~as.factor(parity)))
anova(lm(bwt~gestation))
summary(lm(bwt~age))
summary(lm(bwt~height))
summary(lm(bwt~weight))
summary(lm(bwt~as.factor(smoke)))

summary(lm(bwt~gestation+as.factor(parity)))
summary(lm(bwt~gestation+age))
summary(lm(bwt~gestation+height))
summary(lm(bwt~gestation+weight))
summary(lm(bwt~gestation+as.factor(smoke)))

summary(lm(bwt~gestation+as.factor(smoke)+as.factor(parity)))
summary(lm(bwt~gestation+as.factor(smoke)+age))
summary(lm(bwt~gestation+as.factor(smoke)+height))
summary(lm(bwt~gestation+as.factor(smoke)+weight))

summary(lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)))
summary(lm(bwt~gestation+as.factor(smoke)+height+age))
summary(lm(bwt~gestation+as.factor(smoke)+height+weight))

summary(lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+age))
summary(lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight))
anova(lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight))

m<-lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight,data = babies) #main effects model
plot(m)
hist(resid(m))

##standard residuals VS fitted values plot
plot(fitted(m),rstandard(m))
lines(lowess(fitted(m), rstandard(m)), col = "blue", lwd = 2)

library(car)##checking multicolinearity
vif(m)

plot(gestation,bwt)
plot(lm(bwt~gestation))
plot(lm(bwt~weight))
plot(lm(bwt~height))
plot(parity,bwt)
plot(smoke,bwt)
plot(height,bwt)
plot(weight,bwt)

hist(bwt)
##adding interaction terms
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+gestation*as.factor(parity))
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+gestation*height)
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+gestation*weight)
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+gestation*as.factor(smoke))
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+as.factor(parity)*height)
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+as.factor(parity)*weight)
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+as.factor(parity)*as.factor(smoke))
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+height*as.factor(smoke))
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+weight*as.factor(smoke))
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+height*weight)
summary(mlr_1)

mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+gestation*as.factor(smoke)+gestation*parity)
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+gestation*as.factor(smoke)+gestation*height)
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+gestation*as.factor(smoke)+gestation*weight)
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+gestation*as.factor(smoke)+parity*height)
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+gestation*as.factor(smoke)+parity*weight)
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+gestation*as.factor(smoke)+parity*as.factor(smoke))
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+gestation*as.factor(smoke)+height*as.factor(smoke))
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+gestation*as.factor(smoke)+weight*as.factor(smoke))
summary(mlr_1)
mlr_1=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+gestation*as.factor(smoke)+weight*height)
summary(mlr_1)

##model with interaction terms
mlr_i=lm(bwt~gestation+as.factor(smoke)+height+as.factor(parity)+weight+gestation*as.factor(smoke))
summary(mlr_i)
plot(mlr_i)

##final model with interaction terms and polynomial terms
mlr_2=lm(bwt~gestation+gestation^2+as.factor(smoke)+height+height^2+as.factor(parity)+weight+weight^2+gestation*as.factor(smoke),data = babies)
summary(mlr_2)
anova(mlr_2)
plot(mlr_2)

##standard residual VS fitted values plot
plot(fitted(mlr_2),rstandard(mlr_2))

lines(lowess(fitted(mlr_2), rstandard(mlr_2)), col = "blue", lwd = 2)

##finding influential points
library(car)
influencePlot(m, id.method="identify")
babies_clean <- babies[-c(261, 435, 530, 870), ]

model_clean <- lm(bwt~gestation+gestation^2+as.factor(smoke)+height+height^2+as.factor(parity)+weight+weight^2+gestation*as.factor(smoke),data = babies)
summary(model_clean)


##Ordinal model

attach(babies)
install.packages("ordinal")
library(ordinal)
babies$weight_status<-ordered(babies$weight_status,levels=c("Underweight","Normalweight","Overweight"))
summary(clm(weight_status~1,data=babies))

summary(clm(weight_status~gestation,data=babies))
summary(clm(weight_status~as.factor(parity),data=babies))
summary(clm(weight_status~age,data=babies))
summary(clm(weight_status~height,data=babies))
summary(clm(weight_status~weight,data=babies))
summary(clm(weight_status~as.factor(smoke),data=babies))
#gestation enters as the first variable

summary(clm(weight_status~gestation+as.factor(parity),data=babies))
summary(clm(weight_status~gestation+age,data=babies))
summary(clm(weight_status~gestation+height,data=babies))
summary(clm(weight_status~gestation+weight,data=babies))
summary(clm(weight_status~gestation+as.factor(smoke),data=babies))
#height enters next

summary(clm(weight_status~gestation+height+as.factor(parity),data=babies))
summary(clm(weight_status~gestation+height+age,data=babies))
summary(clm(weight_status~gestation+height+weight,data=babies))
summary(clm(weight_status~gestation+height+as.factor(smoke),data=babies))
#smoke enters next

summary(clm(weight_status~gestation+height+as.factor(smoke)+as.factor(parity),data=babies))
summary(clm(weight_status~gestation+height+as.factor(smoke)+age,data=babies))
summary(clm(weight_status~gestation+height+as.factor(smoke)+weight,data=babies))
#parity enters next

summary(clm(weight_status~gestation+height+as.factor(smoke)+as.factor(parity)+age,data=babies))
summary(clm(weight_status~gestation+height+as.factor(smoke)+as.factor(parity)+weight,data=babies))
#no other variable enters the model

summary(clm(weight_status~gestation+height+as.factor(smoke)+as.factor(parity),data=babies))
anova(clm(weight_status~gestation+height+as.factor(smoke)+as.factor(parity),data=babies))
mlr=weight_status~gestation+height+as.factor(smoke)+as.factor(parity)

#to check if any interaction terms will be significant, to improve the model
library(MASS)
fit <- polr(mlr, data = babies, method = "logistic")
deviance(fit)

fit <- polr(weight_status~gestation+height+as.factor(smoke)+as.factor(parity)+gestation*as.factor(smoke), data = babies, method = "logistic")
deviance(fit)
fit <- polr(weight_status~gestation+height+as.factor(smoke)+as.factor(parity)+gestation*height, data = babies, method = "logistic")
deviance(fit)

#final model
summary(clm(weight_status~gestation+height+as.factor(smoke)+as.factor(parity)+gestation*as.factor(smoke),data=babies))
anova(clm(weight_status~gestation+height+as.factor(smoke)+as.factor(parity)+gestation*as.factor(smoke),data=babies))
