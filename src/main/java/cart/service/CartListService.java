package cart.service;

import java.sql.Connection;
import java.util.List;

import com.util.DBConn;

import cart.domain.CartItemDTO;
import cart.persistence.CartDAO;

public class CartListService {

  public List<CartItemDTO> selectAll() throws Exception {
    Connection conn = DBConn.getConnection();
    CartDAO dao = new CartDAO(conn);
    return dao.selectAll();
  }
}