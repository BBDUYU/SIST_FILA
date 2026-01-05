package admin.service;

import java.sql.Connection;
import java.util.List;
import com.util.ConnectionProvider;
import admin.domain.CouponDTO;
import admin.persistence.CouponDAO;

public class CouponService {
    private static CouponService instance = new CouponService();
    public static CouponService getInstance() { return instance; }
    private CouponService() {}

    private CouponDAO dao = CouponDAO.getInstance();

    public List<CouponDTO> getCouponList() {
        try (Connection conn = ConnectionProvider.getConnection()) {
            return dao.selectList(conn);
        } catch (Exception e) {
            throw new RuntimeException("쿠폰 목록 조회 실패", e);
        }
    }
    public void createCoupon(CouponDTO dto) {
        try (Connection conn = ConnectionProvider.getConnection()) {
            dao.insertCoupon(conn, dto);
        } catch (Exception e) {
            throw new RuntimeException("쿠폰 등록 실패", e);
        }
    }

    public void toggleCouponStatus(int couponId, String status) {
        try (Connection conn = ConnectionProvider.getConnection()) {
            // DAO의 updateStatus를 호출합니다.
            dao.updateStatus(conn, couponId, status);
        } catch (Exception e) {
            throw new RuntimeException("쿠폰 상태 변경 실패", e);
        }
    }
}