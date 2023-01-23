package flyaway.servlets;

import java.io.IOException;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.util.Arrays;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import flyaway.entities.Customer;
import flyaway.helper.FactoryProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class modifyPasswordServlet
 */
public class modifyPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public modifyPasswordServlet() {
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
		// TODO Auto-generated method stub
		String error = "";
		
		HttpSession session=request.getSession();
		
		Customer customer_session = (Customer) session.getAttribute("user");
		
		if(customer_session != null){
			
		}else{
			response.sendRedirect(request.getContextPath() +"/");
			
			return;
		}
		
		try {
			
			String logPass = request.getParameter("oldPass");

			String regPass = request.getParameter("newPass");
			String regCPass = request.getParameter("newPassC");
			
			if(! regPass.equals(regCPass)) {
				response.sendRedirect( request.getContextPath() + "/signup.jsp?error=Passwords Do Not Match");
				return;
			}
			
			Session s = FactoryProvider.getFactory().openSession();
			
			Query q = s.createQuery("from Customer where id=:id");
			q.setParameter("id", customer_session.getId());
			
			Customer c = (Customer) q.uniqueResult();
			
			byte[] pHash = c.getPasswordHash();
			byte[] salt = c.getUser_salt();
			
			KeySpec spec = new PBEKeySpec(logPass.toCharArray(), salt, 65536, 128);
			SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
			
			byte[] genHash = factory.generateSecret(spec).getEncoded();
			
			
			
			
			if(Arrays.equals(pHash, genHash)) {
				
				//create new salt and hash
				SecureRandom random = new SecureRandom();
				byte[] newSalt = new byte[16];
				random.nextBytes(newSalt); 
				
				KeySpec newSpec = new PBEKeySpec(regPass.toCharArray(), newSalt, 65536, 128);
				byte[] regPassHash = factory.generateSecret(newSpec).getEncoded();
				
				Transaction tx = s.beginTransaction();
				Customer cs = s.get(Customer.class, customer_session.getId());
				
				
				cs.setPasswordHash(regPassHash);
				cs.setUser_salt(newSalt);
				tx.commit();
				
				
				session.setAttribute("user",c);
				response.sendRedirect( request.getContextPath() + "/");
			}else {
				
				response.sendRedirect(request.getContextPath() +"/myProfile.jsp?error=Invalid password");
			}
			s.close();
			
			
		}catch(Exception e) {
			e.printStackTrace();
			error = e.getMessage();
			response.sendRedirect("login.jsp?error=" + error);
		}
		
		finally {
			System.out.println("err:::" + error);
		}
	}

}
