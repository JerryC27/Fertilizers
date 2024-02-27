import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "Solution", value = "/Solution" )
public class Solution extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String s1=req.getParameter("solu");

        PrintWriter pw=resp.getWriter();
        resp.setContentType("Text/html");
        System.out.println("Enter in try catch block");
        try
        {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/MyProject", "root", "admin");
            System.out.println("connected");

            String userID = req.getParameter("userID");
            String prob = req.getParameter("prob");

            System.out.println(userID);
            System.out.println(prob);


            String str="Insert Into Solution (descript, prob_id, user_id) values (?, ?, ?)";
            PreparedStatement ps=con.prepareStatement(str);
            ps.setString(1,s1);
            ps.setString(2,prob);
            ps.setString(3,userID);

            int row = ps.executeUpdate();
            if (row > 0) {
                resp.getWriter().println("File and text successfully uploaded and stored in the database!");
            } else {
                resp.getWriter().println("Failed to upload file and text to the database.");
            }

            ps.close();
            con.close();
            RequestDispatcher dispatcher = req.getRequestDispatcher("ViewRecords.jsp");
            dispatcher.forward(req, resp);

        }
        catch (Exception e)
        {   e.printStackTrace();
            resp.getWriter().println("Error: " + e.getMessage());
        }
    }
}
