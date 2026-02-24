package entity;

import java.io.*;
import java.util.*;

/**
 * 
 */
public class Appointment {

    /**
     * Default constructor
     */
    public Appointment() {
    }

    /**
     * 
     */
    public void Attribute1;

    /**
     * 
     */
    private String appointmentId;

    /**
     * 
     */
    private String brideId;

    /**
     * 
     */
    private String vendorId;

    /**
     * 
     */
    private Date date;

    /**
     * 
     */
    private Time time;

    /**
     * 
     */
    private AppointmentStatus status;



    /**
     * @param brideId 
     * @param vendorId 
     * @param date 
     * @param time 
     * @return
     */
    public void create(String brideId, String vendorId, Date date, Time time) {
        // TODO implement here
        return null;
    }

    /**
     * @param newStatus 
     * @return
     */
    public void updateStatus(AppointmentStatus newStatus) {
        // TODO implement here
        return null;
    }

}