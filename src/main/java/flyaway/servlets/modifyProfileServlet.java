package flyaway.servlets;

import java.io.IOException;

import org.hibernate.Session;
import org.hibernate.Transaction;

import flyaway.entities.Customer;
import flyaway.entities.Route;
import flyaway.helper.FactoryProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class modifyProfileServlet
 */
public class modifyProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public modifyProfileServlet() {
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
		String error="";
		HttpSession session=request.getSession();
		
		Customer customer_session = (Customer) session.getAttribute("user");
		
		if(customer_session != null){
			
		}else{
			response.sendRedirect(request.getContextPath() + "/");
			return;
		}
		
		try {
			
			String cusFirstName = request.getParameter("cusFirstName");
			String cusLastName = request.getParameter("cusLastName");
			String cusPhone = request.getParameter("cusPhone");

			//hibernate:save
			Session s = FactoryProvider.getFactory().openSession();
			Transaction tx = s.beginTransaction();
						
			Customer c = s.get(Customer.class, customer_session.getId());
			c.setFirstName(cusFirstName);
			c.setLastName(cusLastName);
			c.setPhone(cusPhone);
			
			tx.commit();
			s.close();
			
			session.setAttribute("user",c);
						
		}catch(Exception e) {
			e.printStackTrace();
			error = e.getMessage();
		}
		
		finally {
			System.out.println("err:::" + error);
			if(error.length() > 0) {
				response.sendRedirect( request.getContextPath() + "/myProfile.jsp?error="+error);
			}else {
				response.sendRedirect( request.getContextPath() + "/myProfile.jsp");
			}
		}
	}

}
