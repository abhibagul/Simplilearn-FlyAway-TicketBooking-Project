package flyaway.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import flyaway.entities.Airlines;
import flyaway.entities.Customer;
import flyaway.entities.Ticket;
import flyaway.helper.FactoryProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class createTicketServlet
 */
public class createTicketServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public createTicketServlet() {
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
		
		if(!customer_session.getUserRole().equals("Customer")) {
			response.sendRedirect( request.getContextPath() + "/");
			return;
		}

		String txnid = request.getParameter("txnid");
		
		try {
			
			

			if(customer_session != null){
				if(!customer_session.getUserRole().equals("Customer")){
					response.sendRedirect(request.getContextPath() + "/");
					return;
				}
			}else{
				response.sendRedirect(request.getContextPath() + "/");
				return;
			}
			
			//name,email,phone
			String bookId = request.getParameter("bookId");
			String bookSeats = request.getParameter("bookSeats");
			String payment_status = request.getParameter("payment_status");
			String payment_mode = request.getParameter("payment_mode");
			String total_amount = request.getParameter("total_amount");
			
			
			
			
			for(int i=1; i <= Integer.parseInt(request.getParameter("bookSeats")); i++){
				Session s = FactoryProvider.getFactory().openSession();
				Transaction tx = s.beginTransaction();
				
				//get total booking for seat number
				Query q = s.createQuery("Select count(*) + 1 from Ticket where routeId=:routeNumber and transaction_status=:transaction_status");
				q.setParameter("routeNumber", Integer.parseInt(bookId));
				q.setParameter("transaction_status", "success");
				String count = String.valueOf(q.uniqueResult());
				System.out.println("count :::: " + count);
				
				
				
				String fname = request.getParameter("bookFirstName" + i);
				String lname = request.getParameter("bookLastName" + i);
				String age = request.getParameter("bookAge" + i);
				
				
				/*
				 Ticket( String passangerFirstName, String passangerLastName, String passangerAge, int routeId,
				String seatNo, int bookingUID, String paymentMethod, String transaction_id, String transaction_amount,
				String transaction_status) 
				*/
				Ticket ticket = new Ticket(fname, lname, age, Integer.parseInt(bookId), count, customer_session.getId(), payment_mode, txnid,  total_amount, payment_status);
				
				s.saveOrUpdate(ticket);
				tx.commit();
				s.close();
				
			}

			//hibernate:save
			
		}catch(Exception e) {
			e.printStackTrace();
			error = e.getMessage();;
		}
		
		
		
		finally {
			System.out.println("err:::" + error);
			if(error.length() > 0) {
				response.sendRedirect( request.getContextPath() + "/viewBooking.jsp?txnid="+txnid);
			}else {
				response.sendRedirect( request.getContextPath() + "/viewBooking.jsp?txnid="+txnid);
			}
		}
	}

}
