------------------------------------------------------------
---------------------GuestList queries----------------------
------------------------------------------------------------
-- Q1 - Update Total Guest Count (Data Integrity) 
-- purpose: synchronizes the total_guest_count for all brides based on their current entries in the Guest table.
------------------------------------------------------------
UPDATE dbo.Bride
SET total_guest_count = (
    SELECT COUNT(*) 
    FROM dbo.Guest G
    WHERE G.bride_id = dbo.Bride.bride_id
);

------------------------------------------------------------
-- Q2 - RSVP Status Summary per Bride 
-- purpose: allows a bride to see how many people are actually coming versus those still pending.
------------------------------------------------------------
SELECT 
    bride_id, 
    rsvp_status, 
    COUNT(guest_id) AS guest_sum
FROM dbo.Guest
GROUP BY bride_id, rsvp_status;

------------------------------------------------------------
-- Q3 - Brides with High Guest Volumes 
-- Identifies brides planning large weddings (over 200 guests) to help the platform suggest larger venues.
------------------------------------------------------------
SELECT 
    bride_id, 
    COUNT(*) AS total_confirmed
FROM dbo.Guest
WHERE rsvp_status = 'CONFIRMED'
GROUP BY bride_id
HAVING COUNT(*) > 200;

------------------------------------------------------------
-- Q4 -  Find Brides with No Confirmed Guests 
-- Identifies brides who might need help with their invitations or planning.
------------------------------------------------------------
SELECT 
    E.name, 
    E.email, 
    E.phone_number
FROM dbo.EndUser E
JOIN dbo.Bride B 
    ON E.user_id = B.bride_id
LEFT JOIN dbo.Guest G 
    ON B.bride_id = G.bride_id 
   AND G.rsvp_status = 'CONFIRMED'
WHERE G.guest_id IS NULL;

------------------------------------------------------------
-- Q5 - Filter Brides based on RSVP "Non-Responders"
-- purpose: Finds brides who have more than 50% of their guest list still in 'PENDING' status.
------------------------------------------------------------
SELECT *
FROM dbo.Bride B
WHERE (
    SELECT COUNT(*) 
    FROM dbo.Guest G 
    WHERE G.bride_id = B.bride_id 
      AND G.rsvp_status = 'PENDING'
) > (B.total_guest_count / 2);

------------------------------------------------------------
-- Q6 - Master Wedding Attendance Report 
--purpose: Joins the user identity, bride profile, and guest details for a complete logistics sheet.
------------------------------------------------------------
SELECT 
    E.name AS Bride_Name, 
    B.wedding_date, 
    G.name AS Guest_Name, 
    G.rsvp_status, 
    G.email AS Guest_Email
FROM dbo.EndUser E
JOIN dbo.Bride B 
    ON E.user_id = B.bride_id
JOIN dbo.Guest G 
    ON B.bride_id = G.bride_id
WHERE G.rsvp_status <> 'DECLINED'
ORDER BY B.wedding_date ASC;

------------------------------------------------------------
-- Q7 -  Bride Progress vs. Guest Count Analysis 
-- Combines profile metrics with guest list data to see if brides with more guests are further along in planning.
------------------------------------------------------------
SELECT 
    E.name, 
    B.planning_progress, 
    B.total_guest_count, 
    COUNT(G.guest_id) AS actual_entries
FROM dbo.EndUser E
JOIN dbo.Bride B 
    ON E.user_id = B.bride_id
LEFT JOIN dbo.Guest G 
    ON B.bride_id = G.bride_id
GROUP BY 
    E.name, 
    B.planning_progress, 
    B.total_guest_count;

------------------------------------------------------------
-- Q8 - Invitation Outreach List 
-- purpose: Joins tables to find the contact info for brides whose guests have not been sent an email yet (assuming null email indicates no invite sent).
------------------------------------------------------------
SELECT 
    E.name AS Bride_Name, 
    E.phone_number AS Bride_Phone, 
    G.name AS Guest_Name
FROM dbo.EndUser E
JOIN dbo.Bride B 
    ON E.user_id = B.bride_id
JOIN dbo.Guest G 
    ON B.bride_id = G.bride_id
WHERE G.email IS NULL 
   OR G.email = '';

------------------------------------------------------------
-- Q9 -  Total Estimated Cost of the Guest List per Bride 
-- purpose: calculates the total financial impact of the guest list by multiplying the number of confirmed guests by an assumed average cost per head (e.g., 500 EGP).
------------------------------------------------------------
SELECT 
    bride_id, 
    COUNT(guest_id) AS Confirmed_Attendees,
    COUNT(guest_id) * 500 AS Estimated_Catering_Cost
FROM dbo.Guest
WHERE rsvp_status = 'CONFIRMED'
GROUP BY bride_id;

------------------------------------------------------------
------------- Vendors and appointments queries -------------
------------------------------------------------------------
-- Q1 — Vendor Booking Count
-- Purpose: Shows how many appointments each vendor has received (vendor popularity).
------------------------------------------------------------
SELECT 
    V.vendor_id,
    E.name AS vendor_name,
    COUNT(A.appointment_id) AS total_appointments
FROM dbo.Vendor V
JOIN dbo.EndUser E 
    ON E.user_id = V.vendor_id
LEFT JOIN dbo.Appointment A
    ON A.vendor_id = V.vendor_id
GROUP BY V.vendor_id, E.name
ORDER BY total_appointments DESC;

------------------------------------------------------------
-- Q2 — Vendors With No Appointments
-- Purpose: Identifies vendors that have never been booked (marketing insight).
------------------------------------------------------------
SELECT 
    V.vendor_id,
    E.name AS vendor_name,
    V.service_category
FROM dbo.Vendor V
JOIN dbo.EndUser E 
    ON E.user_id = V.vendor_id
LEFT JOIN dbo.Appointment A
    ON V.vendor_id = A.vendor_id
WHERE A.appointment_id IS NULL;


------------------------------------------------------------
-- Q3 — Appointment Details Report
-- Purpose: Full appointment report including bride name, vendor name, and time slot.
------------------------------------------------------------
SELECT 
    A.appointment_id,
    EB.name AS bride_name,
    EV.name AS vendor_name,
    V.service_category,
    T.slot_date,
    T.start_time,
    T.end_time
FROM dbo.Appointment A
JOIN dbo.Bride B 
    ON A.bride_id = B.bride_id
JOIN dbo.EndUser EB 
    ON EB.user_id = B.bride_id
JOIN dbo.Vendor V 
    ON A.vendor_id = V.vendor_id
JOIN dbo.EndUser EV 
    ON EV.user_id = V.vendor_id
JOIN dbo.TimeSlot T 
    ON A.slot_id = T.slot_id
ORDER BY T.slot_date;


------------------------------------------------------------
-- Q4 — Vendor Rating Summary
-- Purpose: Shows average, min, and max rating per vendor.
------------------------------------------------------------
SELECT
    V.vendor_id,
    E.name AS vendor_name,
    COUNT(R.review_id) AS review_count,
    AVG(R.rating_score) AS avg_rating,
    MIN(R.rating_score) AS min_rating,
    MAX(R.rating_score) AS max_rating
FROM dbo.Vendor V
JOIN dbo.EndUser E 
    ON E.user_id = V.vendor_id
LEFT JOIN dbo.Review R
    ON R.vendor_id = V.vendor_id
GROUP BY V.vendor_id, E.name;

------------------------------------------------------------
-- Q5 — Vendors With Unused Time Slots
-- Purpose: Identifies vendors who have available slots but low booking activity.
------------------------------------------------------------
SELECT
    V.vendor_id,
    E.name AS vendor_name,
    COUNT(T.slot_id) AS available_slots
FROM dbo.Vendor V
JOIN dbo.EndUser E
    ON E.user_id = V.vendor_id
LEFT JOIN dbo.TimeSlot T
    ON T.vendor_id = V.vendor_id
LEFT JOIN dbo.Appointment A
    ON T.slot_id = A.slot_id
WHERE A.appointment_id IS NULL
GROUP BY V.vendor_id, E.name
ORDER BY available_slots DESC;

------------------------------------------------------------
-- Q6 — Brides With Multiple Appointments
-- Purpose: Identifies brides booking multiple vendors (high activity users).
------------------------------------------------------------
SELECT
    A.bride_id,
    E.name AS bride_name,
    COUNT(A.appointment_id) AS appointment_count
FROM dbo.Appointment A
JOIN dbo.EndUser E
    ON E.user_id = A.bride_id
GROUP BY A.bride_id, E.name
HAVING COUNT(A.appointment_id) > 1;


------------------------------------------------------------
-- Q7 — Update Vendor Average Rating
-- Purpose: Recalculates vendor.average_rating based on Review table.
------------------------------------------------------------
UPDATE V
SET average_rating =
(
    SELECT AVG(R.rating_score)
    FROM dbo.Review R
    WHERE R.vendor_id = V.vendor_id
)
FROM dbo.Vendor V;

------------------------------------------------------------
-- Q8 — Mark Timeslots as BOOKED When Appointment Exists
-- Purpose: Keeps TimeSlot status consistent with appointments.
------------------------------------------------------------
UPDATE T
SET slot_status = 'BOOKED'
FROM dbo.TimeSlot T
WHERE EXISTS (
    SELECT 1
    FROM dbo.Appointment A
    WHERE A.slot_id = T.slot_id
);

------------------------------------------------------------
-- Q9 — Vendor Revenue Estimation
-- Purpose: Estimates vendor revenue based on booked checklist items.
------------------------------------------------------------
SELECT
    V.vendor_id,
    E.name AS vendor_name,
    SUM(W.cost) AS estimated_revenue
FROM dbo.Vendor V
JOIN dbo.EndUser E 
    ON E.user_id = V.vendor_id
JOIN dbo.WeddingListItem W
    ON W.vendor_name = E.name
WHERE W.booking_status IN ('BOOKED', 'PAID')
GROUP BY V.vendor_id, E.name;

------------------------------------------------------------
-----------------------GehazItem queries--------------------
------------------------------------------------------------
-- Q1) Purpose: Shows how much each bride spent on gehaz items, compares it to her gehaz_budget, and computes remaining.
------------------------------------------------------------
SELECT 
    B.bride_id,
    E.name AS bride_name,
    B.gehaz_budget,
    COALESCE(SUM(GI.cost), 0) AS total_gehaz_spent,
    (B.gehaz_budget - COALESCE(SUM(GI.cost), 0)) AS remaining_budget
FROM dbo.Bride B
JOIN dbo.EndUser E
    ON E.user_id = B.bride_id
LEFT JOIN dbo.GehazItem GI
    ON GI.bride_id = B.bride_id
GROUP BY B.bride_id, E.name, B.gehaz_budget;



------------------------------------------------------------
-- Q2) Purpose: For each bride, summarize spending by category and number of items in each category.
------------------------------------------------------------
SELECT
    GI.bride_id,
    GI.category,
    COUNT(*) AS item_count,
    SUM(GI.cost) AS category_total_cost,
    AVG(GI.cost) AS avg_item_cost
FROM dbo.GehazItem GI
GROUP BY GI.bride_id, GI.category
ORDER BY GI.bride_id, category_total_cost DESC;


------------------------------------------------------------
-- Q3) Purpose: Finds gehaz items that are "expensive" relative to each bride’s own average.
------------------------------------------------------------
SELECT
    GI.bride_id,
    GI.item_id,
    GI.item_name,
    GI.category,
    GI.gehaz_status,
    GI.cost
FROM dbo.GehazItem GI
WHERE GI.cost > (
        SELECT AVG(GI2.cost)
        FROM dbo.GehazItem GI2
        WHERE GI2.bride_id = GI.bride_id
  )
ORDER BY GI.bride_id, GI.cost DESC;


------------------------------------------------------------
-- Q4) Purpose: For each bride + category, return the max-cost item(s).
------------------------------------------------------------
SELECT
    GI.bride_id,
    GI.category,
    GI.item_id,
    GI.item_name,
    GI.cost
FROM dbo.GehazItem GI
WHERE GI.cost = (
        SELECT MAX(GI2.cost)
        FROM dbo.GehazItem GI2
        WHERE GI2.bride_id = GI.bride_id
          AND GI2.category  = GI.category
  )
ORDER BY GI.bride_id, GI.category;


------------------------------------------------------------
-- Q5) Purpose: Flags brides whose total gehaz spending > gehaz_budget.
------------------------------------------------------------
SELECT
    B.bride_id,
    E.name AS bride_name,
    B.gehaz_budget,
    COALESCE(SUM(GI.cost),0) AS total_gehaz_spent,
    (COALESCE(SUM(GI.cost),0) - B.gehaz_budget) AS over_budget_by
FROM dbo.Bride B
JOIN dbo.EndUser E
    ON E.user_id = B.bride_id
LEFT JOIN dbo.GehazItem GI
    ON GI.bride_id = B.bride_id
GROUP BY B.bride_id, E.name, B.gehaz_budget
HAVING COALESCE(SUM(GI.cost),0) > B.gehaz_budget
ORDER BY over_budget_by DESC;



------------------------------------------------------------
-- Q6) Purpose: Lists not purchased items for ALL brides, and shows not purchased count per bride using a window function.
------------------------------------------------------------
SELECT
    GI.bride_id,
    E.name AS bride_name,
    GI.item_id,
    GI.item_name,
    COUNT(*) OVER (PARTITION BY GI.bride_id) AS pending_items_count
FROM dbo.GehazItem GI
JOIN dbo.Bride B
    ON B.bride_id = GI.bride_id
JOIN dbo.EndUser E
    ON E.user_id = B.bride_id
WHERE GI.gehaz_status = 'Not Purchased'
ORDER BY GI.bride_id, GI.category, GI.cost DESC;


------------------------------------------------------------
-- Q7) Purpose: Sets bride.gehaz_items_progress based on % of items marked 'Purchased'
------------------------------------------------------------
UPDATE B
SET B.gehaz_items_progress =
(
    SELECT
        CASE 
            WHEN COUNT(*) = 0 THEN 0
            ELSE CAST(
                ROUND(
                    100.0 * SUM(CASE WHEN GI.gehaz_status = 'Purchased' THEN 1 ELSE 0 END) / COUNT(*),0)
            AS INT)
        END
    FROM dbo.GehazItem GI
    WHERE GI.bride_id = B.bride_id
)
FROM dbo.Bride B;


------------------------------------------------------------
-- Q8) Purpose: Shows the most expensive gehaz items across all brides, along with bride info
------------------------------------------------------------
SELECT TOP 10
    GI.item_id,
    GI.item_name,
    GI.cost,
    B.bride_id,
    E.name AS bride_name
FROM dbo.GehazItem GI
JOIN dbo.Bride B ON B.bride_id = GI.bride_id
JOIN dbo.EndUser E ON E.user_id = B.bride_id
ORDER BY GI.cost DESC;


------------------------------------------------------------
-- Q9) Purpose: Shows Essential items progress for all brides
------------------------------------------------------------
SELECT
    B.bride_id,
    COALESCE(COUNT(CASE WHEN GI.category = 'Essential' THEN 1 END), 0) 
        AS total_essential_items,
    COALESCE(
        SUM(CASE 
            WHEN GI.category = 'Essential' 
             AND GI.gehaz_status = 'Purchased' 
            THEN 1 ELSE 0 END), 0) AS purchased_essential_items,
    CAST( ROUND( 100.0 * COALESCE( SUM(CASE 
                                       WHEN GI.category = 'Essential' 
                                       AND GI.gehaz_status = 'Purchased' 
                                       THEN 1 ELSE 0 END),0)
            /
            NULLIF(COUNT(CASE WHEN GI.category = 'Essential' THEN 1 END),0),0) AS INT) AS essential_progress_percentage
FROM dbo.Bride B
LEFT JOIN dbo.GehazItem GI
    ON GI.bride_id = B.bride_id
GROUP BY B.bride_id;


------------------------------------------------------------
-- Q10)Purpose: Shows Essential items remaining (Not Purchased)
------------------------------------------------------------
SELECT
    B.bride_id,
    COALESCE(SUM(CASE 
                WHEN GI.category = 'Essential'
                AND GI.gehaz_status = 'Not Purchased'
                THEN 1 ELSE 0 END), 0) AS remaining_essential_items
FROM dbo.Bride B
LEFT JOIN dbo.GehazItem GI
    ON GI.bride_id = B.bride_id
GROUP BY B.bride_id;


------------------------------------------------------------
------------------- WEDDING CHECKLIST QUERIES --------------
------------------------------------------------------------
-- Q1 - View a bride's checklist
------------------------------------------------------------
go CREATE PROCEDURE ViewWeddingChecklist
    @bride_id VARCHAR(10)
AS
BEGIN
    SELECT 
        checklist_id,
        vendor_category,
        vendor_name,
        booking_status,
        cost
    FROM dbo.WeddingListItem
    WHERE bride_id = @bride_id;
END;


------------------------------------------------------------
-- Q2 - Add a new category to a bride's checklist
------------------------------------------------------------
go CREATE PROCEDURE AddChecklistCategory
    @bride_id VARCHAR(10),
    @checklist_id VARCHAR(20),
    @vendor_category VARCHAR(50),
    @vendor_name VARCHAR(100) = NULL,
    @booking_status VARCHAR(20) = 'PENDING',
    @cost DECIMAL(18,2) = 0
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.WeddingListItem (
        checklist_id, bride_id, vendor_category, vendor_name, booking_status, cost
    )
    VALUES (
        @checklist_id, @bride_id, @vendor_category, @vendor_name, @booking_status, @cost
    );
END;
GO

------------------------------------------------------------
-- Q3 - Edit an existing category in the checklist
------------------------------------------------------------
CREATE PROCEDURE EditChecklistCategory
    @bride_id VARCHAR(10),
    @checklist_id VARCHAR(20),
    @vendor_name VARCHAR(100) = NULL,
    @booking_status VARCHAR(20) = NULL,
    @cost DECIMAL(18,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.WeddingListItem
    SET 
        vendor_name = COALESCE(@vendor_name, vendor_name),
        booking_status = COALESCE(@booking_status, booking_status),
        cost = COALESCE(@cost, cost)
    WHERE checklist_id = @checklist_id
      AND bride_id = @bride_id;
END;
GO

------------------------------------------------------------
-- Q4 - Delete a category from a bride's checklist
------------------------------------------------------------
CREATE PROCEDURE DeleteChecklistCategory
    @bride_id VARCHAR(10),
    @checklist_id VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.WeddingListItem
    WHERE checklist_id = @checklist_id
      AND bride_id = @bride_id;
END;
GO

------------------------------------------------------------
--  Q5 - Edit a bride's wedding budget, calculates remaining budget based on booked categories
------------------------------------------------------------

CREATE PROCEDURE EditWeddingBudget
    @bride_id VARCHAR(10),
    @new_budget DECIMAL(18,2)
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the bride's budget
    UPDATE dbo.Bride
    SET wedding_budget = @new_budget
    WHERE bride_id = @bride_id;

    -- Return summary
    SELECT 
        B.wedding_budget AS total_budget,
        ISNULL(SUM(W.cost), 0) AS spent_money,
        B.wedding_budget - ISNULL(SUM(W.cost), 0) AS remaining_budget
    FROM Bride B
    LEFT JOIN WeddingListItem W
        ON B.bride_id = W.bride_id
        AND W.booking_status IN ('BOOKED', 'PAID')
    WHERE B.bride_id = @bride_id
    GROUP BY B.wedding_budget;
END;
GO

------------------------------------------------------------
-- Q6 - Get a bride's checklist summary
-- purpose: Returns progress, total budget, spent money, remaining money.
------------------------------------------------------------
CREATE PROCEDURE GetWeddingChecklistSummary
    @bride_id VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        CAST(
            COUNT(CASE 
                    WHEN booking_status IN ('BOOKED','PAID') 
                    THEN 1 
                 END) * 100.0 
            / COUNT(*) 
        AS DECIMAL(5,2)) AS progress_percentage,
        ISNULL(SUM(cost),0) AS total_budget,
        ISNULL(SUM(CASE WHEN booking_status = 'PAID' THEN cost ELSE 0 END),0) AS spent_money,
        ISNULL(SUM(cost),0) - ISNULL(SUM(CASE WHEN booking_status = 'PAID' THEN cost ELSE 0 END),0) AS remaining_money
    FROM dbo.WeddingListItem
    WHERE bride_id = @bride_id;
END;
GO

------------------------------------------------------------
-----------------------Reviews queries----------------------
------------------------------------------------------------
-- Q1 - Vendors with More Than 5 Reviews
-- purpose: Identifies vendors with a large amount of feedback.
------------------------------------------------------------
SELECT 
    vendor_id,
    COUNT(review_id) AS total_reviews
FROM dbo.Review
GROUP BY vendor_id
HAVING COUNT(review_id) > 5;


------------------------------------------------------------
-- Q2 - Vendors Rated Above the Overall Platform Average
-- purpose: Compares each vendor’s average rating to the global average.
------------------------------------------------------------
SELECT 
    vendor_id,
    AVG(rating_score) AS vendor_avg_rating
FROM dbo.Review
GROUP BY vendor_id
HAVING AVG(rating_score) > (
    SELECT AVG(rating_score)
    FROM dbo.Review
);


------------------------------------------------------------
-- Q3 - Brides Who Submitted More Reviews Than Average
-- purpose: Finds highly active brides based on review submissions.
------------------------------------------------------------
SELECT 
    bride_id,
    COUNT(review_id) AS review_count
FROM dbo.Review
GROUP BY bride_id
HAVING COUNT(review_id) > (
    SELECT AVG(review_count)
    FROM (
        SELECT COUNT(review_id) AS review_count
        FROM dbo.Review
        GROUP BY bride_id
    ) AS AvgReviews
);


------------------------------------------------------------
-- Q4 - Reviews Containing Positive Keywords
-- purpose: Extracts reviews that mention "good" or "great".
------------------------------------------------------------
SELECT 
    review_id,
    vendor_id,
    bride_id,
    rating_score,
    text
FROM dbo.Review
WHERE text LIKE '%good%'
   OR text LIKE '%great%';


------------------------------------------------------------
-- Q5 - Vendor Ratings with Vendor Details
-- purpose: Combines vendor, review, and bride data.
------------------------------------------------------------
SELECT 
    V.vendor_id,
    V.service_category,
    R.rating_score,
    R.text,
    B.bride_id
FROM dbo.Review R
JOIN dbo.Vendor V 
    ON R.vendor_id = V.vendor_id
JOIN dbo.Bride B 
    ON R.bride_id = B.bride_id;


------------------------------------------------------------
-- Q6 - Brides, Their Reviews, and Vendor Categories
-- purpose: Shows which vendor categories brides reviewed. 
------------------------------------------------------------
SELECT 
    B.bride_id,
    V.service_category,
    R.rating_score,
    R.date_submitted
FROM dbo.Bride B
JOIN dbo.Review R 
    ON B.bride_id = R.bride_id
JOIN dbo.Vendor V 
    ON R.vendor_id = V.vendor_id;


------------------------------------------------------------
-- Q7 - Vendors with At Least One Low Rating
-- purpose: Identifies vendors that received poor reviews.
------------------------------------------------------------
SELECT DISTINCT vendor_id
FROM dbo.Review
WHERE vendor_id IN (
    SELECT vendor_id
    FROM dbo.Review
    WHERE rating_score <= 2
);
