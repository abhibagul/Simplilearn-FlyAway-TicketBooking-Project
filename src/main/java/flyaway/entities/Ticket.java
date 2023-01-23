package flyaway.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="tickets")
public class Ticket {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;
	@Column(name = "passanger_first_name", nullable = false)
	private String passangerFirstName;
	@Column(name = "passanger_last_name", nullable = false)
	private String passangerLastName;
	@Column(name = "passanger_age", nullable = false)
	private String passangerAge;
	@Column(name = "passanger_route", nullable = false)
	private int routeId;
	@Column(name = "passanger_seat", nullable = false)
	private String seatNo;
	@Column(name = "booked_by", nullable = false)
	private int bookingUID;
	@Column(name="payment_method")
	private String paymentMethod;
	@Column(name="transaction_id")
	private String transaction_id;
	@Column(name="transaction_amount")
	private String transaction_amount;
	@Column(name="transaction_status")
	private String transaction_status;
	
	public int getTid() {
		return id;
	}
	public void setTid(int id) {
		this.id = id;
	}
	public String getPassangerFirstName() {
		return passangerFirstName;
	}
	public void setPassangerFirstName(String passangerFirstName) {
		this.passangerFirstName = passangerFirstName;
	}
	public String getPassangerLastName() {
		return passangerLastName;
	}
	public void setPassangerLastName(String passangerLastName) {
		this.passangerLastName = passangerLastName;
	}
	public String getPassangerAge() {
		return passangerAge;
	}
	public void setPassangerAge(String passangerAge) {
		this.passangerAge = passangerAge;
	}
	public int getRouteId() {
		return routeId;
	}
	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}
	public String getSeatNo() {
		return seatNo;
	}
	public void setSeatNo(String seatNo) {
		this.seatNo = seatNo;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBookingUID() {
		return bookingUID;
	}
	public void setBookingUID(int bookingUID) {
		this.bookingUID = bookingUID;
	}
	
	public String getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	public String getTransaction_id() {
		return transaction_id;
	}
	public void setTransaction_id(String transaction_id) {
		this.transaction_id = transaction_id;
	}
	public String getTransaction_amount() {
		return transaction_amount;
	}
	public void setTransaction_amount(String transaction_amount) {
		this.transaction_amount = transaction_amount;
	}
	
	public String getTransaction_status() {
		return transaction_status;
	}
	public void setTransaction_status(String transaction_status) {
		this.transaction_status = transaction_status;
	}
	public Ticket() {
		super();
	}
	public Ticket(String passangerFirstName, String passangerLastName, String passangerAge, int routeId, String seatNo,
			int bookingUID, String paymentMethod, String transaction_id, String transaction_amount,
			String transaction_status) {
		super();
		this.passangerFirstName = passangerFirstName;
		this.passangerLastName = passangerLastName;
		this.passangerAge = passangerAge;
		this.routeId = routeId;
		this.seatNo = seatNo;
		this.bookingUID = bookingUID;
		this.paymentMethod = paymentMethod;
		this.transaction_id = transaction_id;
		this.transaction_amount = transaction_amount;
		this.transaction_status = transaction_status;
	}
	public Ticket(int id, String passangerFirstName, String passangerLastName, String passangerAge, int routeId,
			String seatNo, int bookingUID, String paymentMethod, String transaction_id, String transaction_amount,
			String transaction_status) {
		super();
		this.id = id;
		this.passangerFirstName = passangerFirstName;
		this.passangerLastName = passangerLastName;
		this.passangerAge = passangerAge;
		this.routeId = routeId;
		this.seatNo = seatNo;
		this.bookingUID = bookingUID;
		this.paymentMethod = paymentMethod;
		this.transaction_id = transaction_id;
		this.transaction_amount = transaction_amount;
		this.transaction_status = transaction_status;
	}
	
	
}
