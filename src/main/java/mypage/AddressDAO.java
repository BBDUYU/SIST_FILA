package mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.util.ConnectionProvider;

public class AddressDAO {

  // 기본배송지 해제
  public void clearDefault(Connection conn, int userNumber) throws Exception {
    String sql = "UPDATE DELIVERY_ADDRESS SET IS_DEFAULT = 0 WHERE USER_NUMBER = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, userNumber);
      ps.executeUpdate();
    }
  }

  // INSERT
  public int insert(Connection conn, AddressDTO dto) throws Exception {
    String sql =
      "INSERT INTO DELIVERY_ADDRESS " +
      "(ADDRESS_ID, USER_NUMBER, ADDRESS_NAME, RECIPIENT_NAME, RECIPIENT_PHONE, ZIPCODE, MAIN_ADDR, DETAIL_ADDR, IS_DEFAULT) " +
      "VALUES (DELIVERY_ADDRESS_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?)";

    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, dto.getUserNumber());
      ps.setString(2, dto.getAddressName());
      ps.setString(3, dto.getRecipientName());
      ps.setString(4, dto.getRecipientPhone());
      ps.setString(5, dto.getZipcode());
      ps.setString(6, dto.getMainAddr());
      ps.setString(7, dto.getDetailAddr());
      ps.setInt(8, dto.getIsDefault());
      return ps.executeUpdate();
    }
  }

  // UPDATE (본인 주소만)
  public int update(Connection conn, AddressDTO dto) throws Exception {
    String sql =
      "UPDATE DELIVERY_ADDRESS " +
      "SET ADDRESS_NAME=?, RECIPIENT_NAME=?, RECIPIENT_PHONE=?, ZIPCODE=?, MAIN_ADDR=?, DETAIL_ADDR=?, IS_DEFAULT=? " +
      "WHERE ADDRESS_ID=? AND USER_NUMBER=?";

    try (PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setString(1, dto.getAddressName());
      ps.setString(2, dto.getRecipientName());
      ps.setString(3, dto.getRecipientPhone());
      ps.setString(4, dto.getZipcode());
      ps.setString(5, dto.getMainAddr());
      ps.setString(6, dto.getDetailAddr());
      ps.setInt(7, dto.getIsDefault());
      ps.setInt(8, dto.getAddressId());
      ps.setInt(9, dto.getUserNumber());
      return ps.executeUpdate();
    }
  }
}
