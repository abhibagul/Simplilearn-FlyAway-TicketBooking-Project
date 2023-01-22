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
@Table(name="users",uniqueConstraints={@UniqueConstraint(columnNames={"email"}),@UniqueConstraint(columnNames={"phone"})})
public class Customer {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;
	
	@Column(name = "first_name")
	private String firstName;
	@Column(name = "last_name")
	private String lastName;
	@Column(name = "email")
	private String email;
	@Column(name = "phone")
	private String phone;
	@Column(name = "passwordHash")
	private byte[] PasswordHash;
	@Column(name = "user_created")
	private Date userCreated;
	@Column(name = "user_last_modify")
	private Date userLastModified;
	@Column(name = "user_last_pass_changed")
	private Date passwordLastChanged;
	@Column(name = "user_authority")
	private String userRole;  // => This could  be either Customer or Admin
	@Column(name = "user_salt")
	private byte[] user_salt;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public byte[]  getPasswordHash() {
		return PasswordHash;
	}
	public void setPasswordHash(byte[] passwordHash) {
		PasswordHash = passwordHash;
	}
	public Date getUserCreated() {
		return userCreated;
	}
	public void setUserCreated(Date userCreated) {
		this.userCreated = userCreated;
	}
	public Date getUserLastModified() {
		return userLastModified;
	}
	public void setUserLastModified(Date userLastModified) {
		this.userLastModified = userLastModified;
	}
	public Date getPasswordLastChanged() {
		return passwordLastChanged;
	}
	public void setPasswordLastChanged(Date passwordLastChanged) {
		this.passwordLastChanged = passwordLastChanged;
	}
	public String getUserRole() {
		return userRole;
	}
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	
	public byte[] getUser_salt() {
		return user_salt;
	}
	public void setUser_salt(byte[] user_salt) {
		this.user_salt = user_salt;
	}
	public Customer() {
		super();
	}
	
	public Customer(String firstName, String lastName, String email, String phone, byte[] passwordHash,
			String userRole, byte[] user_salt) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phone = phone;
		this.PasswordHash = passwordHash;
		this.userRole = userRole;
		this.userCreated = new Date();
		this.userLastModified = new Date();
		this.passwordLastChanged = new Date();
		this.user_salt = user_salt;
		
	}
	
	public Customer(int id, String firstName, String lastName, String email, String phone, byte[] passwordHash,
			Date userCreated, Date userLastModified, Date passwordLastChanged, String userRole, byte[] user_salt) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phone = phone;
		PasswordHash = passwordHash;
		this.userCreated = userCreated;
		this.userLastModified = userLastModified;
		this.passwordLastChanged = passwordLastChanged;
		this.userRole = userRole;
		this.user_salt = user_salt;
	}
	
	
	
	
	
}
