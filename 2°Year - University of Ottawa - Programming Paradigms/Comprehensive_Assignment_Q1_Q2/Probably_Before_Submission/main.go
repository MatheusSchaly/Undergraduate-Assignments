// stable_matching project main.go
package main

import (
	"bufio"
	"encoding/csv"
	"fmt"
	"io"
	"log"
	"os"
)

var employers = make(map[string][]string)
var students = make(map[string][]string)
var employers_copy = make(map[string][]string)
var students_copy = make(map[string][]string)
var employers_unmatched = make([]string, 0)
var students_unmatched = make([]string, 0)
var M = make(map[string]string)
var i int

func main() {
	employers = read_csv("coop_e_4x4.csv")
	students = read_csv("coop_s_4x4.csv")
	employers_copy = copy_map(employers)
	students_copy = copy_map(students)
	employers_unmatched = copy_map_values(students)
	students_unmatched = copy_map_values(employers)
	fmt.Println("employers:", employers)
	fmt.Println("students:", students)
	fmt.Println("employers_copy:", employers_copy)
	fmt.Println("students_copy:", students_copy)
	fmt.Println("employers_unmatched:", employers_unmatched)
	fmt.Println("students_unmatched:", students_unmatched)
	fmt.Println()
	McVitie_Wilson()
	fmt.Println(M)
}

func McVitie_Wilson() {
	for e, _ := range employers {
		fmt.Println("\nFirst employer:", e)
		offer(e)
	}
}

func offer(e string) {
	fmt.Println("Check unmatched:", check_unmatched(e, true))
	if check_unmatched(e, true) {
		fmt.Println("len(employers_copy[e]) > 0:", len(employers_copy[e]) > 0)
		if len(employers_copy[e]) > 0 {
			s := employers_copy[e][0]
			fmt.Println("employers_copy[e]:", employers_copy[e])
			fmt.Println("employers_copy[e][0]:", employers_copy[e][0])
			remove_student(e, 0)
			evaluate(e, s)
		}
	}
}

func evaluate(e string, s string) {
	fmt.Println("\nHERE!:", e, s)
	fmt.Println("HERE!!:", get_student_rank(e, s))
	fmt.Println("HERE!!!:", get_student_match(s))
	fmt.Println("HERE!!!!:", get_student_rank(get_student_match(s), s))
	if check_unmatched(s, false) {
		M[e] = s
		remove_unmatched_student(s)
		fmt.Println("M:", M)
	} else if get_student_rank(e, s) < get_student_rank(get_student_match(s), s) {
		new_unmatched := get_student_match(s)
		employers_unmatched = append(employers_unmatched, new_unmatched)
		remove_unmatched(e)
		M[e] = s
		offer(new_unmatched)
	} else {
		i++
		if i == 10 {
			return
		}
		offer(e)
	}
}

func remove_unmatched(e string) {
	for i, employer := range employers_unmatched {
		if e == employer {
			copy(employers_unmatched[i:], employers_unmatched[i+1:])
			employers_unmatched[len(employers_unmatched)-1] = ""
			employers_unmatched = employers_unmatched[:len(employers_unmatched)-1]
			break
		}
	}
}

func remove_unmatched_student(e string) {
	for i, employer := range students_unmatched {
		if e == employer {
			copy(students_unmatched[i:], students_unmatched[i+1:])
			students_unmatched[len(students_unmatched)-1] = ""
			students_unmatched = students_unmatched[:len(students_unmatched)-1]
			break
		}
	}
}

func remove_student(e string, i int) {
	copy(employers_copy[e][i:], employers_copy[e][i+1:])
	employers_copy[e][len(employers_copy[e])-1] = ""
	employers_copy[e] = employers_copy[e][:len(employers_copy[e])-1]
}

func get_student_match(s string) string {
	for k, v := range M {
		if s == v {
			return k
		}
	}
	return ""
}

func get_student_rank(e string, s string) int {
	for i, employer := range students_copy[s] {
		if e == employer {
			return i
		}
	}
	return -1
}

func check_unmatched(s_e string, employers_bool bool) bool {
	var list_pointer []string
	if employers_bool {
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

func copy_map(m map[string][]string) map[string][]string {
	m_copy := make(map[string][]string)
	for k, v := range m {
		m_copy[k] = v
	}
	return m_copy
}

func read_csv(file_name string) map[string][]string {
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
		for i := 0; i < len(line); i++ {
			if i == 0 {
				if first_read { // Golang having problems reading first element from csv
					key = "Tentative"
					first_read = false
				} else {
					key = line[0]
				}
			} else {
				if line[i] == "Ryan" { // Golang having problems reading first element from csv
					m[key] = append(m[key], "Tentative")
				} else {
					m[key] = append(m[key], line[i])
				}
			}
		}
	}
	return m
}
