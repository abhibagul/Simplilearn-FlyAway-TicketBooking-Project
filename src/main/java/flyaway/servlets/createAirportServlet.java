package flyaway.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import org.hibernate.Session;
import org.hibernate.Transaction;

import flyaway.entities.Airlines;
import flyaway.entities.Airports;
import flyaway.entities.Customer;
import flyaway.helper.FactoryProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
/**
 * Servlet implementation class createAirportServlet
 */
public class createAirportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public createAirportServlet() {
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
		
		if(!customer_session.getUserRole().equals("Admin")) {
			response.sendRedirect( request.getContextPath() + "/");
			return;
		}
		
		try {
			
			//name,email,phone
			String airName = request.getParameter("airName");
			String airCode = request.getParameter("airCode");
			String airCountry = request.getParameter("airCountry");
			
			//creating object
//			Airlines airline = new Airlines(airName, airEmail, airPhone);
			Airports airport = new Airports(airName, airCode, airCountry);

			//hibernate:save
			Session s = FactoryProvider.getFactory().openSession();
			Transaction tx = s.beginTransaction();
			
			s.saveOrUpdate(airport);
			tx.commit();
			s.close();
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println("<h1>Airport added successfully</h1>");
			
		}catch(Exception e) {
			e.printStackTrace();
			error = e.getMessage();;
		}
		
		
		
		finally {
			System.out.println("err:::" + error);
			if(error.length() > 0) {
				response.sendRedirect( request.getContextPath() + "/manageAirports/createAirport.jsp?error="+error);
			}else {
				response.sendRedirect( request.getContextPath() + "/manageAirports.jsp");
			}
		}
	}

}
