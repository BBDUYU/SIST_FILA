package search;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class searchDAO {

    private static searchDAO dao = null;

    private searchDAO() { }

    public static searchDAO getInstance() {
        if(dao == null) {
            dao = new searchDAO();
        }
        return dao;
    }

    /**
     * 검색어 기록 추가/갱신
     * 기존에 존재하면 검색 횟수 증가, 없으면 새로 추가
     */
    public void upsertKeyword(Connection conn, String keyword) throws SQLException {
        String sql = "MERGE INTO SEARCH_KEYWORDS t " +
                     "USING (SELECT ? AS KEYWORD FROM dual) s " +
                     "ON (t.KEYWORD = s.KEYWORD) " +
                     "WHEN MATCHED THEN " +
                     "  UPDATE SET t.SEARCH_COUNT = t.SEARCH_COUNT + 1, t.LAST_SEARCH_DATE = SYSDATE " +
                     "WHEN NOT MATCHED THEN " +
                     "  INSERT (KEYWORD, SEARCH_COUNT, LAST_SEARCH_DATE) VALUES (s.KEYWORD, 1, SYSDATE)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, keyword);
            pstmt.executeUpdate();
        }
    }

    /**
     * 상위 N개의 인기 검색어 조회
     */
    public ArrayList<searchDTO> selectTopKeywords(Connection conn, int limit) throws SQLException {
        ArrayList<searchDTO> list = new ArrayList<>();
        String sql = "SELECT KEYWORD_ID, KEYWORD, SEARCH_COUNT, LAST_SEARCH_DATE " +
                     "FROM SEARCH_KEYWORDS " +
                     "ORDER BY SEARCH_COUNT DESC " +
                     "FETCH FIRST ? ROWS ONLY";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, limit);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    searchDTO dto = searchDTO.builder()
                            .keyword_id(rs.getInt("KEYWORD_ID"))
                            .keyword(rs.getString("KEYWORD"))
                            .search_count(rs.getInt("SEARCH_COUNT"))
                            .last_search_date(rs.getDate("LAST_SEARCH_DATE"))
                            .build();
                    list.add(dto);
                }
            }
        }

        return list;
    }
}
