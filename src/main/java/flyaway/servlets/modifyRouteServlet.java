package flyaway.servlets;

import java.io.IOException;
import java.io.PrintWriter;

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
 * Servlet implementation class modifyRouteServlet
 */
public class modifyRouteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public modifyRouteServlet() {
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
			
			String rtAirline = request.getParameter("rtAirline");
			String rtSource = request.getParameter("rtSource");
			String rtDestination = request.getParameter("rtDestination");

			String rtDeparture = request.getParameter("rtDeparture");
			String rtArrival = request.getParameter("rtArrival");
			String rtDate = request.getParameter("rtDate");
			String rtTicketPrice = request.getParameter("rtTicketPrice");
			String rtSeats = request.getParameter("rtSeats");
			int routeId = Integer.parseInt(request.getParameter("routeId"));
			
			
			//hibernate:save
			Session s = FactoryProvider.getFactory().openSession();
			Transaction tx = s.beginTransaction();
			
			Route route = s.get(Route.class, routeId);
			route.setAirline(Integer.parseInt(rtAirline));
			route.setSource(Integer.parseInt(rtSource));
			route.setDestination(Integer.parseInt(rtDestination));
			route.setDeparture(rtDeparture);
			route.setArrival(rtArrival);
			route.setDate(rtDate);
			route.setPrice(Integer.parseInt(rtTicketPrice));
			route.setSeats(Integer.parseInt(rtSeats));
			
			
			tx.commit();
			s.close();
						
		}catch(Exception e) {
			e.printStackTrace();
			error = e.getMessage();
		}
		
		finally {
			System.out.println("err:::" + error);
			if(error.length() > 0) {
				response.sendRedirect( request.getContextPath() + "/manageRoute/modifyRoute.jsp?error="+error);
			}else {
				response.sendRedirect( request.getContextPath() + "/manageRoute.jsp");
			}
		}
	}

}
