package flyaway.servlets;

import java.io.IOException;
import java.io.PrintWriter;



import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.exception.ConstraintViolationException;

import flyaway.entities.Airlines;
import flyaway.helper.FactoryProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class createAirlineServlet
 */
public class createAirlineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public createAirlineServlet() {
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
			String airName = request.getParameter("airName");
			String airEmail = request.getParameter("airEmail");
			String airPhone = request.getParameter("airPhone");
			
			//creating object
			Airlines airline = new Airlines(airName, airEmail, airPhone);

			//hibernate:save
			Session s = FactoryProvider.getFactory().openSession();
			Transaction tx = s.beginTransaction();
			
			s.saveOrUpdate(airline);
			tx.commit();
			s.close();
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println("<h1>Airline added successfully</h1>");
			
		}catch(Exception e) {
			e.printStackTrace();
			error = e.getMessage();;
		}
		
		
		
		finally {
			System.out.println("err:::" + error);
			if(error.length() > 0) {
				response.sendRedirect( request.getContextPath() + "/manageAirlines/createAirlines.jsp?error="+error);
			}else {
				response.sendRedirect( request.getContextPath() + "/manageAirlines.jsp");
			}
		}
		
	}

}
