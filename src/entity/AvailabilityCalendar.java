package entity;

import java.io.*;
import java.util.*;

/**
 * 
 */
public class AvailabilityCalendar {

    /**
     * Default constructor
     */
    public AvailabilityCalendar() {
    }

    /**
     * 
     */
    private String vendorId;

    /**
     * 
     */
    private List<TimeSlot> slots;







    /**
     * @param slot 
     * @return
     */
    public void addSlot(TimeSlot slot) {
        // TODO implement here
        return null;
    }

    /**
     * @param slotId 
     * @return
     */
    public void removeSlot(String slotId) {
        // TODO implement here
        return null;
    }

    /**
     * @param date 
     * @param time 
     * @return
     */
    public boolean isAvailable(Date date, Time time) {
        // TODO implement here
        return false;
    }

    /**
     * @return
     */
    public List<TimeSlot> getSchedule() {
        // TODO implement here
        return null;
    }

}