package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"time"
)

type Play struct {
	name      string
	purchased []Ticket
	showStart time.Time
	showEnd   time.Time
}

type Ticket struct {
	customer     string
	selectedSeat *Seat
	show         *Show
}

type Theatre struct {
	seats []Seat
	shows []Show
}

type Category struct {
	name      string
	basePrice float32
}

type Seat struct {
	number   int32
	row      int32
	category *Category
}

type Show interface {
	getName() string
	getLastCustomerName() string
	getShowStart() time.Time
	getShowEnd() time.Time
	addPurchase(*Ticket) bool
	isNotPurchased(*Ticket) bool
	changeLastAddedName(string) // Changes the last customer's name
	printShow()                 // Prints the show's characteristics
	soldOut(string) bool        // Checks is a category is sold out
}

type Comedy struct {
	laughs float32
	deaths int32
	Play
}

// Interface implementation for type Comedy
func (c *Comedy) getName() string {
	return c.Play.name
}

func (c *Comedy) getLastCustomerName() string {
	lastCustomerAdded := len(c.Play.purchased) - 1
	return c.Play.purchased[lastCustomerAdded].customer
}

func (c *Comedy) getShowStart() time.Time {
	return c.Play.showStart
}

func (c *Comedy) getShowEnd() time.Time {
	return c.Play.showEnd
}

func (c *Comedy) addPurchase(t *Ticket) bool {
	if c.isNotPurchased(t) {
		c.Play.purchased = append(c.Play.purchased, (*t))
		return true
	}
	return false
}

func (c *Comedy) isNotPurchased(t *Ticket) bool {
	for _, s := range c.Play.purchased {
		if s.selectedSeat.number == t.selectedSeat.number {
			return false
		}
	}
	return true
}

func (c *Comedy) changeLastAddedName(newName string) {
	lastCustomerAdded := len(c.Play.purchased) - 1
	c.Play.purchased[lastCustomerAdded].customer = newName
}

func (c *Comedy) printShow() {
	fmt.Println("Comedy show")
	fmt.Println("Name: ", c.getName())
	fmt.Println("Start: ", c.getShowStart())
	fmt.Println("End: ", c.getShowEnd())
	fmt.Println()
}

func (c *Comedy) soldOut(cat string) bool {
	var count int32
	for _, item := range c.Play.purchased {
		if item.selectedSeat.category.name == cat {
			count += 1
		}
	}
	if cat == "prime" && count >= 5 {
		return true
	} else if cat == "standard" && count >= 15 {
		return true
	} else if cat == "special" && count >= 5 {
		return true
	}
	return false
}

type Tragedy struct {
	laughs float32
	deaths int32
	Play
}

// Interface implementation for type Tragedy
func (tra *Tragedy) getName() string {
	return tra.Play.name
}

func (tra *Tragedy) getLastCustomerName() string {
	lastCustomerAdded := len(tra.Play.purchased) - 1
	return tra.Play.purchased[lastCustomerAdded].customer
}

func (tra *Tragedy) getShowStart() time.Time {
	return tra.Play.showStart
}

func (tra *Tragedy) getShowEnd() time.Time {
	return tra.Play.showEnd
}

func (tra *Tragedy) addPurchase(t *Ticket) bool {
	if tra.isNotPurchased(t) {
		tra.Play.purchased = append(tra.Play.purchased, (*t))
		return true
	}
	return false
}

func (tra *Tragedy) isNotPurchased(t *Ticket) bool {
	for _, s := range tra.Play.purchased {
		if s.selectedSeat.number == t.selectedSeat.number {
			return false
		}
	}
	return true
}

func (t *Tragedy) changeLastAddedName(newName string) {
	lastCustomerAdded := len(t.Play.purchased) - 1
	t.Play.purchased[lastCustomerAdded].customer = newName
}

func (t *Tragedy) printShow() {
	fmt.Println("Tragedy show")
	fmt.Println("Name: ", t.getName())
	fmt.Println("Start: ", t.getShowStart())
	fmt.Println("End: ", t.getShowEnd())
	fmt.Println()
}

func (t *Tragedy) soldOut(cat string) bool {
	var count int32
	for _, item := range t.Play.purchased {
		//fmt.Println("item.selectedSeat.category.name: ", item.selectedSeat.category.name)
		//fmt.Println("cat: ", cat)
		if item.selectedSeat.category.name == cat {
			count += 1
		}
	}
	if cat == "prime" && count >= 5 {
		return true
	} else if cat == "standard" && count >= 15 {
		return true
	} else if cat == "special" && count >= 5 {
		return true
	}
	return false
}

func NewTragedy(laughs float32, deaths int32, play Play) *Tragedy {
	tragedy := Tragedy{}

	// As the default is already 0
	tragedy.laughs = laughs

	if deaths == 0 {
		deaths = 12
	}
	tragedy.deaths = deaths

	if play.name == "" {
		play.name = "Macbeth"
		play.purchased = make([]Ticket, 0, 0)
		play.showStart = time.Date(2020, time.April, 16, 9, 30, 0, 0, time.UTC)
		play.showEnd = time.Date(2020, time.April, 16, 12, 30, 0, 0, time.UTC)
	}
	tragedy.Play = play

	return &tragedy
}

func NewComedy(laughs float32, deaths int32, play Play) *Comedy {
	comedy := Comedy{}

	if laughs == 0 {
		laughs = 0.2
	}
	comedy.laughs = laughs

	// As the default is already 0
	comedy.deaths = deaths

	if play.name == "" {
		play.name = "Tartuffe"
		play.purchased = make([]Ticket, 0, 0)
		play.showStart = time.Date(2020, time.March, 3, 16, 0, 0, 0, time.UTC)
		play.showEnd = time.Date(2020, time.March, 3, 17, 20, 0, 0, time.UTC)
	}
	comedy.Play = play

	return &comedy
}

func NewSeat(seatNumber int32, rowNumber int32, category *Category) *Seat {
	selectedSeat := Seat{}

	if seatNumber == 0 {
		seatNumber = 1
	}
	selectedSeat.number = seatNumber

	if rowNumber == 0 {
		rowNumber = 1
	}
	selectedSeat.row = rowNumber

	if category.name == "" {
		category.name = "Standard"
		category.basePrice = 25.0
	}
	selectedSeat.category = category

	return &selectedSeat
}

func NewTicket(name string, selectedSeat *Seat, show *Show) *Ticket {
	ticket := Ticket{}
	ticket.customer = name
	ticket.selectedSeat = selectedSeat
	ticket.show = show
	return &ticket
}

func NewTheatre(nSeats int32, shows []Show) *Theatre {
	theatre := Theatre{}
	theatre.shows = shows
	theatre.seats = make([]Seat, 0, nSeats)
	return &theatre
}

func NewPlay(name string, size int32, showStart time.Time, showEnd time.Time) Play {
	play := Play{}
	play.name = name
	play.purchased = make([]Ticket, 0, size)
	play.showStart = showStart
	play.showEnd = showEnd
	return play
}

func checkRowNumber(seat int32) (int32, string, float32) {
	if seat <= 5 {
		return 1, "prime", 35.0
	} else if seat >= 6 && seat <= 10 {
		return 2, "standard", 25.0
	} else if seat >= 11 && seat <= 15 {
		return 3, "standard", 25.0
	} else if seat >= 16 && seat <= 20 {
		return 4, "standard", 25.0
	} else {
		return 5, "special", 15.0
	}
}

func main() {
	// Instantiating plays
	comedyPlay := NewPlay(
		"Volpone",
		0,
		time.Date(2020, time.March, 3, 19, 30, 0, 0, time.UTC),
		time.Date(2020, time.March, 3, 22, 0, 0, 0, time.UTC),
	)
	tragedyPlay := NewPlay(
		"Hamlet",
		0,
		time.Date(2020, time.April, 10, 20, 0, 0, 0, time.UTC),
		time.Date(2020, time.April, 10, 23, 0, 0, 0, time.UTC),
	)

	// Instantiating shows and theatre
	comedy := NewComedy(50, 5, comedyPlay)
	tragedy := NewTragedy(5, 50, tragedyPlay)
	shows := []Show{comedy, tragedy}
	var theatre = NewTheatre(25, shows)

	var selectedShowNumber int
	var selectedSeatNumber int32
	scanner := bufio.NewScanner(os.Stdin)

	theatre.shows[0].printShow()
	theatre.shows[1].printShow()

	for {

		// Prompts for a show
		for {

			fmt.Print("Type '0' for comedy or '1' for tragedy: ")
			scanner.Scan()
			input := scanner.Text()
			selectedShowNumber, _ = strconv.Atoi(input)

			if selectedShowNumber == 0 || selectedShowNumber == 1 {
				fmt.Print("\nYou have selected ")
				if selectedShowNumber == 0 {
					fmt.Println("comedy")
				} else {
					fmt.Println("tragedy")
				}
				break
			} else {
				fmt.Println("Invalid show input")
			}
		}

		var showOrSeat int32 = 2
		var lowerBound int32 = 1
		var upperBound int32 = 25

		fmt.Println("\nSelect a seat:\n",
			"1 to 5, prime\n",
			"6 to 20, standard\n",
			"21 to 25, special",
		)

		// Prompts for a seat
		for {
			if showOrSeat == 0 {
				break
			}

			scanner.Scan()
			input := scanner.Text()
			selectedSeatNumberTemp, _ := strconv.Atoi(input)
			selectedSeatNumber = int32(selectedSeatNumberTemp)

			if selectedSeatNumber >= lowerBound && selectedSeatNumber <= upperBound {
				var rowNumber, categoryName, price = checkRowNumber(selectedSeatNumber)

				category := Category{categoryName, price}
				categoryPointer := &category
				seat := NewSeat(
					selectedSeatNumber,
					rowNumber,
					categoryPointer,
				)
				ticket := NewTicket(
					"",
					seat,
					&shows[selectedShowNumber],
				)
				if shows[selectedShowNumber].addPurchase(ticket) {
					fmt.Print("\nEnter your name: ")
					scanner.Scan()
					customerName := scanner.Text()
					fmt.Println("The customerName is:", customerName)
					shows[selectedShowNumber].changeLastAddedName(customerName)

					fmt.Println("Customer",
						shows[selectedShowNumber].getLastCustomerName(),
						", your ticket for the play:",
						shows[selectedShowNumber].getName(),
						", seat:",
						selectedSeatNumber,
						"has been purchased",
					)
					break
				} else {
					if shows[selectedShowNumber].soldOut(categoryName) {
						fmt.Println("This category has been sold out")
						primeSoldOut := shows[selectedShowNumber].soldOut("prime")
						standardSoldOut := shows[selectedShowNumber].soldOut("standard")
						specialSoldOut := shows[selectedShowNumber].soldOut("special")

						// I understood that, after a category is full, the
						// next recomendation should be the cheapest one
						if categoryName == "special" {
							if !standardSoldOut {
								fmt.Println("But we still have seats for the standard category")
								lowerBound = 6
								upperBound = 20
							} else if !primeSoldOut {
								fmt.Println("But we still have seats for the prime category")
								lowerBound = 1
								upperBound = 5
							} else {
								fmt.Println("Unfortunately all the tickets for the",
									shows[selectedShowNumber].getName(),
									"play have been sold out\n",
									"Please select another play\n",
								)
							}
						} else if categoryName == "standard" {
							if !specialSoldOut {
								fmt.Println("But we still have seats for the special category")
								lowerBound = 21
								upperBound = 25
							} else if !primeSoldOut {
								fmt.Println("But we still have seats for the prime category")
								lowerBound = 1
								upperBound = 5
							} else {
								fmt.Println("Unfortunately all the tickets for the",
									shows[selectedShowNumber].getName(),
									"play have been sold out\n",
									"Please select another play\n",
								)
							}
						} else {
							if !specialSoldOut {
								fmt.Println("But we still have seats for the special category")
								lowerBound = 21
								upperBound = 25
							} else if !standardSoldOut {
								fmt.Println("But we still have seats for the standard category")
								lowerBound = 6
								upperBound = 20
							} else {
								fmt.Println("Unfortunately all the tickets for the",
									shows[selectedShowNumber].getName(),
									"play have been sold out\n",
									"Please select another play\n",
								)
							}
						}
					} else {
						if categoryName == "prime" {
							lowerBound = 1
							upperBound = 5
						} else if categoryName == "standard" {
							lowerBound = 6
							upperBound = 20
						} else {
							lowerBound = 21
							upperBound = 25
						}
						fmt.Println("This seat has already been purchased.\n")
					}

					for {
						fmt.Println("Select 0 to choose another play or 1",
							"to choose another seat: ",
						)

						scanner.Scan()
						input := scanner.Text()
						showOrSeatTemp, _ := strconv.Atoi(input)
						showOrSeat = int32(showOrSeatTemp)

						if showOrSeat == 0 {
							break
						} else if showOrSeat == 1 {
							fmt.Println("Select a new seat in the range:",
								lowerBound, "to", upperBound,
							)
							break
						} else {
							fmt.Println("Invalid show input")
						}
					}
				}
			} else {
				fmt.Println("Invalid seat input")
			}
		}
	}
}
