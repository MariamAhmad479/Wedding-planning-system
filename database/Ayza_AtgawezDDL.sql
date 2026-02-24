create database ayza_atgawez;
CREATE TABLE EndUser (
  user_id       VARCHAR(50) PRIMARY KEY,
  name          VARCHAR(100) NOT NULL,
  email         VARCHAR(150) UNIQUE NOT NULL,
  phone_number  VARCHAR(30) UNIQUE,
  password      VARCHAR(255) NOT NULL
);

CREATE TABLE Bride (
  bride_id             VARCHAR(50) PRIMARY KEY,
  wedding_date         DATE,
  planning_progress    INTEGER CHECK (planning_progress BETWEEN 0 AND 100),
  gehaz_items_progress INTEGER CHECK (gehaz_items_progress BETWEEN 0 AND 100),
  gehaz_budget         NUMERIC(12,2) DEFAULT 0 CHECK (gehaz_budget >= 0),
  total_guest_count    INTEGER DEFAULT 0 CHECK (total_guest_count >= 0),
  wedding_budget       NUMERIC(12,2) DEFAULT 0 CHECK (wedding_budget >= 0),

  CONSTRAINT fk_bride_enduser
    FOREIGN KEY (bride_id) REFERENCES EndUser(user_id)
    ON DELETE CASCADE
);

CREATE TABLE Vendor (
  vendor_id          VARCHAR(50) PRIMARY KEY,
  service_category   VARCHAR(50) NOT NULL,
  average_rating     NUMERIC(3,2) DEFAULT 0 CHECK (average_rating BETWEEN 0 AND 5),
  vendor_description TEXT,
  vendor_status      VARCHAR(20) DEFAULT 'ACTIVE',

  -- PaymentMethod is shown as a composite attribute in your ERD
  cardholder_name    VARCHAR(120),
  card_number        VARCHAR(30),
  exp_date           VARCHAR(10),
  cvv                VARCHAR(10),

  CONSTRAINT fk_vendor_enduser
    FOREIGN KEY (vendor_id) REFERENCES EndUser(user_id)
    ON DELETE CASCADE
);

CREATE TABLE TimeSlot (
  slot_id      VARCHAR(50) PRIMARY KEY,
  vendor_id    VARCHAR(50) NOT NULL,

  slot_date    DATE NOT NULL,
  start_time   TIME NOT NULL,
  end_time     TIME NOT NULL,
  slot_status  VARCHAR(20) NOT NULL,

  CONSTRAINT fk_timeslot_vendor
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
    ON DELETE CASCADE,

  CONSTRAINT chk_timeslot_time
    CHECK (end_time > start_time)
);

CREATE TABLE Appointment (
  appointment_id VARCHAR(50) PRIMARY KEY,
  slot_id        VARCHAR(50) NOT NULL,
  bride_id       VARCHAR(50) NOT NULL,
  vendor_id      VARCHAR(50) NOT NULL,

  CONSTRAINT FK_Appointment_Slot
    FOREIGN KEY (slot_id) REFERENCES TimeSlot(slot_id)
    ON DELETE NO ACTION,

  CONSTRAINT fk_appt_bride
    FOREIGN KEY (bride_id) REFERENCES Bride(bride_id)
    ON DELETE CASCADE,

  CONSTRAINT fk_appt_vendor
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
    ON DELETE NO ACTION,

  CONSTRAINT uq_appointment_slot UNIQUE (slot_id)
);


CREATE TABLE Review (
  review_id      VARCHAR(50) PRIMARY KEY,
  vendor_id      VARCHAR(50) NOT NULL,
  bride_id       VARCHAR(50) NOT NULL,
  [text]         VARCHAR(MAX) NULL,
  rating_score   INT NOT NULL CHECK (rating_score BETWEEN 1 AND 5),
  date_submitted DATE NOT NULL CONSTRAINT DF_Review_DateSubmitted DEFAULT CAST(GETDATE() AS DATE),

  CONSTRAINT fk_review_vendor
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
    ON DELETE NO ACTION,

  CONSTRAINT fk_review_bride
    FOREIGN KEY (bride_id) REFERENCES Bride(bride_id)
    ON DELETE CASCADE
);


CREATE TABLE Guest (
  guest_id      VARCHAR(50) PRIMARY KEY,
  bride_id      VARCHAR(50) NOT NULL,

  rsvp_status   VARCHAR(20) NOT NULL,
  email         VARCHAR(150),
  name          VARCHAR(120),

  CONSTRAINT fk_guest_bride
    FOREIGN KEY (bride_id) REFERENCES Bride(bride_id)
    ON DELETE CASCADE
);

CREATE TABLE WeddingListItem (
  checklist_id    VARCHAR(50) PRIMARY KEY,
  bride_id        VARCHAR(50) NOT NULL,

  vendor_name     VARCHAR(150),
  vendor_category VARCHAR(50),
  booking_status  VARCHAR(30),
  cost            NUMERIC(12,2) DEFAULT 0 CHECK (cost >= 0),

  CONSTRAINT fk_weddinglistitem_bride
    FOREIGN KEY (bride_id) REFERENCES Bride(bride_id)
    ON DELETE CASCADE
);

CREATE TABLE GehazItem (
  item_id      VARCHAR(50) PRIMARY KEY,
  bride_id     VARCHAR(50) NOT NULL,

  item_name    VARCHAR(150) NOT NULL,
  gehaz_status VARCHAR(30) NOT NULL,
  cost         NUMERIC(12,2) DEFAULT 0 CHECK (cost >= 0),
  category     VARCHAR(30) NOT NULL,

  CONSTRAINT fk_gehazitem_bride
    FOREIGN KEY (bride_id) REFERENCES Bride(bride_id)
    ON DELETE CASCADE
);

