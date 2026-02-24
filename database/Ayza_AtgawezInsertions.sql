/* AYZA ATGAWEZ - COMPLETE POPULATION SCRIPT 
   System: Wedding Planning Centralized Hub [cite: 7]
*/

-- 1. ENDUSER TABLE (35 Users total)
INSERT INTO EndUser (user_id, name, email, phone_number, password) VALUES
('U_B01', 'Habiba Mansour', 'habiba@email.com', '01011112222', 'H_Pass123'),
('U_B02', 'Salma El-Sayed', 'salma.s@email.com', '01122223333', 'S_Pass123'),
('U_B03', 'Farida Khaled', 'farida.k@email.com', '01233334444', 'F_Pass123'),
('U_B04', 'Yasmine Tarek', 'yasmine.t@email.com', '01544445555', 'Y_Pass123'),
('U_B05', 'Mona Zaki', 'mona.z@email.com', '01055556666', 'M_Pass123'),
('U_B06', 'Aya Mahmoud', 'aya.m@email.com', '01011110001', 'Aya_Sec_99'),
('U_B07', 'Rawan Hegazi', 'rawan.h@email.com', '01122220002', 'Rawan_P@ss'),
('U_B08', 'Jana Ibrahim', 'jana.i@email.com', '01233330003', 'Jana_12345'),
('U_B09', 'Lina Kassem', 'lina.k@email.com', '01544440004', 'Lina_K_2025'),
('U_B10', 'Hana Soliman', 'hana.s@email.com', '01055550005', 'Hana_Wedding'),
('U_B11', 'Zainab Fawzi', 'zainab.f@email.com', '01166660006', 'Z_Fawzi_77'),
('U_B12', 'Mariam Roushdy', 'mariam.r@email.com', '01277770007', 'M_Roushdy_8'),
('U_B13', 'Fatma Galal', 'fatma.g@email.com', '01588880008', 'Fatma_G_Pass'),
('U_B14', 'Nermin Ali', 'nermin.a@email.com', '01099990009', 'Nermin_101'),
('U_B15', 'Sarah Kamal', 'sarah.k@email.com', '01100001111', 'Sarah_Kamal_X'),
('U_V01', 'Cairo Wedding Hall', 'info@cairohall.com', '01010101010', 'V_Pass001'),
('U_V02', 'Sherif Photo Studio', 'sherif@photo.com', '01111111111', 'V_Pass002'),
('U_V03', 'The Flower Boutique', 'orders@flowers.eg', '01212121212', 'V_Pass003'),
('U_V04', 'Zaffa El-Ahlam', 'zaffa@music.com', '01515151515', 'V_Pass004'),
('U_V05', 'Nour Bridal Makeup', 'nour.makeup@email.com', '01020202020', 'V_Pass005'),
('U_V06', 'Royal Catering', 'chef@royal.com', '01130303030', 'V_Pass006'),
('U_V07', 'Dress Dreamer', 'designs@dresses.com', '01240404040', 'V_Pass007'),
('U_V08', 'DJ Moody', 'dj@moody.com', '01550505050', 'V_Pass008'),
('U_V09', 'Limo Egypt', 'ride@limo.eg', '01060606060', 'V_Pass009'),
('U_V10', 'Jewel Palace', 'sales@jewel.com', '01170707070', 'V_Pass010'),
('U_V11', 'Modern Furnishings', 'sales@modernfurn.eg', '01020203031', 'Furn_Pass_1'),
('U_V12', 'The Wedding Cake Co.', 'chef@cakeco.com', '01130304042', 'Cake_Master_5'),
('U_V13', 'Grand Limo Services', 'info@grandlimo.com', '01240405053', 'Limo_Grand_88'),
('U_V14', 'Sparkle Jewelry', 'sparkle@jewels.com', '01550506064', 'Shiny_Pass_22'),
('U_V15', 'Elite Invitation Cards', 'design@elitecards.eg', '01060607075', 'Card_Design_9'),
('U_V16', 'Sound & Light Egypt', 'tech@soundlight.com', '01170708086', 'Bass_Boost_0'),
('U_V17', 'Elegant Abaya & Veil', 'hijab@elegant.com', '01280809097', 'Veil_E_2026'),
('U_V18', 'Classic Men Suits', 'suits@classic.com', '01590901018', 'Suit_Up_99'),
('U_V19', 'Paradise Honeymoon', 'travel@paradise.com', '01012121313', 'Travel_Fun_7'),
('U_V20', 'Home Tech Electronics', 'support@hometech.eg', '01123232424', 'Volt_Tech_1');

-- 2. BRIDE TABLE (Subtype linking to UserID) [cite: 64]
INSERT INTO Bride (bride_id, wedding_date, planning_progress, gehaz_items_progress, gehaz_budget, total_guest_count, wedding_budget) VALUES
('U_B01', '2026-06-12', 30, 90, 300000.00, 200, 450000.00),
('U_B02', '2026-08-20', 10, 15, 150000.00, 400, 850000.00),
('U_B03', '2026-12-05', 0, 40, 200000.00, 150, 250000.00),
('U_B04', '2025-10-30', 85, 95, 400000.00, 250, 600000.00),
('U_B05', '2026-03-15', 50, 60, 250000.00, 180, 400000.00),
('U_B06', '2026-07-01', 25, 40, 220000.00, 150, 350000.00),
('U_B07', '2026-10-15', 60, 85, 180000.00, 300, 550000.00),
('U_B08', '2027-01-20', 5, 10, 400000.00, 500, 1200000.00),
('U_B09', '2026-04-12', 90, 95, 250000.00, 200, 400000.00),
('U_B10', '2026-11-30', 45, 55, 300000.00, 250, 600000.00),
('U_B11', '2025-12-25', 95, 100, 150000.00, 100, 200000.00),
('U_B12', '2026-09-05', 35, 20, 500000.00, 350, 900000.00),
('U_B13', '2026-02-14', 80, 75, 200000.00, 180, 300000.00),
('U_B14', '2026-08-08', 50, 40, 280000.00, 220, 500000.00),
('U_B15', '2027-05-22', 10, 5, 600000.00, 450, 1500000.00);

-- 3. VENDOR TABLE (Subtype) [cite: 66]
INSERT INTO Vendor (vendor_id, service_category, average_rating, vendor_description, vendor_status, cardholder_name, card_number, exp_date, cvv) VALUES
('U_V01', 'Venue', 4.5, 'Luxury ballroom in New Cairo', 'ACTIVE', 'Sameh Venue', '1111222233334444', '12/28', '123'),
('U_V02', 'Photographer', 4.8, 'Professional outdoor shoots', 'ACTIVE', 'Sherif Kamel', '2222333344445555', '05/27', '456'),
('U_V05', 'Makeup Artist', 4.7, 'Bridal specialist', 'ACTIVE', 'Nour Soliman', '5555666677778888', '01/27', '222'),
('U_V10', 'Jeweler', 4.6, 'Engagement rings', 'ACTIVE', 'Gold Store', '1010202030304040', '11/30', '777'),
('U_V11', 'Furniture', 4.3, 'Modern home sets', 'ACTIVE', 'Ahmed Modern', '1212343456567878', '09/28', '121'),
('U_V12', 'Catering', 4.9, 'Custom multi-tier cakes', 'ACTIVE', 'Chef Layla', '2323454567678989', '12/27', '232'),
('U_V17', 'Dress', 4.8, 'Exclusive bridal veils', 'ACTIVE', 'Elegant Veil', '7878909012123434', '11/27', '787'),
('U_V19', 'Travel', 4.2, 'Honeymoon packages', 'ACTIVE', 'Paradise Travel', '9090121234345656', '04/30', '909');

-- 4. TIMESLOT TABLE [cite: 68]
INSERT INTO TimeSlot (slot_id, vendor_id, slot_date, start_time, end_time, slot_status) VALUES
('S01', 'U_V02', '2026-01-10', '14:00:00', '16:00:00', 'BOOKED'),
('S03', 'U_V05', '2026-02-15', '10:00:00', '12:00:00', 'BOOKED'),
('S07', 'U_V10', '2026-01-18', '11:00:00', '13:00:00', 'BOOKED'),
('S10', 'U_V12', '2026-03-10', '11:30:00', '12:30:00', 'BOOKED'),
('S13', 'U_V19', '2026-05-15', '16:00:00', '18:00:00', 'BOOKED'),
('S15', 'U_V11', '2026-06-12', '10:00:00', '12:00:00', 'BOOKED'),
('S16', 'U_V17', '2026-05-01', '13:00:00', '14:00:00', 'BOOKED'),
('S17', 'U_V01', '2026-04-10', '18:00:00', '22:00:00', 'AVAILABLE'),
('S18', 'U_V02', '2026-01-20', '10:00:00', '12:00:00', 'AVAILABLE'),
('S_TEST01', 'U_V02', '2026-02-01', '15:00:00', '17:00:00', 'AVAILABLE'),
('S_TEST02', 'U_V05', '2026-02-20', '14:00:00', '16:00:00', 'AVAILABLE');


-- 5. APPOINTMENT TABLE (Ternary Relationship) [cite: 79, 80]
INSERT INTO Appointment (appointment_id, slot_id, bride_id, vendor_id) VALUES
('APP_01', 'S01', 'U_B01', 'U_V02'),
('APP_02', 'S03', 'U_B02', 'U_V05'),
('APP_04', 'S07', 'U_B05', 'U_V10'),
('APP_05', 'S10', 'U_B06', 'U_V12'),
('APP_08', 'S15', 'U_B13', 'U_V11'),
('APP_09', 'S16', 'U_B14', 'U_V17'),
('APP_10', 'S17', 'U_B09', 'U_V01'),
('APP_TEST01', 'S_TEST01', 'U_B03', 'U_V02'),
('APP_TEST02', 'S_TEST02', 'U_B01', 'U_V05');


-- 6. REVIEW TABLE [cite: 83, 86]
INSERT INTO Review (review_id, vendor_id, bride_id, [text], rating_score, date_submitted) VALUES
('R01', 'U_V02', 'U_B01', 'Amazing photos!', 5, '2026-01-11'),
('R02', 'U_V05', 'U_B02', 'Good but a bit late.', 4, '2026-02-16'),
('R03', 'U_V10', 'U_B05', 'Beautiful ring design!', 5, '2026-01-19'),
('R04', 'U_V12', 'U_B06', 'Excellent service and taste!', 5, '2026-03-11');


-- 7. GUEST TABLE [cite: 71]
INSERT INTO Guest (guest_id, bride_id, rsvp_status, email, name) VALUES
('G01', 'U_B01', 'CONFIRMED', 'ali@email.com', 'Ali Mansour'),
('G02', 'U_B01', 'PENDING', 'sara@email.com', 'Sara Gad'),
('G04', 'U_B02', 'CONFIRMED', 'tarek@email.com', 'Tarek El-Sayed'),
('G07', 'U_B04', 'CONFIRMED', 'layla@email.com', 'Layla Ibrahim'),
('G10', 'U_B05', 'CONFIRMED', 'zein@email.com', 'Zeinab Ahmed');
--8. GehazItem Table
INSERT INTO GehazItem (item_id, bride_id, item_name, gehaz_status, cost, category) VALUES
('I01', 'U_B01', 'Refrigerator 18ft', 'Not Purchased', 32000.00, 'Essential'),
('I02', 'U_B01', 'Washing Machine', 'Purchased', 25000.00, 'Optional'),
('I12', 'U_B07', 'Gas Stove 5 Burners', 'Not Purchased', 18000.00, 'Essential'),
('I14', 'U_B11', 'Iron Board', 'Purchased', 2800.00, 'Essential'),
('I18', 'U_B14', 'Air Conditioner', 'Purchased', 24000.00, 'Optional'),
('I20', 'U_B13', 'Coffee Machine', 'Purchased', 4200.00, 'Essential'),
('I30', 'U_B01', 'Microwave Oven', 'Purchased', 12000.00, 'Essential'),
('I31', 'U_B01', 'Dishwasher', 'Purchased', 22000.00, 'Optional'),
('I32', 'U_B02', 'Luxury Bedroom Set', 'Purchased', 170000.00, 'Essential');

-- 9. WEDDINGLISTITEM (Default Checklist for ALL Brides)
INSERT INTO WeddingListItem 
(checklist_id, bride_id, vendor_category, booking_status, cost)
SELECT
    CONCAT('CL_', B.bride_id, '_', ROW_NUMBER() OVER (ORDER BY C.vendor_category)),
    B.bride_id,
    C.vendor_category,
    'PENDING',
    0
FROM Bride B
CROSS JOIN (
    SELECT 'Venues' AS vendor_category UNION ALL
    SELECT 'Wedding Dresses' UNION ALL
    SELECT 'Caterers' UNION ALL
    SELECT 'Photographers' UNION ALL
    SELECT 'DJs' UNION ALL
    SELECT 'Giveaways' UNION ALL
    SELECT 'ElShabka' UNION ALL
    SELECT 'Florists' UNION ALL
    SELECT 'Makeup Artists' UNION ALL
    SELECT 'Videographers' UNION ALL
    SELECT 'Hair Stylists' UNION ALL
    SELECT 'Cakes and Desserts' UNION ALL
    SELECT 'Bridal Shoes' UNION ALL
    SELECT 'Veil Designers' UNION ALL
    SELECT 'Food and Beverages'
) C;

-- 10. WEDDINGLISTITEM (Checklist) [cite: 72]
INSERT INTO WeddingListItem (checklist_id, bride_id, vendor_name, vendor_category, booking_status, cost) VALUES
('CL01', 'U_B01', 'Cairo Wedding Hall', 'Venue', 'PENDING', 80000.00),
('CL02', 'U_B01', 'Sherif Photo Studio', 'Photographer', 'BOOKED', 15000.00),
('CL04', 'U_B04', 'Dress Dreamer', 'Dress', 'COMPLETED', 45000.00);