package mypage;

import java.sql.Connection;
import java.util.Collections;
import java.util.List;

import com.util.ConnectionProvider;

public class WishListService {

    private WishListService() {}
    private static WishListService instance = new WishListService();
    public static WishListService getInstance() { return instance; }

    private WishListDAO dao = WishListDAO.getInstance();

    // -----------------------------------------------------------
    // 1) 유저 위시리스트 목록 조회
    // -----------------------------------------------------------
    public List<WishListDTO> getWishList(int userNumber) {

        try (Connection conn = ConnectionProvider.getConnection()) {
            return dao.selectWishListByUser(conn, userNumber);

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
}
