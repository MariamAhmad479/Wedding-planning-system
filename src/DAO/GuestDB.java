package DAO;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import db.DBConnection;
import entity.Guest;
import enumeration.RSVPStatus;

public class GuestDB {

    public GuestDB() {}

    private int toDbStatus(RSVPStatus status) {
        if (status == null) return RSVPStatus.PENDING.ordinal();
        return status.ordinal();
    }

    private RSVPStatus fromDbStatus(int code) {
        RSVPStatus[] values = RSVPStatus.values();
        if (code < 0 || code >= values.length) return RSVPStatus.PENDING;
        return values[code];
    }

    public List<Guest> getGuests(String brideId) {
        List<Guest> list = new ArrayList<>();

        String sql =
            "SELECT guest_id, bride_id, guest_name, email, guest_category, plus_one_count, rsvp_status, rsvp_timestamp " +
            "FROM dbo.Guest " +
            "WHERE bride_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, brideId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Guest g = new Guest();
                    g.setGuestId(rs.getString("guest_id"));
                    g.setBrideId(rs.getString("bride_id"));
                    g.setGuestName(rs.getString("guest_name"));
                    g.setEmail(rs.getString("email"));
                    g.setGuestCategory(rs.getString("guest_category"));
                    g.setPlusOneCount(rs.getInt("plus_one_count"));

                    g.setRSVPStatus(
                        RSVPStatus.valueOf(rs.getString("rsvp_status"))
                    );
                    Timestamp ts = rs.getTimestamp("rsvp_timestamp");
                    if (ts != null) {
                        g.setRsvpTimestamp(ts.toLocalDateTime());
                    }

                    list.add(g);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public void saveGuest(Guest guest) {

    String sql =
        "INSERT INTO dbo.Guest " +
        "(guest_id, bride_id, guest_name, email, guest_category, plus_one_count, rsvp_status) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?)";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, guest.getGuestId());
        ps.setString(2, guest.getBrideId());
        ps.setString(3, guest.getGuestName());
        ps.setString(4, guest.getEmail());
        ps.setString(5, guest.getGuestCategory());
        ps.setInt(6, guest.getPlusOneCount());
        ps.setString(7, guest.getRsvpStatus().name()); // ATTENDING / NOT_ATTENDING / PENDING

        ps.executeUpdate();

    } catch (SQLException e) {
        e.printStackTrace();
    }
}


    public void updateRSVP(String guestId, RSVPStatus status, int plusOneCount) {
        String sql =
            "UPDATE dbo.Guest " +
            "SET rsvp_status = ?, plus_one_count = ?, rsvp_timestamp = SYSDATETIME() " +
            "WHERE guest_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, toDbStatus(status));
            ps.setInt(2, plusOneCount);
            ps.setString(3, guestId);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Guest> getPendingGuests(String brideId) {
        List<Guest> list = new ArrayList<>();

        String sql =
            "SELECT guest_id, bride_id, guest_name, email, guest_category, plus_one_count, rsvp_status, rsvp_timestamp " +
            "FROM dbo.Guest " +
            "WHERE bride_id = ? AND rsvp_status = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, brideId);
            ps.setInt(2, toDbStatus(RSVPStatus.PENDING));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Guest g = new Guest();
                    g.setGuestId(rs.getString("guest_id"));
                    g.setBrideId(rs.getString("bride_id"));
                    g.setGuestName(rs.getString("guest_name"));
                    g.setEmail(rs.getString("email"));
                    g.setGuestCategory(rs.getString("guest_category"));
                    g.setPlusOneCount(rs.getInt("plus_one_count"));

                    g.setRSVPStatus(
                        RSVPStatus.valueOf(rs.getString("rsvp_status"))
                    );


                    Timestamp ts = rs.getTimestamp("rsvp_timestamp");
                    if (ts != null) {
                        g.setRsvpTimestamp(ts.toLocalDateTime());
                    }

                    list.add(g);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
