package flyaway.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name="airports",uniqueConstraints={@UniqueConstraint(columnNames={"name"}),@UniqueConstraint(columnNames={"code"})})
public class Airports {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;
	@Column(name = "name", nullable = false)
	private String name;
	@Column(name = "code", nullable = false)
	private String code;
	@Column(name = "country", nullable = false)
	private String country;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}	
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public Airports() {
		super();
	}
	
	public Airports( String name, String code) {
		super();
		this.name = name;
		this.code = code;
		this.country = country;
	}
	
	
	
	
}
