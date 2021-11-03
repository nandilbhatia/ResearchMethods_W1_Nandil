* Importing the data
insheet using assignment1-research-methods.csv, tab names clear

* I am generating interaction terms myself here, I can use the # alternatively by Stata
gen malerecruiter_eliteschool 	= eliteschoolcandidate * recruiterismale
gen whiterecruiter_eliteschool 	= eliteschoolcandidate * recruiteriswhite

* I label all the variables again
label variable calledback 					"Candidate is Called Back"
label variable eliteschoolcandidate 		"Candidate from Elite College"
label variable malecandidate  				"Male Candidate"
label variable recruiteriswhite  			"Recruiter Race: White"
label variable recruiterismale  			"Recruiter Gender: Male"
label variable bigcompanycandidate 			"Candidate is a Big Company Candidate"
label variable malerecruiter_eliteschool 	"Male Recruiter x Elite College Candidate"
label variable whiterecruiter_eliteschool 	"White Recruiter x Elite College Candidate"

* I run several specifications and add all of them to final output * 

* Simple regression *
reg calledback eliteschoolcandidate
eststo regression1

* Regression with controls *
reg calledback eliteschoolcandidate recruiteriswhite recruiterismale  bigcompanycandidate
eststo regression2

* Regressions with controls and interaction terms *

reg calledback eliteschoolcandidate recruiteriswhite recruiterismale  bigcompanycandidate malerecruiter_eliteschool
eststo regression3

reg calledback eliteschoolcandidate recruiteriswhite recruiterismale  bigcompanycandidate whiterecruiter_eliteschool
eststo regression4

* Creating an output table with the stored results * 
global tableoptions "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"
esttab regression1 regression2 regression3 regression4 using Recruitment_experiment_Table.rtf, $tableoptions 
