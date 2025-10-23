
-- schema.sql — Customer Tickets Dashboard
-- Run this in your database (Query Tool in pgAdmin).

CREATE TABLE IF NOT EXISTS agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(100) NOT NULL,
    team VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    plan_tier VARCHAR(20) NOT NULL,
    region VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS tickets (
    ticket_id INT PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    agent_id INT NOT NULL REFERENCES agents(agent_id),
    priority VARCHAR(10) NOT NULL CHECK (priority IN ('Low','Medium','High','Urgent')),
    category VARCHAR(50) NOT NULL,
    status VARCHAR(12) NOT NULL CHECK (status IN ('open','pending','closed','escalated')),
    subject VARCHAR(200),
    created_at TIMESTAMP NOT NULL,
    first_response_at TIMESTAMP,
    closed_at TIMESTAMP,
    sla_first_response_hours INT NOT NULL,
    sla_resolution_hours INT NOT NULL,
    reopened BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS ticket_updates (
    ticket_id INT NOT NULL REFERENCES tickets(ticket_id),
    event_time TIMESTAMP NOT NULL,
    event_type VARCHAR(20) NOT NULL,
    escalation_level INT,
    PRIMARY KEY (ticket_id, event_time, event_type)
);
