import  ooddresit.model.User;

import static org.junit.Assert.*;
import org.junit.Test;

import java.time.LocalDate;

import org.junit.After;
import org.junit.Before;


public class UserClassTest {
    //creating user instance 
    User user = new User("user1", "pass");
    
    public void setUp() throws Exception {
    }

    public void tearDown() throws Exception {
    }
    
     @Test
    public void testGetUsername() {
        String expected = "user1";
        String actual = user.getUsername();
        assertEquals(expected, actual);
        //fail("Not yet implemented");
    }
    
    public void testGetPassword() {
        String expected = "pass";
        String actual = user.getPassword();
        assertTrue(expected.equals(actual));
                
    
    }
    
    public void testGetFirstname() {
        String expected = "Lyubo";
        String actual = user.getFirstName();
        assertEquals(expected, actual);
    
    }
    
    
}
