import java.sql.*;

public class example {
   // JDBC driver name and database URL
   static final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
   static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:orcl";

   //  Database credentials
   static final String USER = "yakov";
   //the user name; You can change it to your username (by default it is root).
   static final String PASS = "Test#123_2020";
   //the password; You can change it to your password (the one you used in MySQL server configuration).

   public static void main(String[] args) {
   Connection conn = null;
   Statement stmt = null;
   try{
      //STEP 1: Register JDBC driver
      Class.forName(JDBC_DRIVER);

      //STEP 2: Open a connection to database
      System.out.println("Connecting to database...");
      conn = DriverManager.getConnection(DB_URL, USER, PASS);

      System.out.println("Creating database...");
      stmt = conn.createStatement();

      
        //Your Task 7: Write SQL for Q1 - Q4 in Lab instruction and display the answers.
      	System.out.println("Q1:  Find the name of the drivers who got the license from the branch 'NYC'.\n");
        //Q1:  Find the name of the drivers who got the license from the branch “NYC”.
        Statement q1 = conn.createStatement();
        q1.executeQuery(""
        		+ "select d.driver_name "
        		+ "from driver d, license l, branch b "
        		+ "where d.driver_ssn = l.driver_ssn "
        		+ "and l.branch_id = b.branch_id "
        		+ "and b.branch_name ='NYC'");
        ResultSet q1r = q1.getResultSet();
        while (q1r.next ()){
            String nameVal = q1r.getString ("driver_name");
            System.out.println ("name = " + nameVal);
           
        }
        
        System.out.println();
        System.out.println("Q2: Find the name of the drivers whose driver license expire by 12/31/2022\n");
        //Q2: Find the name of the drivers whose driver license expire by 12/31/2022
        Statement q2 = conn.createStatement();
        q2.executeQuery(
        		"select d.driver_name\r\n" + 
        		"from driver d, license l\r\n" + 
        		"where d.driver_ssn = l.driver_ssn \r\n" + 
        		"and l.license_expiry <= to_date('31-DEC-2022','DD-MON-RRRR')");
        ResultSet q2r = q2.getResultSet();
        while (q2r.next ()){
            String nameVal = q2r.getString ("driver_name");
            System.out.println ("name = " + nameVal);
           
        }
        
        System.out.println();
        System.out.println("Q3:  Find the name of the drivers who took at least 2 exams for the same driver license type at the same branch.\n");
        //Q3:  Find the name of the drivers who took at least 2 exams for the same driver license type at the same branch.
        Statement q3 = conn.createStatement();
        q3.executeQuery(
        		"select d.driver_name\r\n" + 
        		"from driver d, exam e\r\n" + 
        		"where d.driver_ssn = e.driver_ssn\r\n" + 
        		"group by d.driver_name, e.exam_type, e.branch_id\r\n" + 
        		"having COUNT(*) >= 2");
        ResultSet q3r = q3.getResultSet();
        while (q3r.next ()){
            String nameVal = q3r.getString ("driver_name");
            System.out.println ("name = " + nameVal);
           
        }
        
        System.out.println();
        System.out.println("Q4:  Find the name of the drivers whose exam scores get consecutively lower when he/she took more exams.\n");
        //Q4:  Find the name of the drivers whose exam scores get consecutively lower when he/she took more exams.
        /*
         * Sorry for it being so ridiculous looking, I originally wrote everything to function in Oracle SQL Developer
         * and then copy pasted the sql code into the executeQuery. What the code is actually doing is it grabs the names
         * by using LAG which is an oracle analytic function that allows you to use values of consecutive rows on one row.
         * Here I grab the exams table by joining exam table and driver table and order them such that each driver has their
         * exams in order by the date in which they took them. The exam scores are then lined up such that all of driver "A"
         * has their exams together, then driver "B" and so on.
         * Here it puts on the current row the name on the previous line and the previous exam score number. It ignores any line
         * where the driver_name does not match with prev_name. Also it takes the subtraction of the prev_score and exam_score to
         * see if the difference is negative to make sure that the driver consecutively got a worse grade.
         * Then the MINUS is ensure that if a driver had both gotten a consecutive increase and decrease in grades, then that 
         * driver would also be ignored.
         * 
         * */
        Statement q4 = conn.createStatement();
        q4.executeQuery(""+
        		"select distinct driver_name\r\n" + 
        		"from \r\n" + 
        		"(select d.driver_name, e.exam_date, e.exam_score, \r\n" + 
        		"exam_score - LAG(e.exam_score, 1, -1) over (order by d.driver_name, e.exam_date) as prev_score,\r\n" + 
        		"LAG(d.driver_name, 1, 'NA') over (order by d.driver_name, e.exam_date) as prev_driver\r\n" + 
        		"\r\n" + 
        		"from driver d, exam e\r\n" + 
        		"where d.driver_ssn = e.driver_ssn\r\n" + 
        		"and d.driver_ssn in (\r\n" + 
        		"    select e.driver_ssn\r\n" + 
        		"    from exam e\r\n" + 
        		"    group by e.driver_ssn\r\n" + 
        		"    having count(*) > 1 )\r\n" + 
        		")\r\n" + 
        		"where driver_name = prev_driver and prev_score <0\r\n" + 
        		"MINUS \r\n" + 
        		"select distinct driver_name\r\n" + 
        		"from \r\n" + 
        		"(select d.driver_name, e.exam_date, e.exam_score, \r\n" + 
        		"exam_score - LAG(e.exam_score, 1, -1) over (order by d.driver_name, e.exam_date) as prev_score,\r\n" + 
        		"LAG(d.driver_name, 1, 'NA') over (order by d.driver_name, e.exam_date) as prev_driver\r\n" + 
        		"\r\n" + 
        		"from driver d, exam e\r\n" + 
        		"where d.driver_ssn = e.driver_ssn\r\n" + 
        		"and d.driver_ssn in (\r\n" + 
        		"    select e.driver_ssn\r\n" + 
        		"    from exam e\r\n" + 
        		"    group by e.driver_ssn\r\n" + 
        		"    having count(*) > 1 )\r\n" + 
        		")\r\n" + 
        		"where driver_name = prev_driver and prev_score >=0");
        ResultSet q4r = q4.getResultSet();
        while (q4r.next ()){
            String nameVal = q4r.getString ("driver_name");
            System.out.println ("name = " + nameVal);
           
        }
        
        
      }catch(SQLException se){
      //Handle errors for JDBC
      se.printStackTrace();
   }catch(Exception e){
      //Handle errors for Class.forName
      e.printStackTrace();
   }finally{
      //finally block used to close resources
      try{
         if(stmt!=null)
            stmt.close();
      }catch(SQLException se2){
      }// nothing we can do
      try{
         if(conn!=null)
            conn.close();
      }catch(SQLException se){
         se.printStackTrace();
      }//end finally try
   }//end try
   System.out.println();
   System.out.println("Exited Succesfully!");
}//end main
}//end JDBCExample
