package flyaway.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.security.spec.KeySpec;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

import org.hibernate.Session;
import org.hibernate.Transaction;

import flyaway.entities.Airlines;
import flyaway.entities.Customer;
import flyaway.helper.FactoryProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class createCustomerServlet
 */
public class createCustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public createCustomerServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String error = "";
		
		try {
			
			//name,email,phone
			String regFName = request.getParameter("regFName");
			String regLName = request.getParameter("regLName");
			String regEmail = request.getParameter("regEmail");
			String regPass = request.getParameter("regPass");
			String regCPass = request.getParameter("regCPass");
			String regPhone = request.getParameter("regPhone");
			String regPassCharset = request.getParameter("regPass");
			
			
			if(! regPass.equals(regCPass)) {
				response.sendRedirect( request.getContextPath() + "/signup.jsp?error=Passwords Do Not Match");
				return;
			}
			
			SecureRandom random = new SecureRandom();
			byte[] salt = new byte[16];
			random.nextBytes(salt); 
			
			KeySpec spec = new PBEKeySpec(regPassCharset.toCharArray(), salt, 65536, 128);
			SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
			
			byte[] regPassHash = factory.generateSecret(spec).getEncoded();
			
			
			System.out.println("Hash :::: " + regPassHash);
			//creating object
			// Customer(String firstName, String lastName, String email, String phone, String passwordHash, String userRole)
			Customer customer = new Customer(regFName, regLName, regEmail, regPhone,regPassHash, "Customer", salt );

			//hibernate:save
			Session s = FactoryProvider.getFactory().openSession();
			Transaction tx = s.beginTransaction();
			
			s.saveOrUpdate(customer);
			tx.commit();
			s.close();
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println("<h1>Customer added successfully</h1>");
			
		}catch(Exception e) {
			e.printStackTrace();
			error = e.getMessage();;
		}
		
		
		
		finally {
			if(error.length() > 0) {
				response.sendRedirect( request.getContextPath() + "/signup.jsp?error="+error);
			}else {
				response.sendRedirect( request.getContextPath() + "/login.jsp");
			}
		}
		
	}

}
