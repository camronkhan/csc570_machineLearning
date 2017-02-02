# --------------------
#       Factors
# --------------------


gender <- factor(c("MALE", "FEMALE", "MALE"))
gender

blood <- factor(c("O", "AB", "A"), levels=c("A", "B", "AB", "O"))
blood[1:2]

symptoms <- factor(c("SEVERE", "MILD", "MODERATE"), levels=c("MILD", "MODERATE", "SEVERE"), ordered=TRUE)
symptoms
symptoms > "MODERATE"
symptoms[symptoms > "MODERATE"]
