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
import java.sql.*;

import static java.lang.System.out;

@WebServlet(name = "ExpertLogin", value = "/Expert" )
public class Expert extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String s1=req.getParameter("expert_uname");
        String s2=req.getParameter("expert_pass");

        PrintWriter pw=resp.getWriter();
        resp.setContentType("Text/html");
        System.out.println("Enter in try catch block");
        try
        {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/MyProject", "root", "admin");
            System.out.println("connected");

            String str="Select * from Expert where uname=? and pass=?";
            PreparedStatement ps=con.prepareStatement(str);
            ps.setString(1,s1);
            ps.setString(2,s2);

            ResultSet rs=ps.executeQuery();
            if(rs.next())
            {
                RequestDispatcher rd=req.getRequestDispatcher("/ViewRecords.jsp");
                rd.forward(req,resp);
            }
            else
            {
                req.setAttribute("errorMessage", "Invalid username or password");
                RequestDispatcher rd=req.getRequestDispatcher("/Expert.jsp");
                rd.include(req,resp);
            }
        }
        catch (Exception e)
        {    }
    }
}
