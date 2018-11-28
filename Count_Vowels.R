words <- readLines("words.txt")

Number_of_Vowels <- stringr::str_count(words, "[aeiou]")
Count_Number_of_Vowels <- table(Number_of_Vowels) # how many words with 1,2,3,... etc. vowels
write.table(Count_Number_of_Vowels, "Count_Vowels.tsv",
						sep = "\t", row.names = FALSE, quote = FALSE)


