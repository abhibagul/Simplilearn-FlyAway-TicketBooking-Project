package flyaway.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name="routes",uniqueConstraints={@UniqueConstraint(columnNames={"source","destination","date","airline"})})
public class Route {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;
	@Column(name = "source")
	private int source;
	@Column(name = "destination")
	private int destination;
	@Column(name = "price")
	private int price;
	@Column(name = "airline")
	private int airline;
	@Column(name = "date")
	private String date;
	@Column(name = "departure")
	private String departure;
	@Column(name = "arrival")
	private String arrival;
	@Column(name = "seats")
	private int seats;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSource() {
		return source;
	}
	public void setSource(int source) {
		this.source = source;
	}
	public int getDestination() {
		return destination;
	}
	public void setDestination(int destination) {
		this.destination = destination;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getAirline() {
		return airline;
	}
	public void setAirline(int airline) {
		this.airline = airline;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	public String getDeparture() {
		return departure;
	}
	public void setDeparture(String departure) {
		this.departure = departure;
	}
	public String getArrival() {
		return arrival;
	}
	public void setArrival(String arrival) {
		this.arrival = arrival;
	}
	public int getSeats() {
		return seats;
	}
	public void setSeats(int seats) {
		this.seats = seats;
	}
	public Route() {
		super();
	}
	public Route( int source, int destination, int price, int airline, String date, String departure,
			String arrival, int seats) {
		super();
		this.source = source;
		this.destination = destination;
		this.price = price;
		this.airline = airline;
		this.date = date;
		this.departure = departure;
		this.arrival = arrival;
		this.seats = seats;
	}
	
	public Route(int id, int source, int destination, int price, int airline, String date, String departure,
			String arrival, int seats) {
		super();
		this.id = id;
		this.source = source;
		this.destination = destination;
		this.price = price;
		this.airline = airline;
		this.date = date;
		this.departure = departure;
		this.arrival = arrival;
		this.seats = seats;
	}
	
	
	
	
	
	
}
