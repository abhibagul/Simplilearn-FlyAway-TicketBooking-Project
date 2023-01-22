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
 * Servlet implementation class removeRouteServlet
 */
public class removeRouteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public removeRouteServlet() {
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
		
		if(!customer_session.getUserRole().equals("Admin")) {
			response.sendRedirect( request.getContextPath() + "/");
			return;
		}
		
		try {
			
			
			int routeId = Integer.parseInt(request.getParameter("routeId"));
			
			
			//hibernate:save
			Session s = FactoryProvider.getFactory().openSession();
			Transaction tx = s.beginTransaction();
			
			Route route = s.get(Route.class, routeId);
			s.delete(route);

			
			tx.commit();
			s.close();
						
		}catch(Exception e) {
			e.printStackTrace();
			error = e.getMessage();
		}
		
		finally {
			System.out.println("err:::" + error);
			if(error.length() > 0) {
				response.sendRedirect( request.getContextPath() + "/manageRoute.jsp?error="+error);
			}else {
				response.sendRedirect( request.getContextPath() + "/manageRoute.jsp");
			}
		}
	}

}
