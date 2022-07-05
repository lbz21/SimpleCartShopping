import  ooddresit.model.Product;

import org.junit.Test;
import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;

public class ProductTest {

    //creates a product object instance
    Product product = new Product("Macbook_15", "Laptop", 1500d, 90);

    public void setUp() throws Exception {
    }

    public void tearDown() throws Exception {
    }

    @Test
    public void testGetname() {
        String expected = "Macbook_15";
        String actual = product.getName();
        assertEquals(expected, actual);
        //fail("Not yet implemented");
    }

    public void testGetProductType() {
        String expected = "Laptop";
        String actual = product.getProductType();
        assertTrue(expected.equals(actual));
        //fail("Not yet implemented");

    }

    public void GetqtyInStock() {
        int expected = 90;
        int actual = product.getQtyInStock();
        assertEquals(expected, actual);
    }

    @Test
    public void testConstructor() {
        Product product = new Product("Macbook_15", "Laptop", 1500d, 90);
        assertEquals("Macbook_15", product.getName());
        assertEquals("Laptop", product.getProductType());
        assertEquals(1500d, product.getPrice());
        assertEquals(90, product.qtyInStock());

    }
    
    public void testSetProducttype() {
        product.setProductType("Laptop");
        assertEquals("Laptop", product.getProductType());
    }
    
    public void testSetProductName() {
        product.setName("Macbook_15");
        assertEquals("Macbook_15", product.getName());
    }
    
    @Test
    public void testsetQtyInStock() {
        product.setQtyInStock(90);
        assertEquals(90, product.getQtyInStock());
    
    }

}
