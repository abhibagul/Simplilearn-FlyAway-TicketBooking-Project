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
 * Servlet implementation class CustomerLoginServlet
 */
public class CustomerLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public CustomerLoginServlet() {
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
		
		try {
			
			String logEmail = request.getParameter("logEmail");
			String logPass = request.getParameter("logPass");
			
			Session s = FactoryProvider.getFactory().openSession();
			
			Query q = s.createQuery("from Customer where email=:logemail");
			q.setParameter("logemail", logEmail);
			
			Customer c = (Customer) q.uniqueResult();
			
			byte[] pHash = c.getPasswordHash();
			byte[] salt = c.getUser_salt();
			
			KeySpec spec = new PBEKeySpec(logPass.toCharArray(), salt, 65536, 128);
			SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
			
			byte[] genHash = factory.generateSecret(spec).getEncoded();
			
			System.out.println("pHash:::" + pHash);
			System.out.println("genHash:::" + genHash);
			
			s.close();
			if(Arrays.equals(pHash, genHash)) {
				HttpSession session=request.getSession();
				session.setAttribute("user",c);
				response.sendRedirect( request.getContextPath() + "/");
			}else {
				
				response.sendRedirect("login.jsp?error=Invalid email or password");
			}
			
			
			
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
