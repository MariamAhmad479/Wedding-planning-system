package DAO;

import java.io.*;
import java.util.*;

/**
 * 
 */
public class ReviewAccessor {

    /**
     * Default constructor
     */
    public ReviewAccessor() {
    }

    /**
     * 
     */
    public String connectionString;

    /**
     * @param vendorId 
     * @param brideId 
     * @param rating 
     * @param comment 
     * @return
     */
    public Boolean insertReview(String vendorId, String brideId, int rating, String comment) {
        // TODO implement here
        return null;
    }

    /**
     * @param reviewId 
     * @return
     */
    public void deleteReview(String reviewId) {
        // TODO implement here
        return null;
    }

    /**
     * @param vendorId 
     * @return
     */
    public List getReviewsByVendor(String vendorId) {
        // TODO implement here
        return null;
    }

    /**
     * @param vendorId 
     * @return
     */
    public Decimal getAverageRating(String vendorId) {
        // TODO implement here
        return null;
    }

    /**
     * @param vendorId 
     * @param rating
     */
    public void updateVendorScore(void vendorId, void rating) {
        // TODO implement here
    }

}