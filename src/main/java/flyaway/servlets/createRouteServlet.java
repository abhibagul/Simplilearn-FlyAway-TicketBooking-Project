package flyaway.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import org.hibernate.Session;
import org.hibernate.Transaction;

import flyaway.entities.Airports;
import flyaway.entities.Customer;
import flyaway.entities.Route;
import flyaway.helper.FactoryProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class createRouteServlet
 */
public class createRouteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public createRouteServlet() {
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
			
			
			//creating object
			Route route = new Route(Integer.parseInt(rtSource), Integer.parseInt(rtDestination), Integer.parseInt(rtTicketPrice), Integer.parseInt(rtAirline), rtDate, rtDeparture, rtArrival, Integer.parseInt(rtSeats));

			//hibernate:save
			Session s = FactoryProvider.getFactory().openSession();
			Transaction tx = s.beginTransaction();
			
			s.saveOrUpdate(route);
			tx.commit();
			s.close();
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println("<h1>Airport added successfully</h1>");
			
		}catch(Exception e) {
			e.printStackTrace();
			error = e.getMessage();
		}
		
		finally {
			System.out.println("err:::" + error);
			if(error.length() > 0) {
				response.sendRedirect( request.getContextPath() + "/manageRoute/createRoute.jsp?error="+error);
			}else {
				response.sendRedirect( request.getContextPath() + "/manageRoute.jsp");
			}
		}
	}

}
