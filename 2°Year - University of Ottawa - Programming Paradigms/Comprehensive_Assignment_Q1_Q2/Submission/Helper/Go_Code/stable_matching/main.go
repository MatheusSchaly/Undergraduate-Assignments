// stable_matching project main.go
package main

import (
	"bufio"
	"encoding/csv"
	"fmt"
	"io"
	"log"
	"os"
	"strconv"
	"sync"
	"time"
)

var file_size int
var employers = make(map[string][]string)
var students = make(map[string][]string)
var employers_copy = make(map[string][]string)
var students_copy = make(map[string][]string)
var employers_unmatched = make([]string, 0) // List of matched students
var students_unmatched = make([]string, 0)  // List of unmatched students
var M = make(map[string]string)             // Finals matchs
var c_map chan int = make(chan int, 1)      // Channel to control concurrency
var wg sync.WaitGroup                       // WaitGroup so that program doesn't instantly finishes

func main() {
	argsWithoutProg := os.Args[1:]
	employers = read_csv(argsWithoutProg[0], true)
	students = read_csv(argsWithoutProg[1], false)
	employers_copy = copy_map(employers)
	students_copy = copy_map(students)
	employers_unmatched = copy_map_values(students)
	students_unmatched = copy_map_values(employers)
	McVitie_Wilson()
	write_csv()
}

// McVitie_Wilson recursive algorithm
func McVitie_Wilson() {
	c_map <- 1
	for e, _ := range employers { // Ranges over all employers once
		wg.Add(1)
		go offer(e)
		wg.Done()
	}
	time.Sleep(time.Second / 5) // Allow time to safely enter the go routine
	wg.Wait()
}

func offer(e string) {
	wg.Add(1)
	<-c_map
	if check_unmatched(e, true) { // If employer is unmatched
		if len(employers_copy[e]) > 0 { // If employer still has students to evaluate
			s := employers_copy[e][0] // Selects the best student
			remove_student(e, 0)      // Marks best student as "already offered a job"
			evaluate(e, s)
		}
	} else {
		c_map <- 1
	}
	wg.Done()
}

func evaluate(e string, s string) {
	if check_unmatched(s, false) { // Is student is unmatched
		M[e] = s                   // Matches student with employer
		remove_unmatched(s, false) // Remove student from unmatched list
		c_map <- 1
	} else if get_student_rank(e, s) < get_student_rank(get_student_match(s), s) { // If student prefers new employer
		new_e_unmatched := get_student_match(s)                            // Gets the previous employer matched with student
		employers_unmatched = append(employers_unmatched, new_e_unmatched) // Sets previous employer as unmatched
		remove_unmatched(e, true)                                          // Removes the new employer from unmatched
		M[e] = s                                                           // Matches student with employer
		c_map <- 1
		go offer(new_e_unmatched)
	} else { // Student is already matched and prefers current employer
		c_map <- 1
		go offer(e)
	}
}

// Removes the employer or student (if is_employer is true, removes employer)
// from its respective unmatched list
func remove_unmatched(e_or_s string, is_employer bool) {
	var list_pointer []string
	if is_employer {
		list_pointer = employers_unmatched
	} else {
		list_pointer = students_unmatched
	}
	for i, employer_or_student := range list_pointer {
		if e_or_s == employer_or_student {
			copy(list_pointer[i:], list_pointer[i+1:])
			list_pointer[len(list_pointer)-1] = ""
			list_pointer = list_pointer[:len(list_pointer)-1]
			break
		}
	}
}

// Removes student from the employers dictonary, that is,
// employer has already offered a job to that student
func remove_student(e string, i int) {
	copy(employers_copy[e][i:], employers_copy[e][i+1:])
	employers_copy[e][len(employers_copy[e])-1] = ""
	employers_copy[e] = employers_copy[e][:len(employers_copy[e])-1]
}

// Gets the employer that is matched with the student
func get_student_match(s string) string {
	for k, v := range M {
		if s == v {
			return k
		}
	}
	return ""
}

// Gets the rank of the employer "e" according to the student "s"
func get_student_rank(e string, s string) int {
	for i, employer := range students_copy[s] {
		if e == employer {
			return i
		}
	}
	return -1
}

// Check if the employer or student (if is_employer is true, checks employer)
// from its respective unmatched list
func check_unmatched(s_e string, is_employer bool) bool {
	var list_pointer []string
	if is_employer {
		list_pointer = employers_unmatched
	} else {
		list_pointer = students_unmatched
	}
	for _, e := range list_pointer {
		if s_e == e {
			return true
		}
	}
	return false
}

// Copies only the values of a map
func copy_map_values(m map[string][]string) []string {
	m_values := make([]string, 0)
	for _, v := range m {
		for _, i := range v {
			m_values = append(m_values, i)
		}
		break
	}
	return m_values
}

// Copies the whole map
func copy_map(m map[string][]string) map[string][]string {
	m_copy := make(map[string][]string)
	for k, v := range m {
		m_copy[k] = v
	}
	return m_copy
}

// Reads the csv file (if is_employer is true, reads the employer file)
func read_csv(file_name string, is_employer bool) map[string][]string {
	file_size = 0
	m := make(map[string][]string)
	csvFile, _ := os.Open(file_name)
	reader := csv.NewReader(bufio.NewReader(csvFile))
	var key string
	first_read := true
	for {
		line, error := reader.Read()
		if error == io.EOF {
			break
		} else if error != nil {
			log.Fatal(error)
		}
		file_size = len(line) - 1
		for i := 0; i < len(line); i++ {
			if i == 0 {
				// Golang appends invisible characters to the first input read from a determined csv file, so
				// if you are having incorrect answers, uncomment the lines from 191 to 196 and from 200 to
				// 204 and comment the lines 197, 198 and 205. Also change the "Thales" at line 199 to the first element
				// of your csv file. For example, in our 3x3 employers csv file the fist element is "Thales"
				// if first_read && is_employer { // Golang having problems reading first element from csv
				// 	key = "Tentative"
				// 	first_read = false
				// } else {
				// 	key = line[0]
				// }
				first_read = false
				key = line[0]
			} else {
				// if line[i] == "Thales" { // Golang having problems reading first element from csv
				// 	m[key] = append(m[key], "Tentative")
				// } else {
				// 	m[key] = append(m[key], line[i])
				// }
				m[key] = append(m[key], line[i])
			}
		}
	}
	if first_read {
	} // Dumb "if" so that GoLang doesn't complain about not using variable (due to csv errors)
	return m
}

func write_csv() {
	size := strconv.Itoa(file_size)
	output_file_name := "matches_go_" + size + "x" + size + ".csv"
	csvFile, err := os.Create(output_file_name)
	if err != nil {
		log.Fatalf("failed creating file: %s", err)
	}
	csvwriter := csv.NewWriter(csvFile)

	empData := make([][]string, file_size)

	i := 0
	for e, s := range M {
		empData[i] = append(empData[i], "Pair: ")
		empData[i] = append(empData[i], e)
		empData[i] = append(empData[i], " - ")
		empData[i] = append(empData[i], s)
		i++
	}

	for _, empRow := range empData {
		_ = csvwriter.Write(empRow)
	}

	fmt.Printf("The file %s has been successfully created.\n", output_file_name)

	csvwriter.Flush()
	csvFile.Close()
}
